require 'spec_helper'

describe 'ldap::define::domain', :type => 'define' do
  let(:title) { 'testdomain' }
  context 'on a supported os' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'RedHat',
      :kernel => 'Linux',
    } }
    context 'with required parameters' do
      let(:params) { {
        :basedn => 'dc=test,dc=lan',
        :rootdn => 'cn=manager,dc=test,dc=lan',
        :rootpw => 'hackme',
      } }

      it { should include_class('ldap::params') }
      it { should contain_exec('bootstrap-ldap-testdomain') }

      context 'on a Debian OS' do
        let(:facts) { {
          :osfamily => 'Debian',
          :operatingsystem => 'Ubuntu',
          :kernel => 'Linux',
          :lsbdistcodename => 'lenny',
        } }

        it { should contain_file('/tmp/openldap/domains.d/testdomain.conf')\
          .with_content("include /etc/ldap/domains/testdomain.conf\n") }

        it { should contain_file('/etc/ldap/domains/testdomain.conf') }
      end

      context 'on a RedHat OS' do
        let(:facts) { {
          :osfamily => 'RedHat',
          :operatingsystem => 'RedHat',
          :kernel => 'Linux',
        } }

        it { should contain_file('/tmp/openldap/domains.d/testdomain.conf')\
          .with_content("include /etc/openldap/domains/testdomain.conf\n") }
        it { should contain_file('/etc/openldap/domains/testdomain.conf') }
      end
    end
  end
end
