require 'chefspec'

describe 'rehost-nagios::md' do
  let(:chef_run) { ChefSpec::ChefRunner.new.converge 'rehost-nagios::md' }
  it 'Add md config files' do
    runner = expect(chef_run)

    runner.to create_cookbook_file "/etc/sudoers.d/nagios-md"
    file = chef_run.cookbook_file("/etc/sudoers.d/nagios-md")
    expect(file).to be_owned_by('root', 'root')
    expect(file.mode).to eq("0440")

    %w{check_md}.each do |f|
      runner.to create_cookbook_file "/usr/local/lib/nagios/plugins/#{f}"
      file = chef_run.cookbook_file("/usr/local/lib/nagios/plugins/#{f}")
      expect(file).to be_owned_by('root', 'root')
      expect(file.mode).to eq("0555")
    end

    %w{mdadm.cfg}.each do |f|
      runner.to create_cookbook_file "/etc/nagios/nrpe.d/#{f}"
      file = chef_run.cookbook_file("/etc/nagios/nrpe.d/#{f}")
      expect(file).to be_owned_by('root', 'root')
    end
  end
end
