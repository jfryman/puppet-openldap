# Define: ldap::client::config::debian
#
# This custom definition sets up all of the necessary configuration
# Files to configure a cleint to AAA against LDAP servers for Debian Systems
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
  file { "/etc/libnss-ldap.conf":
    ensure  => file,
    content => template(
      'ldap/client/debian/pam-nss-base.conf.erb',
      'ldap/client/debian/libnss-ldap.conf.erb'
    ),
  }
  file { "/etc/pam_ldap.conf":
    ensure  => file,
    content => template(
      'ldap/client/debian/pam-nss-base.conf.erb',
      'ldap/client/debian/pam_ldap.conf.erb'
    ),
  }
  
}