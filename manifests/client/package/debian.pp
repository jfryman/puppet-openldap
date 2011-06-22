# Class: ldap::client::package::debian
#
# This module manages LDAP client package installation on Debian based systems
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
class ldap::client::package::debian {
  $debian_packages = []
  
  package { $debian_packages:
    ensure => present,
  }
}