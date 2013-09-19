require 'chefspec'

describe 'rehost-nagios::mon' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::mon' }
  it 'Add mon config files' do
    runner = expect(chef_run)

    %w{nagios-nrpe-plugin}.each do |p|
      runner.to install_package p
    end

  end
end
