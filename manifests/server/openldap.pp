# Class: ldap::server::openldap
#
# This module manages the bootstrap of OpenLDAP Server
# http://www.openldap.org/. Sets up the 
# Package-File-Service design pattern.
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
class ldap::server::openldap(
  $ensure = 'present',
  $ssl,
  $ssl_ca,
  $ssl_cert,
  $ssl_key
) {
  # TODO: package/config/service management.
  anchor { 'ldap::server::openldap::begin':
    before => Class['ldap::server::openldap::package'],
  }
  
  class { 'ldap::server::openldap::package': 
    notify => Class['ldap::server::openldap::service'],
  }
  
  class { 'ldap::server::openldap::base':
    ssl      => $ssl,
    ssl_ca   => $ssl_ca,
    ssl_cert => $ssl_cert,
    ssl_key  => $ssl_key,
    require  => Class['ldap::server::openldap::package'],
    notify   => Class['ldap::server::openldap::rebuild'],
  }
  
  class { 'ldap::server::openldap::rebuild':
    require => Class['ldap::server::openldap::base'],
    notify  => Class['ldap::server::openldap::service']
  }
  
  class { 'ldap::server::openldap::service': }
  
  anchor { 'ldap::server::openldap::end': 
    require => Class['ldap::server::openldap::service'],
  } 
}
