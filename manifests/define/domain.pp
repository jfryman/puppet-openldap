define ldap::define::domain(
  $ensure = 'present',
  $basedn,
  $rootdn,
  $rootpw
){
  # TODO: Add regex validation checks for facts. 
  
  
  # determine server type based on fact. 
  # TODO: How can I automatically select the type?
  # Custom fact only is populated on the second run.
    ldap::server::openldap::define::domain { $name:
      ensure => $ensure,
      basedn => $basedn,
      rootdn => $rootdn,
      rootpw => $rootpw,
    } 
}