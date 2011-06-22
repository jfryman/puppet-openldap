class ldap::params {
  $op_sizelimit = 12
  $op_timelimit = 15
  $op_deref     = 'never'
  
  $op_nsswitch = $operatingsystem ? {
    /(?i-mx:debian|ubuntu)/                    => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.debian',
    /(?i-mx:fedora|rhel|centos|suse|opensuse)/ => 'puppet:///modules/ldap/client/nsswitch/nsswitch.conf.redhat',
  }
}