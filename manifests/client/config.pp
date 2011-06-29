define ldap::client::config (
  $ensure = 'present',
  $base_dn,
  $ssl,
  $servers
) {  
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::config::begin': 
    require => Class['ldap::client::base'],
  }
  anchor { 'ldap::client::config::end': 
    notify => Class['ldap::client::service']
  }
  
  Class { 
    base_dn => $base_dn,
    ssl     => $ssl,
    servers => $servers,
    require => Anchor['ldap::client::config::begin'],
    notify  => Anchor['ldap::client::config::end'],
  }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::client::config::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::config::debian':  }
    }
    opensuse,suse: {
      class { 'ldap::client::config::suse': }
    }
  }
}