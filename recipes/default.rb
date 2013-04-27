#
# Cookbook Name:: rehost-nagios
# Recipe:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

node['rehost-nagios']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

service node['rehost-nagios']['nrpe-service'] do
  action [:start, :enable]
end

directory node['rehost-nagios']['script-dir'] do
  recursive true
  owner "root"
  group "root"
  mode "0755"
end

[ "syslog-ng.cfg", "system.cfg", "linux.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config-dir']}/#{f}" do
    path "#{node['rehost-nagios']['config-dir']}/#{f}"
    source "conf/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    action :create
  end
end

[ "check_memory", "check_apt" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script-dir']}/#{f}" do
    path "#{node['rehost-nagios']['script-dir']}/#{f}"
    source "scripts/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    action :create
  end
end
