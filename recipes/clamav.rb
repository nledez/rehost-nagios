#
# Cookbook Name:: rehost-nagios
# Recipe:: clamav
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

node['rehost-nagios']['clamav-packages'].each do |pkg|
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
  cookbook_file "#{node['rehost-nagios']['script-dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "clamav.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config-dir']}/#{f}" do
    source "conf/#{f}"
    mode '0444'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe-service']}]", :delayed
  end
end
