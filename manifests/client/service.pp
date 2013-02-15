# Class: ldap::client::service
#
# This module manages LDAP Client service management
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
class ldap::client::service(
  $ensure
) {

  # TODO: Need to add a translation between passed 'ensure' to this service
  # state

  service { 'nscd':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
