class ldap::server::389::package::redhat {
  $redhat_packages = []
  
  package { $redhat_packages:
    ensure => present,
  }
}