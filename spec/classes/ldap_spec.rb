require 'spec_helper'

describe 'ldap', :type=>'class' do
  context 'on an unsupported OS' do
    it { expect { should raise_error(Puppet::Error,/unsupported/) } }
  end

  context 'on a supported OS' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'RedHat',
      :kernel => 'Linux',
    } }
    it { should include_class('ldap::params') }
    it { should contain_anchor('ldap::begin::client') }
    it { should contain_anchor('ldap::end::client') }
    it { should contain_anchor('ldap::begin::server') }
    it { should contain_anchor('ldap::end::server') }
    it { should contain_anchor('ldap::end') }

    context 'with params client = true' do
      let(:params) { {:client => true} }
      it { should contain_class('ldap::client').with_ensure('present') }
    end
    context 'with params server = true' do
      let(:params) { {:server => true} }
      it { should contain_class('ldap::server') }
    end
  end
end
