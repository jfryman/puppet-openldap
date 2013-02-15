# Class: ldap::client
#
# This module manages LDAP client Configuration
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
# This class file is not called directly.
class ldap::client(
  $ensure = 'present',
  $ssl
) {
  Class {
    ensure => $ensure,
  }

  class { 'ldap::client::package': }
  -> class { 'ldap::client::base':
    ssl     => $ssl,
  }
  ~> class { 'ldap::client::service': }
  -> Class['ldap::client']
}
