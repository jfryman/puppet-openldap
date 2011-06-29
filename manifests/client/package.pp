class ldap::client::package(
  $ensure
)
 {
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::package::begin': }
  anchor { 'ldap::client::package::end': }
  
  Class {
    ensure  => $ensure,
    require => Anchor['ldap::client::package::begin'],
    before  => Anchor['ldap::client::package::end'],
  }

  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::client::package::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::package::debian': }
    }
    opensuse,suse: {
      class { 'ldap::client::package::suse': }
    }
  }
}