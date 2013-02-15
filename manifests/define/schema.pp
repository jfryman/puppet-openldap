# Define: ldap::server::openldap::domain
#
# This custom definition sets up all of the necessary configuration
# Files to include custom schema in OpenLDAP. This uses the File-Fragment
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
# This definition acts as a proxy class to various server implementations
#
# Requires:
#
# Sample Usage:
# Server Configuration:
# ldap::define::schema { 'websages':
#   ensure => 'present',
#   source => 'puppet:///modules/ldap/schema/websages.schema',
# }
define ldap::define::schema(
  $ensure = 'present',
  $source = undef,
) {
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::rebuild'],
    require => Class['ldap::server::config'],
  }

  file { "${ldap::params::lp_tmp_dir}/schema.d/${name}.schema":
    ensure  => $ensure,
    content => "include ${ldap::params::lp_openldap_conf_dir}/schema/${name}.schema\n",
    notify  => Class['ldap::server::rebuild'],
  }

  file { "${ldap::params::lp_openldap_conf_dir}/schema/${name}.schema":
    ensure => $ensure,
    source => $source,
    notify => Class['ldap::server::service'],
  }
}
