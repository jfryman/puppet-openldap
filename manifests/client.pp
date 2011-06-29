class ldap::client(
  $ensure = 'present',
  $ssl
) {
  
  Class {
    ensure => $ensure,
  }
  
  # TODO: package/config/service management.
  anchor { 'ldap::client::begin':
    before => Class['ldap::client::package'],
  }
  
  class { 'ldap::client::package': 
    notify => Class['ldap::client::service'],
  }
  
  class { 'ldap::client::base':
    ssl     => $ssl,
    require => Class['ldap::client::package'],
  }
  
  class { 'ldap::client::service': 
    subscribe => Class['ldap::client::base'],
  }
  
  anchor { 'ldap::client::end': 
    require => Class['ldap::client::service'],
  }
}