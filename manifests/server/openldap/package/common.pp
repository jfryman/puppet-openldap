class ldap::server::openldap::package::common {
  user { $ldap::params::lp_daemon_user:
    ensure  => 'present',
    uid     => $ldap::params::lp_daemon_uid,
    gid     => $ldap::params::lp_daemon_gid,
    comment => 'LDAP User',
    home    => $ldap::params::lp_openldap_var_dir,
    shell   => '/bin/false',
  }
  group { $ldap::params::lp_daemon_user:
    ensure => 'present',
    gid    => $ldap::params::lp_daemon_gid,
  }
}
