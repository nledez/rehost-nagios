#
# Cookbook Name:: rehost-nagios
# Recipe:: nginx
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

[ "check_nginx" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['script-dir']}/#{f}" do
    source "scripts/#{f}"
    mode '0555'
    owner 'root'
    group 'root'
  end
end

[ "nginx.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config-dir']}/#{f}" do
    source "conf/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe-service']}]", :delayed
  end
end
