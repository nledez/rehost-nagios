require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: nginx
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::nginx'do
  describe "nginx test works" do
    it "Can launch nginx tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_nginx}.must_match /(^There's no pid file for nginx|of nginx_status is empty)/
    end
  end
end
