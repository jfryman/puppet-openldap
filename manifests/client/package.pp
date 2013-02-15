# Class: ldap::client::package
#
# This module manages package installation of LDAP PAM/NSS Libraries, based on
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
class ldap::client::package(
  $ensure
) {
  include ldap::params

  package { $ldap::params::openldap_client_packages:
    ensure => $ensure,
  }
}
