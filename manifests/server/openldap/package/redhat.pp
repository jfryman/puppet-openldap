class ldap::server::openldap::package::redhat {
  $redhat_packages = ['openldap', 'openldap-servers', 'openldap-clients']
  
  package { $redhat_packages:
    ensure => present,
  }
}