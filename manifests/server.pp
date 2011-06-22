class ldap::server(
  $server_type
) {
  anchor { 'ldap::server::begin': }
  anchor { 'ldap::server::end': }
    
  if $server_type == 'openldap' {
    class { 'ldap::server::openldap':
      require => Anchor['ldap::server::begin'],
      before  => Anchor['ldap::server::end'],
    }
  } elsif $server_type == '389' {
    class { 'ldap::server::389': 
      require => Anchor['ldap::server::begin'],
      before  => Anchor['ldap::server::end'],
    }
  } else {
    fail("Invalid LDAP Server Implementation: ${server_type}")
  }
}

