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
  $ssl      = '',
  $ssl_ca   = '',
  $ssl_cert = '',
  $ssl_key  = ''
) {

  Class {
    require => Anchor['ldap::server::begin'],
    before  => Anchor['ldap::server::end'],
  }
  
  anchor { 'ldap::server::begin': }
  anchor { 'ldap::server::end': }

  # Perform a validation that SSL is setup properly. 
  if ($ssl == 'true') and (($ssl_cert == '') or ($ssl_key == '') or ($ssl_ca == '')) {
    fail('must supply $ssl_cert/$ssl_key/$ssl_ca for SSL to be enabled')
  }

  if $server_type == 'openldap' {
    class { 'ldap::server::openldap': 
      ssl      => $ssl,
      ssl_ca   => $ssl_ca,
      ssl_cert => $ssl_cert,
      ssl_key  => $ssl_key,
    }
  } elsif $server_type == '389' {
    class { 'ldap::server::389':  }
  } else {
    fail("Invalid LDAP Server Implementation: ${server_type}")
  }
}

