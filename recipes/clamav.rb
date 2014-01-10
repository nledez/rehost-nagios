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

include_recipe "rehost-nagios"

node['rehost-nagios']['clamav_packages'].each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file "/etc/clamav/clam_test.conf" do
  source "clam_test.conf"
  mode '0444'
  owner 'root'
  group 'root'
end

[ "check_clamav" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script_dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "clamav.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config_dir']}/#{f}" do
    source "conf/#{f}"
    mode '0444'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
  end
end
