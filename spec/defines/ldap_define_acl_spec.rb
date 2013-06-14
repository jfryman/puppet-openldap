require 'spec_helper'

describe 'ldap::define::acl', :type => 'define' do
  let(:title) { 'testacl' }
  let(:params) { {
    :access => [ ['who1', 'access1'], ['who2', 'access2'] ],
    :domain => 'testdomain',
  } }

  context 'on a RedHat OS' do
    let(:facts) { {
      :osfamily => 'RedHat',
      :operatingsystem => 'RedHat',
      :kernel => 'Linux',
    } }
    md5name='9180a90a67ec3535bfc0cec21418babe' # md5 of testacl
    it { should contain_file(
      "/tmp/openldap/acl.d/testdomain-000-#{md5name}.conf").with_content(
      "access to testacl\n    by who1 access1\n    by who2 access2\n"
    ) }

  end

end
