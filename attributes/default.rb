#
# Cookbook Name:: rehost-nagios
# Recipe:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

default['rehost-nagios']['packages'] = [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ]
default['rehost-nagios']['nrpe-service'] = "nagios-nrpe-server"
default['rehost-nagios']['script-dir'] = "/usr/local/lib/nagios/plugins"
default['rehost-nagios']['config-dir'] = "/etc/nagios/nrpe.d"
