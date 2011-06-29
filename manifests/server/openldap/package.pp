class ldap::server::openldap::package {

  # Utilize the Anchor Pattern
  anchor { 'ldap::server::openldap::package::begin': }
  anchor { 'ldap::server::openldap::package::end': }
  
  Class {
    require => Anchor['ldap::server::openldap::package::begin'],
    before  => Anchor['ldap::server::openldap::package::end'],
  }
  
  case $operatingsystem {
    centos,fedora,rhel: {
      class { 'ldap::server::openldap::package::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::server::openldap::package::debian': }
    }
    opensuse,suse: {
      class { 'ldap::server::openldap::package::suse': }
    }
  }
}