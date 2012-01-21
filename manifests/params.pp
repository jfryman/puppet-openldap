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

  case $operatingsystem { 
    ubuntu,debian: {
      $lp_daemon_user = 'openldap'
      $lp_daemon_group = 'openldap'
      $lp_daemon_uid = '55'
      $lp_daemon_gid = '55'
      $lp_nsswitch = 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian'
      $lp_openldap_run_dir = '/var/run/slapd'
      $lp_openldap_service = 'slapd'
      $lp_openldap_conf_dir = '/etc/ldap'
      $lp_openldap_var_dir = '/var/lib/slapd'
      $lp_openldap_modulepath = '/usr/lib/ldap'
    }
    fedora,redhat,centos,suse,opensuse: {
      $lp_daemon_user = 'ldap'
      $lp_daemon_group = 'ldap'
      $lp_daemon_uid = '55'
      $lp_daemon_gid = '55'
      $lp_nsswitch = 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.redhat'
      $lp_openldap_run_dir = '/var/run/openldap'
      $lp_openldap_service = 'ldap'
      $lp_openldap_conf_dir = '/etc/openldap'
      $lp_openldap_var_dir = '/var/lib/ldap'
      $lp_openldap_modulepath = 'UNDEF'
    }
  }
  
  $lp_tmp_dir = '/tmp/openldap'
  
  $lp_sizelimit = 12
  $lp_timelimit = 15
  $lp_deref     = 'never'
  
  $lp_openldap_allow_ldapv2 = 'false'
  $lp_openldap_loglevel     = '8'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
  $lp_openldap_db_type      = 'bdb'
}
