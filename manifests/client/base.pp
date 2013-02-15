# Class: ldap::client::openldap::base
#
# This class routes between default configurations of LDAP client access
# based on Operating System.
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
class ldap::client::base(
  $ensure = undef,
  $ssl    = undef,
) {
  case $::operatingsystem {
    centos,fedora,redhat: {
      file { '/etc/nsswitch.conf':
        ensure  => file,
        content => template('ldap/client/redhat/nsswitch.conf.erb'),
      }
      file { '/etc/pam.d/system-auth':
        ensure  => file,
        content => template('ldap/client/redhat/system-auth.erb'),
      }
    }
    debian,ubuntu: {
      file { '/etc/nsswitch.conf':
        ensure  => file,
        content => template('ldap/client/debian/nsswitch.conf.erb'),
      }
      file { '/etc/pam.d/common-auth':
        ensure  => file,
        content => template('ldap/client/debian/common-auth.erb'),
      }
      file { '/etc/pam.d/common-password':
        ensure  => file,
        content => template('ldap/client/debian/common-password.erb'),
      }
      file { '/etc/pam.d/common-session':
        ensure  => file,
        content => template('ldap/client/debian/common-session.erb'),
      }
      file { '/etc/pam.d/common-account':
        ensure  => file,
        content => template('ldap/client/debian/common-account.erb'),
      }
    }
    opensuse,suse: {
      file { '/etc/nsswitch.conf':
        ensure  => file,
        content => template('ldap/client/suse/nsswitch.conf.erb'),
      }
      file { '/etc/pam.d/common-auth':
        ensure  => file,
        content => template('ldap/client/suse/common-auth.erb'),
      }
      file { '/etc/pam.d/common-password':
        ensure  => file,
        content => template('ldap/client/suse/common-password.erb'),
      }
      file { '/etc/pam.d/common-session':
        ensure  => file,
        content => template('ldap/client/suse/common-session.erb'),
      }
      file { '/etc/pam.d/common-account':
        ensure  => file,
        content => template('ldap/client/suse/common-account.erb'),
      }
    }
    default: { fail('Unsupported Operatingsystem') }
  }
}
