require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: vz
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::vz'do
  describe "vz test works" do
    it "Can launch vz tests" do
      #%x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_ubc}.must_match %r{^VZ KO: could not read /proc/user_beancounters/}
      #%x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_vzquota}.must_match /(^There's no pid file for nginx|of nginx_status is empty)/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_total_procs_ovz}.must_match /^PROCS OK: /
    end
  end
end
