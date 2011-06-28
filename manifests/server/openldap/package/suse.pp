class ldap::server::openldap::package::suse {
  $suse_packages = ['openldap2', 'libltdl7', 'openldap2-back-meta']
  
  package { $suse_packages:
    ensure => present,
  }
}