class ldap::client::service {
  service { 'nscd':
    enable     => 'true',
    ensure     => 'running',
    hasrestart => 'true',
    hasstatus  => 'true',
  }
}