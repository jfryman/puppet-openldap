# Define: ldap::server::openldap::domain
#
# This custom definition sets up all of the necessary configuration
# Files to bootstrap a LDAP tree. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *basedn* - Base DN for setting up the LDAP server. 
# *rootdn* - Base DN for the administrator acount on an LDAP server.
# *rootpw* - Password for the administrator account. Will accept any valid
#          - Hashed (crypt|(s)md5|(s)sha) or plaintext password. 
#
# Actions:
#
# This definition acts as a proxy class to various server implementations
# 
# Requires:
#
# Sample Usage:
# Server Configuration:
# ldap::define::domain {'puppetlabs.test':
#   basedn   => 'dc=puppetlabs,dc=test',
#   rootdn   => 'cn=admin',
#   rootpw   => 'test',
# } 
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