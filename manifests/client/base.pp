class ldap::client::base(
  $ensure,
  $ssl
)
 {
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::base::begin': }
  anchor { 'ldap::client::base::end': }
  
  Class { 
    ensure  => $ensure,
    ssl     => $ssl,
    require => Anchor['ldap::client::base::begin'],
    before  => Anchor['ldap::client::base::end'],
  }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::client::base::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::base::debian':  }
    }
    opensuse,suse: {
      class { 'ldap::client::base::suse': }
    }
  }
}