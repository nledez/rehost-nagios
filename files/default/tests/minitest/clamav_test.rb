require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: clamav
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::clamav'do
  describe "Clamav test works" do
    it "Can launch Clamav tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_clamav}.must_match /^CLAMAV /
    end
  end
end
