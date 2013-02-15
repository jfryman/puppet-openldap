# Define: ldap::client::config
#
# This custom definition sets up all of the necessary configuration
# Files to configure a cleint to AAA against LDAP servers. Routing is
# performed based on operating system.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes.
# *basedn* - Base DN for setting up the LDAP server.
# *servers* - Array of servers that can be connected to
#
# Actions:
#
#
# Requires:
#
# Sample Usage:
# Client Configuration:
# ldap::client::config { 'puppetlabs.test':
#   ensure  => 'present',
#   servers => ['server-1', 'server-2'],
#   ssl     => false,
#   base_dn => 'dc=puppetlabs,dc=test',
# }
define ldap::client::config (
  $ensure  = 'present',
  $base_dn = undef,
  $ssl     = undef,
  $servers = undef,
) {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  case $::operatingsystem {
    debian,ubuntu: {
      file { '/etc/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/nss_pam_ldap.conf.erb'),
      }
      file { '/etc/ldap/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/ldap.conf.erb'),
      }
      file { '/etc/libnss-ldap.conf':
        ensure  => file,
        content => template(
          'ldap/client/debian/pam-nss-base.conf.erb',
          'ldap/client/debian/libnss-ldap.conf.erb'
        ),
      }
      file { '/etc/pam_ldap.conf':
        ensure  => file,
        content => template(
          'ldap/client/debian/pam-nss-base.conf.erb',
          'ldap/client/debian/pam_ldap.conf.erb'
        ),
      }
    }
    default: {
      file { '/etc/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/nss_pam_ldap.conf.erb'),
      }
      file { '/etc/openldap/ldap.conf':
        ensure  => file,
        content => template('ldap/client/common/ldap.conf.erb'),
      }
    }
  }
}
