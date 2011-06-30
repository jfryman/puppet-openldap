# Class: ldap::server::openldap::service
#
# This module manages LDAP service management
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
class ldap::server::openldap::service {
  service { $ldap::params::lp_openldap_service:
    enable     => 'true',
    ensure     => 'running',
    hasstatus  => 'true',
    hasrestart => 'true',
  }
}