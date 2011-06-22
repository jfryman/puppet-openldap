class ldap::server::openldap::package::redhat {
  $redhat_packages = []
  
  package { $redhat_packages:
    ensure => present,
  }
}