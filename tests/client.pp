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

class {'ldap':
  client  => 'true',   
}

ldap::client::config { 'frymanet.com':
  ensure  => 'present',
  servers => ['xenon.frymanet.com', 'argon.frymanet.com'],
  ssl     => 'false',
  base_dn => 'dc=frymanet,dc=com',
}