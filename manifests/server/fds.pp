# Class: ldap::server::fds
#
# This module manages the bootstrap of 389/Fedora Directory Server
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
class ldap::server::fds(
  $ensure = 'present'
) {
  # TODO: package/config/service management.
  anchor { 'ldap::server::fds::begin':
    before => Class['ldap::server::fds::package'],
  }
  
  class { 'ldap::server::fds::package': 
    notify => Class['ldap::server::fds::service'],
  }
  
  class { 'ldap::server::fds::base':
    require => Class['ldap::server::fds::package'],
    notify  => Class['ldap::server::fds::service'],
  }
  
  class { 'ldap::server::fds::service': }
  
  anchor { 'ldap::server::fds::end': 
    require => Class['ldap::server::fds::service'],
  }
}