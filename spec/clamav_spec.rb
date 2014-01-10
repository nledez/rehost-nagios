#
# Cookbook Name:: rehost-nagios
# Recipe:: clamav
#
# Copyright 2013, ReHost
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
