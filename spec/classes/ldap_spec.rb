require 'spec_helper'

describe 'ldap', :type=>'class' do
  it { should include_class('ldap::params') }
  it { should contain_anchor('ldap::begin::client') }
  it { should contain_anchor('ldap::end::client') }
  it { should contain_anchor('ldap::begin::server') }
  it { should contain_anchor('ldap::end::server') }
  it { should contain_anchor('ldap::end') }
end
