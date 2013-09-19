require 'chefspec'

describe 'rehost-nagios::clamav' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::clamav' }
  it 'Add clamav config files' do
    runner = expect(chef_run)

    %w{clamav clamav-daemon clamav-testfiles}.each do |p|
      runner.to install_package p
    end

    runner.to create_cookbook_file "/etc/clamav/clam_test.conf"
    file = chef_run.cookbook_file("/etc/clamav/clam_test.conf")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0444")

    [ "check_clamav" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    [ "clamav.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0444")
    end
  end
end
