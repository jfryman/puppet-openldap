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
  if $::kernel != 'Linux' {
      fail("${module_name} unsupported for ${::kernel}.")
  }

  # Cross-platform compatible variables.
  $lp_tmp_dir               = '/tmp/openldap'
  $lp_sizelimit             = 12
  $lp_timelimit             = 15
  $lp_deref                 = 'never'
  $lp_openldap_allow_ldapv2 = false
  $lp_openldap_loglevel     = '8'
  $lp_openldap_sizelimit    = '5000'
  $lp_openldap_tool_threads = '1'
  $lp_openldap_db_type      = 'bdb'

  # Defaults with OS-specific overrides.
  $lp_openldap_var_dir = $::operatingsystem ? {
    'Debian'    => '/var/lib/slapd',
    default     => '/var/lib/ldap',
  }

  # Defaults with OS family-specific overrides.
  $lp_daemon_user = $::osfamily ? {
    'Debian'    => 'openldap',
    default     => 'ldap',
  }
  $lp_daemon_group = $::osfamily ? {
    'Debian'    => 'openldap',
    default     => 'ldap',
  }
  $lp_daemon_uid = $::osfamily ? {
    default     => '55',
  }
  $lp_daemon_gid = $::osfamily ? {
    default     => '55',
  }
  $lp_nsswitch = $::osfamily ? {
    'Debian'    => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian',
    default     => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.redhat',
  }
  $lp_openldap_run_dir = $::osfamily ? {
    'Debian' => '/var/run/slapd',
    default  => '/var/run/openldap',
  }
  $lp_openldap_conf_dir = $::osfamily ? {
    'Debian'    => '/etc/ldap',
    default     => '/etc/openldap',
  }
  $lp_openldap_modulepath = $::osfamily ? {
    'Debian'    => '/usr/lib/ldap',
    default     => 'UNDEF',
  }

  # Service name and packages need to be selected with more complex logic.
  case $::osfamily {
    'Debian': {
      $lp_openldap_service = 'slapd'
      case $::lsbdistcodename {
        '': {
          fail("${module_name} needs LSB facts to install on ${::operatingsystem}.")
        }
        lenny: {
          $openldap_packages = [
            'odbcinst1debian1', 'unixodbc', 'psmisc',
            'libsasl2-modules', 'libslp1', 'libltdl3',
            'libdb4.2',
          ]
        }
        /precise|wheezy/: {
          $openldap_packages = ['slapd', 'ldap-utils', 'libperl5.14']
        }
        default: {
          $openldap_packages = ['slapd', 'ldap-utils', 'libperl5.10']
          $openldap_client_packages = [
            'libnss-ldap', 'nscd', 'libpam-ldap', 'ldap-utils'
          ]
        }
      }
    } 'RedHat': {
      case $::operatingsystemrelease {
        /^5\./: {
          $lp_openldap_service = 'ldap'
        } /^6\./: {
          $lp_openldap_service = 'slapd'
        }
      }
      $openldap_packages = [
        'openldap', 'openldap-servers', 'openldap-clients'
      ]
      $openldap_client_packages =  [
        'openldap', 'openldap-clients', 'nss_ldap'
      ]
    } 'Suse': {
      $openldap_packages = ['openldap2', 'libltdl7', 'openldap2-back-meta']
      $openldap_client_packages = [
        'pam_ldap', 'nss_ldap', 'openldap2-client'
      ]
    } default: {
      fail("${module_name} unsupported for ${::operatingsystem}.")
    }
  }
}
