class ldap::server::openldap::package::debian {
  $debian_packages = ['slapd', 'ldap-utils', 'libdb4.2', 'libltdl3',
                      'libperl5.10', 'libsasl2-modules', 'libslp1',
                      'odbcinst1debian1', 'psmisc', 'unixodbc']
  
  package { $debian_packages:
    ensure => present,
  }
}