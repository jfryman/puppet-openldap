class ldap::client::config::debian(
  $ensure = 'present',
  $base_dn,
  $ssl,
  $servers
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  file { '/etc/ldap.conf':
    ensure  => file,
    content => template('ldap/client/common/nss_pam_ldap.conf.erb'),
  }
  file { '/etc/ldap/ldap.conf':
    ensure  => file,
    content => template('ldap/client/common/ldap.conf.erb'), 
  }
}