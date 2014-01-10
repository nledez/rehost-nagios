#
# Cookbook Name:: rehost-nagios
# Recipe:: vz
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

cookbook_file "#{node['rehost-nagios']['sudoers_dir']}/nagios-vz" do
  source "sudoers/nagios-vz"
  mode '0440'
  owner 'root'
  group 'root'
end

[ "check_ubc", "check_vzquota" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script_dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "openvz.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config_dir']}/#{f}" do
    source "conf/#{f}"
    mode '0444'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
  end
end
