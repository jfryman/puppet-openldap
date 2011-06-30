# Class: ldap::server::openldap::package::suse
#
# This module manages package installation of OpenLDAP, based on 
# operating system on SuSE based systems.
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
class ldap::server::openldap::package::suse {
  $suse_packages = ['openldap2', 'libltdl7', 'openldap2-back-meta']
  
  @package { $suse_packages:
    ensure => present,
    tag    => 'suse-openldap-server',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'suse-openldap-server' |>
}