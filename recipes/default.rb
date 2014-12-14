#
# Cookbook Name:: rehost-nagios
# Recipe:: default
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

node['rehost-nagios']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

service node['rehost-nagios']['nrpe_service'] do
  action [ :enable ]
end

directory node['rehost-nagios']['script_dir'] do
  recursive true
  owner "root"
  group "root"
  mode "0555"
end

cookbook_file "#{node['rehost-nagios']['sudoers_dir']}/nagios-default" do
  source "sudoers/nagios-default"
  mode '0440'
  owner 'root'
  group 'root'
end

[ "check_memory", "check_apt" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script_dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

syslogconf = case "#{node[:platform]}-#{node[:platform_version]}"
         when "ubuntu-10.04" then "syslog-ng.cfg"
         when /debian-6\.0\../ then "syslog-ng.cfg"
         else "rsyslog.cfg"
         end

if node['recipes'].include? 'rehost-syslog::rsyslog'
  syslogconf = 'rsyslog.cfg'
end

[ syslogconf, "system.cfg", "linux.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config_dir']}/#{f}" do
    source "conf/#{f}"
    mode '0444'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]"
  end
end

template "/etc/nagios/nrpe.d/allowed.cfg" do
  source "allowed.cfg.erb"
  mode '0444'
  owner 'root'
  group 'root'
  variables({
    :allowed_hosts => node['rehost-nagios']['allowed_hosts']
  })
  notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
end
