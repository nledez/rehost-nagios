#
# Cookbook Name:: rehost-nagios
# Recipe:: vz
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

cookbook_file "#{node['rehost-nagios']['sudoers-dir']}/nagios-vz" do
  source "sudoers/nagios-vz"
  mode '0440'
  owner 'root'
  group 'root'
end

[ "check_ubc", "check_vzquota" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script-dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
  end
end

[ "openvz.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config-dir']}/#{f}" do
    source "conf/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe-service']}]"
  end
end
