class ldap::server::389::package {
  
  # Utilize the Anchor Pattern
  anchor { 'ldap::server::389::package::begin': }
  anchor { 'ldap::server::389::package::end': }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::server::389::package::redhat':
        require => Anchor['ldap::server::389::package::begin'],
        before  => Anchor['ldap::server::389::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'ldap::server::389::package::debian': 
        require => Anchor['ldap::server::389::package::begin'],
        before  => Anchor['ldap::server::389::package::end'],
      }
    }
    opensuse,suse: {
      class { 'ldap::server::389::package::suse':
        require => Anchor['ldap::server::389::package::begin'],
        before  => Anchor['ldap::server::389::package::end'],
      }
    }
  }
}