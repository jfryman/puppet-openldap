Facter.add(:ldapserver) do
  setcode do
    ldap_fact = '/etc/ldap-server'
    File.open(ldap_fact, 'r').first if File.exists?(ldap_fact)
  end
end