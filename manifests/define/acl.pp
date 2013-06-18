define ldap::define::acl(
  $domain,
  $access,
  $ensure = 'present',
  $order  = '000'
){
  File {
    owner   => 'root',
    group   => $ldap::params::lp_daemon_group,
    before  => Class['ldap::server::rebuild'],
    require => Class['ldap::server::config'],
  }

  include ldap::params

  # Set a unique name for the configuration entity to be created
  # Cannot include some OpenLDAP ACL specific entries as a file system label.
  $unique_name = md5($name)

  file {
    "${ldap::params::lp_tmp_dir}/acl.d/${domain}-${order}-${unique_name}.conf":
    ensure  => $ensure,
    content => template('ldap/server/openldap/acl_template.erb'),
    notify  => Class['ldap::server::rebuild'],
  }
}
