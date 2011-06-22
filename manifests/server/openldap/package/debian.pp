class ldap::server::openldap::package::debian {
  $debian_packages = []
  
  package { $debian_packages:
    ensure => present,
  }
}