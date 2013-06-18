require 'spec_helper'

describe 'ldap::client::config', :type=>'define' do
  let(:title){ 'frymanet.com' }

  let(:params) { {
    :ensure => 'present',
    :servers => ['xenon.frymanet.com', 'argon.frymanet.com'],
    :ssl => false,
    :base_dn => 'dc=frymanet,dc=com',
  } }

  it { should contain_file('/etc/ldap.conf') }
  context 'on an Ubuntu OS' do
    let(:facts) { {
      :osfamily => 'Debian',
      :operatingsystem => 'Ubuntu',
    } }
    it { should contain_file('/etc/ldap.conf') }
    it { should contain_file('/etc/ldap/ldap.conf').with_content(
      /^URI  ldap:\/\/xenon.frymanet.com  ldap:\/\/argon.frymanet.com/) }
    it { should contain_file('/etc/libnss-ldap.conf') }
    it { should contain_file('/etc/pam_ldap.conf') }
  end

  context 'on a Redhat OS' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'RedHat',
    } }
    it { should contain_file('/etc/openldap/ldap.conf').with_content(
      /^URI  ldap:\/\/xenon.frymanet.com  ldap:\/\/argon.frymanet.com/) }
  end

end
