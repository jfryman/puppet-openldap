# Class: ldap::server::openldap::rebuild
#
# This module acts as a container that can be called externally to
# kick off file fragment rebuilds for OpenLDAP.
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
class ldap::server::rebuild {
  Exec {
    path        => '/bin:/sbin:/usr/bin:/usr/sbin',
    group       => $ldap::params::lp_openldap_user,
    refreshonly => true,
  }

  exec { 'rebuild-openldap-domains.conf':
    command   => "cat ${ldap::params::lp_tmp_dir}/domains.d/* > ${ldap::params::lp_openldap_conf_dir}/domains.conf",
    subscribe => File["${ldap::params::lp_tmp_dir}/domains.d"],
  }
  exec { 'rebuild-openldap-replication.conf':
    command   => "cat ${ldap::params::lp_tmp_dir}/replication.d/* > ${ldap::params::lp_openldap_conf_dir}/replication.conf",
    subscribe => File["${ldap::params::lp_tmp_dir}/replication.d"],
  }
  exec { 'rebuild-openldap-schema.conf':
    command   => "cat ${ldap::params::lp_tmp_dir}/schema.d/* > ${ldap::params::lp_openldap_conf_dir}/schema.conf",
    subscribe => File["${ldap::params::lp_tmp_dir}/schema.d"],
  }
  exec { 'rebuild-openldap-acl.conf':
    command   => '/usr/local/bin/openldap_acl_rebuild',
    subscribe => File["${ldap::params::lp_tmp_dir}/acl.d"],
  }
}
