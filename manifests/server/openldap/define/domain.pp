define ldap::server::openldap::define::domain (
  $ensure,
  $basedn,
  $rootdn,
  $rootpw
) {
  File {
    owner => 'root',
    group => $ldap::params::lp_daemon_group,
    mode  => '0660',
    require => Class['ldap::server::openldap::base'],
    before  => Class['ldap::server::openldap::service'],
  }
  
  # Setup the 'include' definition in part of the file fragment
  # to include the definition in OpenLDAP configuration
  file { "${ldap::params::lp_tmp_dir}/domains.d/${name}.conf":
    ensure  => $ensure,
    content => "include ${ldap::params::lp_openldap_conf_dir}/domains/${name}.conf\n",
    notify  => Exec['rebuild-openldap-domains.conf'],
  }
  
  # Setup the *actual* configuration file for OpenLDAP
  file { "${ldap::params::lp_openldap_conf_dir}/domains/${name}.conf":
    ensure  => $ensure,
    content => template('ldap/server/openldap/domain_template.erb'),
    notify  => Service[$ldap::params::lp_openldap_service],
  }
  
  # Create a Database Directory for the LDAP Server to live in
  file { "${ldap::params::lp_openldap_var_dir}/${name}":
    ensure  => directory,
    owner   => $ldap::params::lp_daemon_user,
    recurse => 'true',
  }
  
  ## Setup Initial Database
  file { "${ldap::params::lp_openldap_var_dir}/${name}/DB_CONFIG":
    ensure  => file,
    mode    => '0660',
    content => template('ldap/server/openldap/DB_CONFIG.erb'),
  }
  file { "${ldap::params::lp_openldap_var_dir}/${name}/base.ldif":
    ensure  => file,
    content => template('ldap/server/openldap/base.ldif.erb'), 
    notify  => Exec["bootstrap-ldap-${name}"],
  }
  
  exec { "bootstrap-ldap-${name}":
    command   => "slapadd -b \"${basedn}\" -v -l ${ldap::params::lp_openldap_var_dir}/${name}/base.ldif",
    path      => '/bin:/sbin:/usr/bin:/usr/sbin',
    creates   => "${ldap::params::lp_openldap_var_dir}/${name}/id2entry.bdb",
    logoutput => 'true',
  }
  
  ## Setup Replication Database (Move this to Replication)
  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog":
    ensure => directory,
    mode   => '0770',
    owner  => $ldap::params::lp_daemon_user,
  }
  file { "${ldap::params::lp_openldap_var_dir}/${name}/accesslog/DB_CONFIG":
    ensure  => file,
    mode    => '0660',
    owner   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/DB_CONFIG.erb')
  }
}