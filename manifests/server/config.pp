# Class: ldap::server::openldap::base
#
# This class sets up universal defaults between all types of
# Operating Systems for the Initializion of OpenLDAP.
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
class ldap::server::config (
  $ssl      = undef,
  $ssl_ca   = undef,
  $ssl_cert = undef,
  $ssl_key  = undef
) {
  File {
    owner => 'root',
    group => $ldap::params::lp_daemon_group,
    mode  => '0640',
  }

  file { '/etc/ldap-server':
    ensure  => file,
    content => 'openldap',
  }

  file { "${ldap::params::lp_openldap_conf_dir}/slapd.conf":
    ensure  => file,
    group   => $ldap::params::lp_daemon_user,
    content => template('ldap/server/openldap/slapd.conf.erb')
  }

  ## Directories to be used for File-Fragment Patterns.
  ## Contained in this directory for permissions concerns.
  file { "${ldap::params::lp_openldap_conf_dir}/replication":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { "${ldap::params::lp_openldap_conf_dir}/domains":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { $ldap::params::lp_tmp_dir:
    ensure  => directory,
  }
  file { "${ldap::params::lp_tmp_dir}/schema.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { "${ldap::params::lp_tmp_dir}/replication.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { "${ldap::params::lp_tmp_dir}/domains.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file { "${ldap::params::lp_tmp_dir}/acl.d":
    ensure  => directory,
    purge   => true,
    recurse => true,
  }
  file {"${ldap::params::lp_openldap_conf_dir}/slapd.d":
    ensure => 'absent',
    force  => true,
  }

  # These files are here to ensure that a blank file exists
  # and consecutive service execution and/or executions do not fail out
  file { "${ldap::params::lp_openldap_conf_dir}/replication.conf":
    ensure => file,
    group  => $ldap::params::lp_daemon_group,
  }
  file { "${ldap::params::lp_tmp_dir}/replication.d/00_default":
    ensure => file,
  }
  file { "${ldap::params::lp_openldap_conf_dir}/domains.conf":
    ensure => file,
    group  => $ldap::params::lp_daemon_group,
  }
  file { "${ldap::params::lp_tmp_dir}/domains.d/00_default":
    ensure => file,
  }
  file { "${ldap::params::lp_openldap_conf_dir}/schema.conf":
    ensure => file,
    group  => $ldap::params::lp_daemon_group,
  }
  file { "${ldap::params::lp_tmp_dir}/schema.d/00_default":
    ensure => file,
  }
  file { "${ldap::params::lp_openldap_conf_dir}/acl.conf":
    ensure => file,
    group  => $ldap::params::lp_daemon_group,
  }

  file { '/usr/local/bin/openldap_acl_rebuild':
    ensure  => file,
    mode    => '0700',
    content => template('ldap/server/openldap/openldap_acl_rebuild.erb'),
  }

  file {$ldap::params::lp_openldap_conf_dir:
    ensure => directory,
    mode   => '0755',
    owner  => 'root',
    group  => 'root',
  }
}
