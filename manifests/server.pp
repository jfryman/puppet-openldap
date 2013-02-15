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
  $ssl      = '',
  $ssl_ca   = '',
  $ssl_cert = '',
  $ssl_key  = ''
) {
  anchor { 'ldap::server::begin': }
  -> class { 'ldap::server::package':
    ssl => $ssl,
  }
  -> class { 'ldap::server::config':
    ssl      => $ssl,
    ssl_ca   => $ssl_ca,
    ssl_cert => $ssl_cert,
    ssl_key  => $ssl_key,
  }
  -> class { 'ldap::server::rebuild': }
  -> class { 'ldap::server::service': }
  -> anchor { 'ldap::server::end': }
}

