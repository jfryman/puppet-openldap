class ldap::server::openldap::base {
  File {
    owner => 'root',
    group => $ldap::params::lp_daemon_group,
    mode  => '0640',
  }
  
  file { "/etc/ldap-server":
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
  file { "${ldap::params::lp_tmp_dir}":
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

  file {"${ldap::params::lp_openldap_conf_dir}":
    ensure => directory,
    mode   => '0700',
    owner  => $ldap::params::lp_daemon_user,
    group  => $ldap::params::lp_daemon_group,
  }
  
}