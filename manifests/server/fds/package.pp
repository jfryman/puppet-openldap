# Class: 
#
# Description
#
# Parameters:
#   
# Actions:
#
# Requires:
#
# Sample Usage:
#
class ldap::server::fds::package {
  
  # Utilize the Anchor Pattern
  anchor { 'ldap::server::fds::package::begin': }
  anchor { 'ldap::server::fds::package::end': }

  case $operatingsystem {
    centos,fedora,redhat: {
      class { 'ldap::server::fds::package::redhat':
        require => Anchor['ldap::server::fds::package::begin'],
        before  => Anchor['ldap::server::fds::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'ldap::server::fds::package::debian': 
        require => Anchor['ldap::server::fds::package::begin'],
        before  => Anchor['ldap::server::fds::package::end'],
      }
    }
    opensuse,suse: {
      class { 'ldap::server::fds::package::suse':
        require => Anchor['ldap::server::fds::package::begin'],
        before  => Anchor['ldap::server::fds::package::end'],
      }
    }
  }
}