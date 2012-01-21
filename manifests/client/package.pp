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
)
 {
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::package::begin': }
  anchor { 'ldap::client::package::end': }
  
  Class {
    ensure  => $ensure,
    require => Anchor['ldap::client::package::begin'],
    before  => Anchor['ldap::client::package::end'],
  }

  case $operatingsystem {
    centos,fedora,redhat: {
      class { 'ldap::client::package::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::package::debian': }
    }
    opensuse,suse: {
      class { 'ldap::client::package::suse': }
    }
  }
}