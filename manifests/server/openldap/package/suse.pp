class ldap::server::openldap::package::suse {
  $suse_packages = []
  
  package { $suse_packages:
    ensure => present,
  }
}