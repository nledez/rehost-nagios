require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: imap
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::imap'do
  describe "imap test works" do
    it "Can launch imap tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_imap}.must_match /^Connection refused/
    end
  end
end
