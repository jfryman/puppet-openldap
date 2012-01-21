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
class ldap::server::fds::package::redhat {
  $redhat_packages = []
  
  package { $redhat_packages:
    ensure => present,
  }
}