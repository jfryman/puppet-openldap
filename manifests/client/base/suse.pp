# Class: ldap::client::openldap::base::suse
#
# This class sets up default configuration for LDAP clients on SuSE systems
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
class ldap::client::base::suse(
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
    content => template('ldap/client/suse/nsswitch.conf.erb'),
  }
  file { "/etc/pam.d/common-auth":
    ensure => file,
    content => template('ldap/client/suse/common-auth.erb'),
  }
  file { "/etc/pam.d/common-password":
    ensure => file,
    content => template('ldap/client/suse/common-password.erb'),
  }
  file { "/etc/pam.d/common-session":
    ensure => file,
    content => template('ldap/client/suse/common-session.erb'),
  }
  file { "/etc/pam.d/common-account":
    ensure => file,
    content => template('ldap/client/suse/common-account.erb'),
  }
}