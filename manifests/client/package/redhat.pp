# Class: ldap::client::package::redhat
#
# This module manages LDAP client package installation on RHEL based systems
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
class ldap::client::package::redhat(
  $ensure
) {
  $redhat_packages = ['openldap', 'openldap-clients', 'nss_ldap']
  
  @package { $redhat_packages:
    ensure => $ensure,
    tag    => 'redhat-openldap-client',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'redhat-openldap-client' |>
}