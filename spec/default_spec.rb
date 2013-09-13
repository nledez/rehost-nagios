require 'chefspec'

describe 'rehost-nagios::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::default' }

  it 'Deploy nagios-nrpe-server' do
    runner = expect(chef_run)

    [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ].each do |p|
      runner.to install_package p
    end

    runner.to set_service_to_start_on_boot 'nagios-nrpe-server'

    runner.to create_directory "/usr/local/lib/nagios/plugins"

    runner.to create_cookbook_file "/etc/sudoers.d/nagios-default"
    file = chef_run.cookbook_file("/etc/sudoers.d/nagios-default")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0440")

    [ "check_memory", "check_apt" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    [ "syslog-ng.cfg", "system.cfg", "linux.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0444")
    end

    runner.to create_file "/etc/nagios/nrpe.d/allowed.cfg"
    file = chef_run.template("/etc/nagios/nrpe.d/allowed.cfg")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0444")
    runner.to create_file_with_content "/etc/nagios/nrpe.d/allowed.cfg", /^allowed_hosts=127.0.0.1,91.121.88.157,87.98.179.41$/
  end

  it "Can override allowed hosts" do
    chef_run2 = ChefSpec::ChefRunner.new
    chef_run2.node.set['rehost-nagios']['allowed_hosts'] = "127.0.0.1"
    chef_run2.converge 'rehost-nagios::default'

    runner = expect(chef_run2)

    runner.to create_file_with_content "/etc/nagios/nrpe.d/allowed.cfg", /^allowed_hosts=127.0.0.1$/
  end
end
