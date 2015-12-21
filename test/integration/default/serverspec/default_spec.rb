require 'spec_helper'

describe 'the proxy profile' do
  it 'is owned by root' do
    expect(file '/etc/profile.d/chef_solo_proxy.sh').to be_owned_by 'root'
    expect(file '/etc/profile.d/chef_solo_proxy.sh').to be_mode 644
  end
end
