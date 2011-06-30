# Define: ldap::client::config::suse
#
# This custom definition sets up all of the necessary configuration
# Files to configure a cleint to AAA against LDAP servers for SuSE Systems
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