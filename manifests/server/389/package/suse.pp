class ldap::server::389::package::suse {
  $suse_packages = []
  
  package { $suse_packages:
    ensure => present,
  }
}