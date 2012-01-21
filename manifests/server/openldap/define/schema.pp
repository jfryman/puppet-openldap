# Define: ldap::server::openldap::schema
#
# This custom definition sets up all of the necessary configuration
# to define custom schema for OpenLDAP. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *source* - Source file for processing by Puppet
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly. Rather, it is called via the
# Proxy definition ldap::define::domain. 
define ldap::server::openldap::define::schema (
  $ensure,
  $source
) {
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::openldap::rebuild'],
    require => Class['ldap::server::openldap::base'],
  }
  
  file { "${ldap::params::lp_tmp_dir}/schema.d/${name}.schema":
    ensure  => $ensure,
    content => "include ${ldap::params::lp_openldap_conf_dir}/schema/${name}.schema\n",
    notify  => Class['ldap::server::openldap::rebuild'],
  }
  
  file { "${ldap::params::lp_openldap_conf_dir}/schema/${name}.schema":
    ensure => $ensure,
    source => $source,
    notify => Class['ldap::server::openldap::service'],
  }
}
