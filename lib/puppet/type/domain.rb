Puppet::Type.newtype(:domain) do
  @doc = "Manage LDAP Domains"
  
  ensurable do
    defaultto(:present)
    newvalue(:present) do
      provider.create
    end
    newvalue(:absent) do
      provider.destroy
    end
  end
  
  newparam(:basedn) do
    desc "The base distinguished name"
    
    validate do |value|
      unless value =~ /(dc|DC)=[^,]+/
        raise ArgumentError, "%s is not a valid LDAP Base DN" % value
      end
    end
    isnamevar
  end
  
  newparam(:rootdn) do
    desc "Admin account for domain"
    
    validate do |value|
      unless value =~ /(cn|CN)=+/
        raise ArgumentError, "%s is not a valid Admin DN" % value
      end
    end
  end
  
  newparam(:rootpw) do
    desc "Admin password for domain"
    
    validate do |value|
      unless value =~ /\{(SHA|SSHA|MD5|SMD5|clear)\}.*/
        raise ArgumentError, "%s is not a valid LDAP Password" % value
      end
    end
  end
end
      
      