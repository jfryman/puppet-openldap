class ldap::server::389::package::debian {
  $debian_packages = []
  
  package { $debian_packages:
    ensure => present,
  }
}