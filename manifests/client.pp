class ldap::client(
  $ensure = 'present'
) {
  # TODO: package/config/service management.
  anchor { 'ldap::client::begin':
    before => Class['ldap::client::package'],
  }
  
  class { 'ldap::client::package': 
    notify => Class['ldap::client::service'],
  }
  
  class { 'ldap::client::base':
    require => Class['ldap::client::package'],
    notify  => Class['ldap::client::service'],
  }
  
  # Fix resource here - how do you link a define with the package/file?
  
  class { 'ldap::client::service': }
  
  anchor { 'ldap::client::end': 
    require => Class['ldap::client::service'],
  }
}