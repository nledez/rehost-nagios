#
# Cookbook Name:: rehost-nagios
# Recipe:: mon
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

node['rehost-nagios']['mon_packages'].each do |pkg|
  package pkg do
    action :install
  end
end

