# Class: ldap::params
#
# This module manages LDAP paramaters
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
# This class file is not called directly
class ldap::params {
  ## START: Generic Setup Parameters
  $lp_daemon_user = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'ldap',
    /(?i-mx:ubuntu|debian)/                    => 'openldap',
  }
  $lp_daemon_group = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'ldap',
    /(?i-mx:ubuntu|debian)/                    => 'openldap',    
  }
  
  $lp_tmp_dir = '/tmp/openldap'
  ## END: Generic Setup Parameters ##
  
  ## START: LDAP Client Specific Parameters ##
  $lp_sizelimit = 12
  $lp_timelimit = 15
  $lp_deref     = 'never'
  
  $lp_nsswitch = $operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                    => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian',
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.redhat',
  }
  ## END: LDAP Client Specific Parameters ##
  
  ## START: OpenLDAP Specific Parameters ##
  $lp_openldap_allow_ldapv2 = 'false'
  $lp_openldap_loglevel     = '8'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
  $lp_openldap_db_type      = 'bdb'
  
  $lp_openldap_run_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos)/          => '/var/run/openldap',
    /(?i-mx:debian|ubuntu|suse|opensuse)/ => '/var/run/slapd',
  }
  $lp_openldap_service = $operatingsystem ? {
    default => 'slapd',
  }
  $lp_openldap_conf_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => '/etc/openldap',
    /(?i-mx:debian|ubuntu)/                    => '/etc/ldap',
  }
  $lp_openldap_var_dir = $operatingsystem ? {
    /(?i-mx:fedora|rhel|centos|suse|opensuse|ubuntu)/ => '/var/lib/ldap',
    /(?i-mx:debian)/                                  => '/var/lib/slapd',
  }
  $lp_openldap_modulepath = $operatingsystem ? {
    /(?i-mx:suse|opensuse|debian|ubuntu)/ => '/usr/lib/ldap',
    /(?i-mx:centos|rhel|oel)/             => 'UNDEF',
  }
  ## END: OpenLDAP Specific Parameters ##
}
