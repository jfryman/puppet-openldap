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
  
  # Take advantage of the Anchor Pattern.
  anchor { 'ldap::begin': }
  anchor { 'ldap::end': }

  # Define Client Specific Information
  if $client == 'true' {
    class { 'ldap::client':
      ensure => 'present',
      require => Anchor['ldap::begin'],
      before  => Anchor['ldap::end'],
    }
  }
  
  # Define Server Specific Information
  if $server == 'true' {
    class { 'ldap::server': 
      server_type => $server_type,
      require     => Anchor['ldap::begin'],
      before      => Anchor['ldap::end'],
    }
  }
}