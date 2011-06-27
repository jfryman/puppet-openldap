define ldap::client::config (
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
    ensure  => present,
    content => template('ldap/client/nss_pam_ldap.conf.erb'), 
  }
  
  file { '/etc/openldap/ldap.conf':
    ensure  => present,
    content => template('ldap/client/ldap.conf.erb'),
  }
}