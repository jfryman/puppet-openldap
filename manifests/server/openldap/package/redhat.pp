# Class: ldap::server::openldap::package::redhat
#
# This module manages package installation of OpenLDAP, based on 
# operating system on RHEL based systems
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
class ldap::server::openldap::package::redhat {
  $redhat_packages = ['openldap', 'openldap-servers', 'openldap-clients']
  
  @package { $redhat_packages:
    ensure => present,
    tag    => 'redhat-openldap-server',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'redhat-openldap-server' |>
}