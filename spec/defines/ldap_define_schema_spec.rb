require 'spec_helper'

describe 'ldap::define::schema', :type=>'define' do
  let(:title) { 'testschema' }
  context 'on a supported os' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'RedHat',
      :kernel => 'Linux',
    } }
    context 'on a Debian OS' do
      let(:facts) { {
        :osfamily => 'Debian',
        :operatingsystem => 'Ubuntu',
        :kernel => 'Linux',
        :lsbdistcodename => 'lenny',
      } }

      it { should contain_file('/tmp/openldap/schema.d/testschema.schema')\
        .with_content("include /etc/ldap/schema/testschema.schema\n") }

      it { should contain_file('/etc/ldap/schema/testschema.schema') }
    end

    context 'on a RedHat OS' do
      let(:facts) { {
        :osfamily => 'RedHat',
        :operatingsystem => 'RedHat',
        :kernel => 'Linux',
      } }

      it { should contain_file('/tmp/openldap/schema.d/testschema.schema')\
        .with_content("include /etc/openldap/schema/testschema.schema\n") }

      it { should contain_file('/etc/openldap/schema/testschema.schema') }
    end

  end
end
