class ldap::server::openldap::service {
  exec { 'rebuild-openldap-domains.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/domains.d/* > ${ldap::params::lp_openldap_conf_dir}/domains.conf",
    refreshonly => 'true',
    group       => $ldap::params::lp_openldap_user,    
    subscribe   => File["${ldap::params::lp_tmp_dir}/domains.d"],
    before      => Service[$ldap::params::lp_openldap_service],
  }
  exec { 'rebuild-openldap-replication.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/replication.d/* > ${ldap::params::lp_openldap_conf_dir}/replication.conf",
    refreshonly => 'true',
    group       => $ldap::params::lp_openldap_user,    
    subscribe   => File["${ldap::params::lp_tmp_dir}/replication.d"],
    before      => Service[$ldap::params::lp_openldap_service],
  }
  exec { 'rebuild-openldap-schema.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/schema.d/* > ${ldap::params::lp_openldap_conf_dir}/schema.conf",
    refreshonly => true,
    group       => $ldap::params::lp_openldap_user,
    subscribe   => File["${ldap::params::lp_tmp_dir}/schema.d"],
    before      => Service[$ldap::params::lp_openldap_service],
  }
  service { $ldap::params::lp_openldap_service:
    enable     => 'true',
    ensure     => 'running',
    hasstatus  => 'true',
    hasrestart => 'true',
  }
}