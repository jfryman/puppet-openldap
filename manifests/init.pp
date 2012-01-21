# Class: ldap
#
# This module manages LDAP Server and Clients..
#
# Parameters:
# *client* - Binary Flag (true|false) to configure an LDAP Client 
# *server* - Binary Flag (true|false) to configure an LDAP Server
# *server_type* - (openldap|389) configures different types of 
#                 LDAP servers. Default is OpenLDAP Setup
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
#     server_type => 'openldap',
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
  $ssl_key     = '',
  $server_type = 'openldap'
) {
  include stdlib
  include ldap::params
  
  # Take advantage of the Anchor Pattern.
  anchor { 'ldap::begin': }
  anchor { 'ldap::end': }
  
  Class {
    require => Anchor['ldap::begin'],
    before  => Anchor['ldap::end'],
  }

  # Define Client Specific Information
  if $client == 'true' {
    class { 'ldap::client':
      ensure => 'present',
      ssl    => $ssl,
    }
  }
  
  # Define Server Specific Information
  if $server == 'true' {
    class { 'ldap::server': 
      server_type => $server_type,
      ssl         => $ssl,
      ssl_ca      => $ssl_ca,
      ssl_cert    => $ssl_cert,
      ssl_key     => $ssl_key
    }
  }
}
