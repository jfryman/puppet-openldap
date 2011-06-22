class ldap::server::openldap::package {
  
  # Utilize the Anchor Pattern
  anchor { 'ldap::server::openldap::package::begin': }
  anchor { 'ldap::server::openldap::package::end': }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::server::openldap::package::redhat':
        require => Anchor['ldap::server::openldap::package::begin'],
        before  => Anchor['ldap::server::openldap::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'ldap::server::openldap::package::debian': 
        require => Anchor['ldap::server::openldap::package::begin'],
        before  => Anchor['ldap::server::openldap::package::end'],
      }
    }
    opensuse,suse: {
      class { 'ldap::server::openldap::package::suse':
        require => Anchor['ldap::server::openldap::package::begin'],
        before  => Anchor['ldap::server::openldap::package::end'],
      }
    }
  }
}