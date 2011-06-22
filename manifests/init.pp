# Class: ldap
#
# This module manages ldap
#
# Parameters:
#
# Actions:
#
# Requires:
#  [puppetlabs-stdlib]
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class ldap(
  $client = 'false',
  $server = 'false',
  $server_type = 'openldap'
) {
  include stdlib
  include ldap::params
  
  anchor { 'ldap::begin': }
  anchor { 'ldap::end': }

  if $client == 'true' {
    class { 'ldap::client':
      ensure => 'present',
    }
  } elsif $server == 'true' {
    class { 'ldap::server': 
      server_type => $server_type,
    }
  }
}
