# Define: ldap::server::openldap::domain
#
# This custom definition sets up all of the necessary configuration
# Files to bootstrap a LDAP tree. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *basedn* - Base DN for setting up the LDAP server. 
# *rootdn* - Base DN for the administrator acount on an LDAP server.
# *rootpw* - Password for the administrator account. Will accept any valid
#          - Hashed (crypt|(s)md5|(s)sha) or plaintext password. 
#
# Actions:
#
# This definition acts as a proxy class to various server implementations
# 
# Requires:
#
# Sample Usage:
# Server Configuration:
# ldap::define::domain {'puppetlabs.test':
#   basedn   => 'dc=puppetlabs,dc=test',
#   rootdn   => 'cn=admin',
#   rootpw   => 'test',
# } 
define ldap::define::domain(
  $ensure = 'present',
  $basedn,
  $rootdn,
  $rootpw
){
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    require => Class['ldap::server::config'],
    before  => Class['ldap::server::rebuild'],
  }

  $directory_ensure = $ensure ? {
    'present' => 'directory',
    'absent'  => 'absent',
  }

  # Setup the 'include' definition in part of the file fragment
  # to include the definition in OpenLDAP configuration
  file { "${ldap::params::lp_tmp_dir}/domains.d/${name}.conf":
    ensure  => $ensure,
    content => "include ${ldap::params::lp_openldap_conf_dir}/domains/${name}.conf\n",
    notify  => Class['ldap::server::rebuild'],
  }

  # Setup the *actual* configuration file for OpenLDAP
  file { "${ldap::params::lp_openldap_conf_dir}/domains/${name}.conf":
    ensure  => $ensure,
    content => template('ldap/server/openldap/domain_template.erb'),
    notify  => Class['ldap::server::service'],
  }

  # Create a blank ACL file for later reference.
  file { "${ldap::params::lp_openldap_conf_dir}/domains/${name}-acl.conf":
    ensure  => $ensure,
    notify  => Class['ldap::server::service'],
  }

  # Create a Database Directory for the LDAP Server to live in
  file { "${ldap::params::lp_openldap_var_dir}/${name}":
    ensure  => $directory_ensure,
    owner   => $ldap::params::lp_daemon_user,
    group   => $ldap::params::lp_daemon_group,
    recurse => 'true',
  }

  ## Setup Initial OpenLDAP Database
  file { "${ldap::params::lp_openldap_var_dir}/${name}/DB_CONFIG":
    ensure  => $ensure,
    mode    => '0660',
    content => template('ldap/server/openldap/DB_CONFIG.erb'),
  }

  file { "${ldap::params::lp_openldap_var_dir}/${name}/base.ldif":
    ensure  => $ensure,
    owner   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/base.ldif.erb'),
    notify  => Exec["bootstrap-ldap-${name}"],
  }

  exec { "bootstrap-ldap-${name}":
    command   => "slapadd -b \"${basedn}\" -v -l ${ldap::params::lp_openldap_var_dir}/${name}/base.ldif",
    path      => '/bin:/sbin:/usr/bin:/usr/sbin',
    user      =>  $ldap::params::lp_daemon_user,
    group     =>  $ldap::params::lp_daemon_group,
    logoutput => 'true',
    creates   => "${ldap::params::lp_openldap_var_dir}/${name}/id2entry.bdb",
    require   => Class['ldap::server::rebuild'],
    before    => Class['ldap::server::service'],
  }
}
