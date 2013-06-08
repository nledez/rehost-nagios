require 'chefspec'

describe 'rehost-nagios::vz' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::vz' }
  it 'Add vz config files' do
    runner = expect(chef_run)

    runner.to create_cookbook_file "/etc/sudoers.d/nagios-vz"
    file = chef_run.cookbook_file("/etc/sudoers.d/nagios-vz")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0440")

    [ "check_ubc", "check_vzquota" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    [ "openvz.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0444")
    end
  end
end
