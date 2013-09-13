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
  action [ :enable ]
end

directory node['rehost-nagios']['script-dir'] do
  recursive true
  owner "root"
  group "root"
  mode "0555"
end

cookbook_file "#{node['rehost-nagios']['sudoers-dir']}/nagios-default" do
  source "sudoers/nagios-default"
  mode '0440'
  owner 'root'
  group 'root'
end

[ "check_memory", "check_apt" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script-dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "syslog-ng.cfg", "system.cfg", "linux.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config-dir']}/#{f}" do
    source "conf/#{f}"
    mode '0444'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe-service']}]"
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
  notifies :restart, "service[#{node['rehost-nagios']['nrpe-service']}]", :delayed
end
