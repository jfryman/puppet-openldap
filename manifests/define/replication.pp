# Class:
#
# Description
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

## UNDER CONSTRUCTION
define ldap::define::replication (
  $ensure
) {
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::openldap::service'],
    require => Class['ldap::server::openldap::base'],
  }

  $directory_ensure = $ensure ? {
    'present' => 'directory',
    'absent'  => 'absent',
  }

  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog":
    ensure => $directory_ensure,
    mode   => '0770',
    owner  => $ldap::params::lp_daemon_user,
  }
  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog/DB_CONFIG":
    ensure  => $ensure,
    mode    => '0660',
    content => template('ldap/server/openldap/DB_CONFIG.erb')
  }
}
