require 'chefspec'

describe 'rehost-nagios::mysql' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::mysql' }
  it 'Add mysql config files' do
    runner = expect(chef_run)

    [ "mysql.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end
  end
end
