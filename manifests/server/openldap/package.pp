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
class ldap::server::openldap::package(
  $ssl
) {

  # Utilize the Anchor Pattern
  anchor { 'ldap::server::openldap::package::begin': }
  anchor { 'ldap::server::openldap::package::end': }
  
  Class {
    require => Anchor['ldap::server::openldap::package::begin'],
    before  => Anchor['ldap::server::openldap::package::end'],
  }

  class { 'ldap::server::openldap::package::common': }

  case $operatingsystem {
    centos,fedora,redhat: {
      class { 'ldap::server::openldap::package::redhat': 
        require +> Class['ldap::server::openldap::package::common'],
      }
    }
    debian,ubuntu: {
      class { 'ldap::server::openldap::package::debian': 
         ssl => $ssl,
         require +> Class['ldap::server::openldap::package::common'],
      }
    }
    opensuse,suse: {
      class { 'ldap::server::openldap::package::suse': 
        require +> Class['ldap::server::openldap::package::common'],
      }
    }
  }
}
