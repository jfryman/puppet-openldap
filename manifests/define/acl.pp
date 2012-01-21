define ldap::define::acl(
  $ensure = 'present',
  $order  = '000',
  $domain,
  $access
){
  # TODO: Add regex validation checks for facts. 
  
  # determine server type based on fact. 
  # TODO: How can I automatically select the type?
  # Custom fact only is populated on the second run.
  ldap::server::openldap::define::acl { $name:
    ensure => $ensure,
    order  => $order,
    domain => $domain,
    access => $access,
  } 
}