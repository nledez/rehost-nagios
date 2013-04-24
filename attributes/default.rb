#
# Cookbook Name:: ledez-nagios
# Recipe:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

case platform
when "debian", "ubuntu"
  default['ledez-nagios']['packages'] = [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ]
end
