# Class: ldap::server
#
# This module manages LDAP Server Configuration 
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
class ldap::server(
  $server_type,
  $ssl
) {
  
  Class {
    require => Anchor['ldap::server::begin'],
    before  => Anchor['ldap::server::end'],
  }
  
  anchor { 'ldap::server::begin': }
  anchor { 'ldap::server::end': }
    
  if $server_type == 'openldap' {
    class { 'ldap::server::openldap': }
  } elsif $server_type == '389' {
    class { 'ldap::server::389': }
  } else {
    fail("Invalid LDAP Server Implementation: ${server_type}")
  }
}

