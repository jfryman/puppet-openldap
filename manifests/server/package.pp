# Class: ldap::server::openldap::package
#
# This module manages package installation of OpenLDAP, based on
# operating system.
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class ldap::server::package(
  $ssl = undef
) {

  # Manage the User and Group
  user { $ldap::params::lp_daemon_user:
    ensure  => 'present',
    uid     => $ldap::params::lp_daemon_uid,
    gid     => $ldap::params::lp_daemon_gid,
    comment => 'LDAP User',
    home    => $ldap::params::lp_openldap_var_dir,
    shell   => '/bin/false',
    before  => Package[$ldap::params::openldap_packages],
  }
  group { $ldap::params::lp_daemon_user:
    ensure => 'present',
    gid    => $ldap::params::lp_daemon_gid,
    before => Package[$ldap::params::openldap_packages],
  }

  package { $ldap::params::openldap_packages:
    ensure => present,
  }

  ## This section modifies the /etc/default file to allow for
  ## slapd.conf configuration as opposed to the cn=config
  ## configuration and setup. This section will be removed once
  ## configuration is migrated to cn=config
  if $::operatingsystem == 'Ubuntu' {
    file {'/etc/default/slapd':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('ldap/server/openldap/slapd_default.erb'),
      require => Package[$ldap::params::openldap_packages],
    }
  }
}
