#
# Cookbook Name:: ledez-nagios
# Recipe:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

node['ledez-nagios']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end
