#
# Cookbook Name:: rehost-nagios
#
# Copyright 2013, ReHost
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['rehost-nagios']['packages'] = %w{nagios-nrpe-server nagios-plugins nagios-plugins-basic nagios-plugins-standard}
default['rehost-nagios']['clamav_packages'] = %w{clamav clamav-daemon clamav-testfiles}
default['rehost-nagios']['mon_packages'] = %w{nagios-nrpe-plugin}
default['rehost-nagios']['nrpe_service'] = "nagios-nrpe-server"
default['rehost-nagios']['script_dir'] = "/usr/local/lib/nagios/plugins"
default['rehost-nagios']['config_dir'] = "/etc/nagios/nrpe.d"
default['rehost-nagios']['sudoers_dir'] = "/etc/sudoers.d"
default['rehost-nagios']['allowed_hosts'] = "127.0.0.1,91.121.88.157,87.98.179.41"
default['rehost-nagios']['mysql_database'] = "nagioscheck"
default['rehost-nagios']['mysql_hostname'] = "localhost"
default['rehost-nagios']['mysql_username'] = "nagioscheck"
default['rehost-nagios']['mysql_password'] = "nagioscheck"
