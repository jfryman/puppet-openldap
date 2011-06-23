define ldap::server::openldap::define::domain (
  $ensure,
  $basedn,
  $rootdn,
  $rootpw
) {
  File {
    owner => 'root',
    group => "${ldap::params::lp_daemon_user}",
    mode  => '0440',
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
  file { "${ldap::params::lp_openldap_var_dir}/${name}.conf":
    ensure => directory,
    mode   => '0770',
  }
}