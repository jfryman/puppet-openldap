class ldap::client::config::redhat(
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
    content => template('ldap/client/redhat/nss_pam_ldap.conf.erb'),
  }
  file { '/etc/openldap/ldap.conf':
    ensure  => file,
    content => template('ldap/client/redhat/ldap.conf.erb'), 
  }
}