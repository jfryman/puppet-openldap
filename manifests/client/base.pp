class ldap::client::base {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0444',
  }
  
  file { '/etc/nsswitch.conf':
    ensure => file,
    source => $ldap::params::op_nsswitch,
  }
}