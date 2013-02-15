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

  case $::operatingsystem {
    ubuntu,debian: {
      $lp_daemon_user = 'openldap'
      $lp_daemon_group = 'openldap'
      $lp_daemon_uid = '55'
      $lp_daemon_gid = '55'
      $lp_nsswitch = 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian'
      $lp_openldap_run_dir = '/var/run/slapd'
      $lp_openldap_service = 'slapd'
      $lp_openldap_conf_dir = '/etc/ldap'
      $lp_openldap_modulepath = '/usr/lib/ldap'

      # Special configuration for Ubuntu and var_dir.
      # Ubuntu has AppArmor installed by default, which
      # fails for any directories located in /var/lib/slapd (debian default)
      # https://bugs.launchpad.net/ubuntu/+source/openldap/+bug/286614
      case $::operatingsystem {
        ubuntu: {
          $lp_openldap_var_dir = '/var/lib/ldap'
        }
        default: {
          $lp_openldap_var_dir = '/var/lib/slapd'
        }
      }

      case $::lsbdistcodename {
        lenny: {
          $openldap_packages = [
            'odbcinst1debian1', 'unixodbc', 'psmisc',
            'libsasl2-modules', 'libslp1', 'libltdl3',
            'libdb4.2',
          ]
        }
        precise: {
          $openldap_packages = ['slapd', 'ldap-utils', 'libperl5.14']
        }
        default: {
          $openldap_packages = ['slapd', 'ldap-utils', 'libperl5.10']
          $openldap_client_packages = [
            'libnss-ldap', 'nscd', 'libpam-ldap', 'ldap-utils'
          ]
        }
      }
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

      $client = {

      }


      case $::operatingsystem {
        suse: {
          $openldap_packages = ['openldap2', 'libltdl7', 'openldap2-back-meta']
          $openldap_client_packages = [
            'pam_ldap', 'nss_ldap', 'openldap2-client'
          ]
        }
        default: {
          # Default case is RHEL
          $openldap_packages = [
            'openldap', 'openldap-servers', 'openldap-clients'
          ]
          $openldap_client_packages =  [
            'openldap', 'openldap-clients', 'nss_ldap'
          ]
        }
      }
    }
  }
  $lp_tmp_dir = '/tmp/openldap'
  $lp_sizelimit = 12
  $lp_timelimit = 15
  $lp_deref     = 'never'
  $lp_openldap_allow_ldapv2 = false
  $lp_openldap_loglevel     = '8'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
  $lp_openldap_db_type      = 'bdb'
}
