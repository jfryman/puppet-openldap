# Class: ldap::client::openldap::base
#
# This class routes between default configurations of LDAP client access
# based on Operating System.
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
# This class file is not called directly.
class ldap::client::base(
  $ensure,
  $ssl
)
 {
  # Utilize the Anchor Pattern
  anchor { 'ldap::client::base::begin': }
  anchor { 'ldap::client::base::end': }
  
  Class { 
    ensure  => $ensure,
    ssl     => $ssl,
    require => Anchor['ldap::client::base::begin'],
    before  => Anchor['ldap::client::base::end'],
  }

  case $operatingsystem {
    centos,fedora,redhat: {
      class { 'ldap::client::base::redhat': }
    }
    debian,ubuntu: {
      class { 'ldap::client::base::debian':  }
    }
    opensuse,suse: {
      class { 'ldap::client::base::suse': }
    }
  }
}