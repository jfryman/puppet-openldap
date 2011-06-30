# Class: ldap::server::389
#
# This module manages the bootstrap of 389 Server
# http://directory.fedoraproject.org/. Sets up the 
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
class ldap::server::389(
  $ensure = 'present'
) {
  # TODO: package/config/service management.
  anchor { 'ldap::server::389::begin':
    before => Class['ldap::server::389::package'],
  }
  
  class { 'ldap::server::389::package': 
    notify => Class['ldap::server::389::service'],
  }
  
  class { 'ldap::server::389::base':
    require => Class['ldap::server::389::package'],
    notify  => Class['ldap::server::389::service'],
  }
  
  class { 'ldap::server::389::service': }
  
  anchor { 'ldap::server::389::end': 
    require => Class['ldap::server::389::service'],
  }
}