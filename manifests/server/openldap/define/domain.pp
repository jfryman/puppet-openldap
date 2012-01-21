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
# Requires:
#
# Sample Usage:
#
# This class file is not called directly. Rather, it is called via the
# Proxy definition ldap::define::domain. 
define ldap::server::openldap::define::domain (
  $ensure,
  $basedn,
  $rootdn,
  $rootpw
) {
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::openldap::rebuild'],
    require => Class['ldap::server::openldap::base'],
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
    notify  => Class['ldap::server::openldap::rebuild'],
  }
  
  # Setup the *actual* configuration file for OpenLDAP
  file { "${ldap::params::lp_openldap_conf_dir}/domains/${name}.conf":
    ensure  => $ensure,
    content => template('ldap/server/openldap/domain_template.erb'),
    notify  => Service[$ldap::params::lp_openldap_service],
  }
  
  # Create a blank ACL file for later reference.
  file { "${ldap::params::lp_openldap_conf_dir}/domains/${name}-acl.conf":
    ensure  => $ensure,
    notify  => Service[$ldap::params::lp_openldap_service],
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
    require   => Class['ldap::server::openldap::rebuild'],
    before    => Class['ldap::server::openldap::service'],
  }
}