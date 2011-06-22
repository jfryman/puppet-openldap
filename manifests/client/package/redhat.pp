# Class: ldap::client::package::redhat
#
# This module manages LDAP client package installation on RHEL based systems
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
class ldap::client::package::redhat {
  $redhat_packages = ['openldap', 'openldap-clients', 'nss_ldap']
  
  package { $redhat_packages:
    ensure => present,
  }
}