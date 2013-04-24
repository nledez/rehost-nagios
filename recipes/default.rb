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
