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
class ldap::server::openldap::rebuild {
  exec { 'rebuild-openldap-domains.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/domains.d/* > ${ldap::params::lp_openldap_conf_dir}/domains.conf",
    refreshonly => 'true',
    group       => $ldap::params::lp_openldap_user,    
    subscribe   => File["${ldap::params::lp_tmp_dir}/domains.d"],
  }
  exec { 'rebuild-openldap-replication.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/replication.d/* > ${ldap::params::lp_openldap_conf_dir}/replication.conf",
    refreshonly => 'true',
    group       => $ldap::params::lp_openldap_user,    
    subscribe   => File["${ldap::params::lp_tmp_dir}/replication.d"],
  }
  exec { 'rebuild-openldap-schema.conf':
    command     => "/bin/cat ${ldap::params::lp_tmp_dir}/schema.d/* > ${ldap::params::lp_openldap_conf_dir}/schema.conf",
    refreshonly => true,
    group       => $ldap::params::lp_openldap_user,
    subscribe   => File["${ldap::params::lp_tmp_dir}/schema.d"],
  }  
}
