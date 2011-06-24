class ldap::server::openldap(
  $ensure = 'present'
) {
  # TODO: package/config/service management.
  anchor { 'ldap::server::openldap::begin':
    before => Class['ldap::server::openldap::package'],
  }
  
  class { 'ldap::server::openldap::package': 
    notify => Class['ldap::server::openldap::service'],
  }
  
  class { 'ldap::server::openldap::base':
    require => Class['ldap::server::openldap::package'],
    notify  => Class['ldap::server::openldap::service'],
  }
  
  class { 'ldap::server::openldap::service': }
  
  anchor { 'ldap::server::openldap::end': 
    require => Class['ldap::server::openldap::service'],
  } 
}