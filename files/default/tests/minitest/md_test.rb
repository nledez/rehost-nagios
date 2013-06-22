require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: md
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::md'do
  describe "md test works" do
    it "Can launch md tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_md}.must_match /^MD: /
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_mdadm}.must_match /^MD: /
    end
  end
end
