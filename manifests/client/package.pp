class ldap::client::package {
  
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::package::begin': }
  anchor { 'ldap::client::package::end': }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::client::package::redhat':
        require => Anchor['ldap::client::package::begin'],
        before  => Anchor['ldap::client::package::end'],
      }
    }
    debian,ubuntu: {
      class { 'ldap::client::package::debian': 
        require => Anchor['ldap::client::package::begin'],
        before  => Anchor['ldap::client::package::end'],
      }
    }
    opensuse,suse: {
      class { 'ldap::client::package::suse':
        require => Anchor['ldap::client::package::begin'],
        before  => Anchor['ldap::client::package::end'],
      }
    }
  }
}