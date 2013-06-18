require 'spec_helper'

describe 'ldap::define::replication', :type => 'define' do
  let(:title){ 'testrepl' }

  context 'on a supported os' do

    context 'on a RedHat OS' do
      let(:facts) { {
        :osfamily => 'RedHat',
        :operatingsystem => 'RedHat',
        :kernel => 'Linux',
      } }
      it { should contain_file('/var/lib/ldap/testrepl/accesslog')\
        .with_ensure('directory') }
      it { should contain_file('/var/lib/ldap/testrepl/accesslog/DB_CONFIG') }
    end

    context 'on a Debian OS' do
      let(:facts) { {
        :osfamily => 'Debian',
        :operatingsystem => 'Debian',
        :kernel => 'Linux',
        :lsbdistcodename => 'lenny',
      } }
      it { should contain_file('/var/lib/slapd/testrepl/accesslog')\
        .with_ensure('directory') }
      it { should contain_file('/var/lib/slapd/testrepl/accesslog/DB_CONFIG') }
    end

    context 'on a Ubuntu OS' do
      let(:facts) { {
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :kernel => 'Linux',
        :lsbdistcodename => 'precise',
      } }
      it { should contain_file('/var/lib/ldap/testrepl/accesslog')\
        .with_ensure('directory') }
      it { should contain_file('/var/lib/ldap/testrepl/accesslog/DB_CONFIG') }
    end
  end
end
