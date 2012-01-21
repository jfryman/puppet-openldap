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
class ldap::server::fds::package::debian {
  $debian_packages = []
  
  package { $debian_packages:
    ensure => present,
  }
}