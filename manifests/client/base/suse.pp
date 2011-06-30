class ldap::client::base::suse(
  $ensure,
  $ssl
) {
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