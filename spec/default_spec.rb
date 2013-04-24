require 'chefspec'

describe 'rehost-nagios::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::default' }
  it 'installs packages' do
    [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ].each do |p|
      expect(chef_run).to install_package p
    end
  end
end
