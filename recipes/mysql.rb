#
# Cookbook Name:: rehost-nagios
# Recipe:: mysql
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

%w{check_mysql_health}.each do |f|
  cookbook_file "#{node['rehost-nagios']['script_dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

template "#{node['rehost-nagios']['config_dir']}/mysql.cfg" do
  source "mysql.cfg.erb"
  mode '0644'
  owner 'root'
  group 'root'
  variables({
    :script_dir => node['rehost-nagios']['script_dir'],
    :mysql_database => node['rehost-nagios']['mysql_database'],
    :mysql_hostname => node['rehost-nagios']['mysql_hostname'],
    :mysql_username => node['rehost-nagios']['mysql_username'],
    :mysql_password => node['rehost-nagios']['mysql_password']
  })
  notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
end
