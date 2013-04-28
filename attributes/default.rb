#
# Cookbook Name:: rehost-nagios
# Recipe:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

default['rehost-nagios']['packages'] = [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ]
default['rehost-nagios']['clamav-packages'] = [ "clamav", "clamav-daemon", "clamav-testfiles" ]
default['rehost-nagios']['mon-packages'] = [ "nagios-nrpe-plugin" ]
default['rehost-nagios']['nrpe-service'] = "nagios-nrpe-server"
default['rehost-nagios']['script-dir'] = "/usr/local/lib/nagios/plugins"
default['rehost-nagios']['config-dir'] = "/etc/nagios/nrpe.d"
default['rehost-nagios']['sudoers-dir'] = "/etc/sudoers.d"
default['rehost-nagios']['allowed_hosts'] = "127.0.0.1,91.121.88.157,87.98.179.41"
