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
  $ssl       = false,
  $ssl_ca    = '',
  $ssl_cert  = '',
  $ssl_key   = '',
  $cn_config = undef,
  $rootdn    = undef,
  $rootpw    = undef,
) {
  anchor { 'ldap::server::begin': }
  class { 'ldap::server::package':
    ssl     => $ssl,
    require => Anchor['ldap::server::begin'],
  }
  class { 'ldap::server::config':
    ssl       => $ssl,
    ssl_ca    => $ssl_ca,
    ssl_cert  => $ssl_cert,
    ssl_key   => $ssl_key,
    cn_config => $cn_config,
    rootdn    => $rootdn,
    rootpw    => $rootpw,
    require   => Class['ldap::server::package'],
  }
  class { 'ldap::server::rebuild':
    require => Class['ldap::server::config'],
  }
  class { 'ldap::server::service':
    require => Class['ldap::server::rebuild'],
    before  => Anchor['ldap::server::end'],
  }
  anchor { 'ldap::server::end': }
}

