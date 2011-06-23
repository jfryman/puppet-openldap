class ldap::params {
  ## Generic Setup Parameters
  $lp_dameon_user = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'ldap',
  }
  
  $lp_daemon_group = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => $lp_damon_user,
  }
  
  $lp_tmp_dir = '/tmp/openldap'
  
  
  ## LDAP Client Specific Parameters
  $lp_sizelimit = 12
  $lp_timelimit = 15
  $lp_deref     = 'never'
  
  $lp_nsswitch = $operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                    => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian',
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.redhat',
  }
  
  ## OpenLDAP Specific Parameters
  
  # Allow LDAPv2 client connections.  
  $lp_openldap_allow_ldapv2 = 'false'
  $lp_openldap_loglevel    = '0'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
  
  $lp_openldap_run_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => '/var/run/openldap',
  }
  $lp_openldap_service = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'ldap',
  }
  $lp_openldap_conf_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => '/etc/openldap',
  }
  $lp_openldap_var_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => '/var/lib/ldap',
  }
}