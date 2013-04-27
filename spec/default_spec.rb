require 'chefspec'

describe 'rehost-nagios::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::default' }
  it 'Deploy nagios-nrpe-server' do
    runner = expect(chef_run)

    [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ].each do |p|
      runner.to install_package p
    end

    runner.to set_service_to_start_on_boot 'nagios-nrpe-server'
    runner.to start_service 'nagios-nrpe-server'

    runner.to create_directory "/usr/local/lib/nagios/plugins"

    [ "syslog-ng.cfg", "system.cfg", "linux.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end

    [ "check_memory", "check_apt" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end
  end
end
