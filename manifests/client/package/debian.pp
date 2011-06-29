# Class: ldap::client::package::debian
#
# This module manages LDAP client package installation on Debian based systems
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
class ldap::client::package::debian(
  $ensure
) {
  $debian_packages = ['libnss-ldap', 'nscd', 'libpam-ldap', 'ldap-utils']
  
  @package { $debian_packages:
    ensure => $ensure,
    tag    => 'debian-openldap-client',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'debian-openldap-client' |>
}