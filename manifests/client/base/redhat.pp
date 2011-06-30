# Class: ldap::client::openldap::base::redhat
#
# This class sets up default configuration for LDAP clients on Redhat systems
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly.
class ldap::client::base::redhat(
  $ensure,
  $ssl
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0444',
  }
  
  $ensure_real = $ensure
  
  file { '/etc/nsswitch.conf':
    ensure  => file,
    content => template('ldap/client/redhat/nsswitch.conf.erb'),
  }
  file { '/etc/pam.d/system-auth':
    ensure  => file,
    content => template('ldap/client/redhat/system-auth.erb'),
  }
}