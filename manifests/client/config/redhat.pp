# Define: ldap::client::config::redhat
#
# This custom definition sets up all of the necessary configuration
# Files to configure a cleint to AAA against LDAP servers for RHEL Systems
#
# Parameters:
#
# Actions:
#
# 
# Requires:
#
# Sample Usage:
#
# This class is not called directly.
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
    content => template('ldap/client/common/nss_pam_ldap.conf.erb'),
  }
  file { '/etc/openldap/ldap.conf':
    ensure  => file,
    content => template('ldap/client/common/ldap.conf.erb'), 
  }
}