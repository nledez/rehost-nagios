require 'chefspec'

describe 'rehost-nagios::mysql' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::mysql' }
  it 'Add mysql config files' do
    runner = expect(chef_run)

    %w{check_mysql_health}.each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    %w{mysql.cfg}.each do |f|
      runner.to create_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.template("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0644")
    end
  end
end
