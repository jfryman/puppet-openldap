class ldap::server::openldap::package::suse {
  $suse_packages = ['openldap2', 'libltdl7', 'openldap2-back-meta']
  
  @package { $suse_packages:
    ensure => present,
    tag    => 'suse-openldap-server',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'suse-openldap-server' |>
}