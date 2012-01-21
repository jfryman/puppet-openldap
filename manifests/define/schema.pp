# Define: ldap::server::openldap::domain
#
# This custom definition sets up all of the necessary configuration
# Files to include custom schema in OpenLDAP. This uses the File-Fragment
# pattern to break up and assemble various portions of the configuration.
#
# Parameters:
#
# *ensure* - (true|false) Enable or disable a configured tree. Disabled trees
#            will not be deleted, but rather will remain on the file system
#            for archival purposes. 
# *source* - Source file for processing by Puppet
#
# Actions:
#
# This definition acts as a proxy class to various server implementations
# 
# Requires:
#
# Sample Usage:
# Server Configuration:
# ldap::define::schema { 'websages':
#   ensure => 'present',
#   source => 'puppet:///modules/ldap/schema/websages.schema',
# }
define ldap::define::schema(
  $ensure = 'present',
  $source
){
  # TODO: Add regex validation checks for facts. 
  
  # determine server type based on fact. 
  # TODO: How can I automatically select the type?
  # Custom fact only is populated on the second run.
    ldap::server::openldap::define::schema { $name:
      ensure => $ensure,
      source => $source
    } 
}