class ldap::server::openldap::package::debian {
  $debian_packages = ['slapd', 'ldap-utils', 'libperl5.10']
   
  ## Lenny auto-requires the below packages                    
  if $lsbdistcodename == 'lenny' {
    $debian_packages += ['odbcinst1debian1', 'unixodbc', 'psmisc',
                         'libsasl2-modules', 'libslp1', 'libltdl3', 
                         'libdb4.2',
                        ]
  } 
  
  ## This section modifies the /etc/default file to allow for
  ## slapd.conf configuration as opposed to the cn=config 
  ## configuration and setup. This section will be removed once
  ## configuration is migrated to cn=config
  if $operatingsystem == 'Ubuntu' {
    file {'/etc/default/slapd':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('ldap/server/openldap/slapd_default.erb'),
      require => Package[$debian_packages],
    }
  }
  
  @package { $debian_packages:
    ensure => present,
    tag    => 'debian-openldap-server',
  }
  
  # Some packages are shared between Client/Server. In order to prevent
  # a conflict, packages are virtualized and realized to be decleared
  # once during a catalog compliation. 
  Package <| tag == 'redhat-openldap-server' |>
}