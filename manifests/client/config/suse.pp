class ldap::client::config::suse(
  $ensure = 'present',
  $base_dn,
  $ssl,
  $servers  
) {
  file { '/etc/ldap.conf':
    ensure  => file,
    content => template('ldap/client/common/nss_pam_ldap.conf.erb'),
  }
  file { '/etc/openldap/ldap.conf':
    ensure  => file,
    content => template('ldap/client/common/ldap.conf.erb'), 
  }
}