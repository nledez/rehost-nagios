require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: mysql
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::mysql'do
  describe "mysql test works" do
    it "Can launch mysql tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_mysqld}.must_match /with command name 'mysqld'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_mysql_database}.must_match /^Can't connect to local MySQL/
    end
  end
end
