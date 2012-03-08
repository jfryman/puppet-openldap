# Class: ldap
#
# This module manages LDAP Server and Clients.
#
# Parameters:
# *client* - Binary Flag (true|false) to configure an LDAP Client
# *server* - Binary Flag (true|false) to configure an LDAP Server
# *ssl*         - (true|false) - enable SSL Support. *IN DEVELOPMENT*
#
# Actions:
#
# Requires:
#  puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
#
#  Packaged LDAP
#    - RHEL: EPEL or custom package
#    - Debian/Ubuntu: Default Install or custom package
#    - SuSE: Default Install or custom package
#
# Sample Usage:
#
# Setup (Bootstrap) and Configuration of this module are currently 
# separated in order to allow for multiple LDAP server definitions
# and multiple LDAP Trees being managed.
#
# Bootstrap:
# node 'server.puppetlabs.test' {
#   class { 'ldap':
#     server      => 'true',
#     ssl         => 'false',
#   }
# }
# node 'client.puppetlabs.test' {
#   class {'ldap':
#     client  => 'true',
#     ssl     => 'false',
#   }
# }
#
# Server Configuration:
# ldap::define::domain {'puppetlabs.test':
#   basedn   => 'dc=puppetlabs,dc=test',
#   rootdn   => 'cn=admin',
#   rootpw   => 'test',
# }
# 
# Client Configuration:
# ldap::client::config { 'puppetlabs.test':
#   ensure  => 'present',
#   servers => 'server',
#   ssl     => 'false',
#   base_dn => 'dc=puppetlabs,dc=test',
# }
class ldap(
  $client      = 'false',
  $server      = 'false',
  $ssl         = 'false',
  $ssl_ca      = '',
  $ssl_cert    = '',
  $ssl_key     = ''
) {
  include stdlib
  include ldap::params

  # Take advantage of the Anchor Pattern.
  anchor { 'ldap::begin': }
  -> anchor { 'ldap::begin::client': }
  -> anchor { 'ldap::end::client': }
  -> anchor { 'ldap::begin::server': }
  -> anchor { 'ldap::end::server': }
  -> anchor { 'ldap::end': }

  # Define Client Specific Information
  if $client == 'true' {
    class { 'ldap::client':
      ensure => 'present',
      ssl    => $ssl,
      require => Anchor['ldap::begin::client'],
      before  => Anchor['ldap::end::client'],
    }
  }

  # Define Server Specific Information
  if $server == 'true' {
    class { 'ldap::server': 
      ssl         => $ssl,
      ssl_ca      => $ssl_ca,
      ssl_cert    => $ssl_cert,
      ssl_key     => $ssl_key,
      require     => Anchor['ldap::begin::server'],
      before      => Anchor['ldap::end::server'],
    }
  }
}
