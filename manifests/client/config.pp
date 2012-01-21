# Define: ldap::client::config
#
# This custom definition sets up all of the necessary configuration
# Files to configure a cleint to AAA against LDAP servers. Routing is 
# performed based on operating system. 
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *basedn* - Base DN for setting up the LDAP server. 
# *servers* - Array of servers that can be connected to 
#
# Actions:
#
# 
# Requires:
#
# Sample Usage:
# Client Configuration:
# ldap::client::config { 'puppetlabs.test':
#   ensure  => 'present',
#   servers => ['server-1', 'server-2'],
#   ssl     => 'false',
#   base_dn => 'dc=puppetlabs,dc=test',
# }
define ldap::client::config (
  $ensure = 'present',
  $base_dn,
  $ssl,
  $servers
) {  
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::config::begin': 
    require => Class['ldap::client::base'],
  }
  anchor { 'ldap::client::config::end': 
    notify => Class['ldap::client::service']
  }
  
  Class { 
    base_dn => $base_dn,
    ssl     => $ssl,
    servers => $servers,
    require => Anchor['ldap::client::config::begin'],
    notify  => [
      Anchor['ldap::client::config::end'],
      Class['ldap::client::service'],
    ],
  }

  case $operatingsystem {
    centos,fedora,redhat: {
      class { 'ldap::client::config::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::config::debian':  }
    }
    opensuse,suse: {
      class { 'ldap::client::config::suse': }
    }
  }
}