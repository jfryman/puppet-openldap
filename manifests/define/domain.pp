define ldap::define::domain(
  $ensure = 'present',
  $basedn,
  $rootdn,
  $rootpw
){
  # TODO: Add regex validation checks for facts. 
  
  
  # determine server type based on fact
  if $ldapserver == 'openldap' {
    ldap::server::openldap::define::domain { $name:
      ensure => $ensure,
      basedn => $basedn,
      rootdn => $rootdn,
      rootpw => $rootpw,
    }
  } 
}