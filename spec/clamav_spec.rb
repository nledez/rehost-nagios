require 'chefspec'

describe 'rehost-nagios::clamav' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::clamav' }
  it 'Add clamav config files' do
    runner = expect(chef_run)

    runner.to create_cookbook_file "/etc/clamav/clam_test.conf"
    file = chef_run.cookbook_file("/etc/clamav/clam_test.conf")
    expect(file).to be_owned_by('root', 'root')

    [ "check_clamav" ].each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end

    [ "clamav.cfg" ].each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end
  end
end
