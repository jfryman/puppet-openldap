class ldap::server::openldap::service {
  service { $ldap::params::lp_openldap_service:
    enable     => 'true',
    ensure     => 'running',
    hasstatus  => 'true',
    hasrestart => 'true',
  }
}