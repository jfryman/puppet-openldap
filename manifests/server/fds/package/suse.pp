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
class ldap::server::fds::package::suse {
  $suse_packages = []
  
  package { $suse_packages:
    ensure => present,
  }
}