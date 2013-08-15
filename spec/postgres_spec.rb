require 'chefspec'

describe 'rehost-nagios::postgres' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::postgres' }
  it 'Add postgres config files' do
    runner = expect(chef_run)

    [ "check_postgres" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    [ "postgres.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end
  end
end
