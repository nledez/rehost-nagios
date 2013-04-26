require 'chefspec'

describe 'rehost-nagios::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::default' }
  it 'Deploy nagios-nrpe-server' do
    [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ].each do |p|
      expect(chef_run).to install_package p
    end

    expect(chef_run).to set_service_to_start_on_boot 'nagios-nrpe-server'
    expect(chef_run).to start_service 'nagios-nrpe-server'

    expect(chef_run).to create_directory "/usr/local/lib/nagios/plugins"

    expect(chef_run).to create_file "/etc/nagios/nrpe.d/syslog-ng.cfg"
  #  #[ "syslog-ng.cfg", "system.cfg", "linux.cfg" ].each do |f|
  #    #expect(chef_run).to create_file "/etc/nagios/nrpe.d/#{f}"
  #    #file = chef_run.file("/etc/nagios/nrpe.d/#{f}")
  #    #expect(file).to be_owned_by('root', 'root')
  end
end
