require 'fileutils'
require 'puppet'

Puppet::Type.type(:domain).provide(:openldap) do
  desc "Provides OpenLDAP support for the LDAP Server"

  commands :test => '/tmp/test'
  defaultfor :ldapserver => 'openldap'
  
  file = scope.lookupdir()
  
  def create
    
  end
  
  def destroy

  end
  
  def exists?
    
  end
end