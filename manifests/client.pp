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
  $ssl = false
) {

  include ldap::client::package
  class { 'ldap::client::base':
    ensure    => $ensure,
    ssl       => $ssl,
  }
  class { 'ldap::client::service':
    subscribe => [
      Class['ldap::client::base'],
      Class['ldap::client::package'],
    ],
  }
}
