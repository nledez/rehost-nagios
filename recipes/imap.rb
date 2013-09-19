#
# Cookbook Name:: rehost-nagios
# Recipe:: imap
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

include_recipe "rehost-nagios"

[ "imap.cfg" ].each do |f|
  cookbook_file "#{node['rehost-nagios']['config_dir']}/#{f}" do
    source "conf/#{f}"
    mode '0644'
    owner 'root'
    group 'root'
    notifies :restart, "service[#{node['rehost-nagios']['nrpe_service']}]", :delayed
  end
end
