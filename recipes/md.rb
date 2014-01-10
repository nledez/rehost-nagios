#
# Cookbook Name:: rehost-nagios
# Recipe:: md
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

cookbook_file "#{node['rehost-nagios']['sudoers_dir']}/nagios-md" do
  source "sudoers/nagios-md"
  mode '0440'
  owner 'root'
  group 'root'
end

[ "check_md" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script_dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "mdadm.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config_dir']}/#{f}" do
    source "conf/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
  end
end
