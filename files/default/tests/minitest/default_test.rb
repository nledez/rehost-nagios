require 'minitest/spec'
#
# Cookbook Name:: rehost-nagios
# Spec:: default
#
# Copyright 2013, ReHost
#
# All rights reserved - Do Not Redistribute
#

describe_recipe 'spec_rehost-nagios::default'do
  #describe "files" do
  #end

  describe "packages" do
    # = Checking for package install =
    it "installs nagios nrpe server & plugins" do
      [ "nagios-nrpe-server", "nagios-plugins", "nagios-plugins-basic", "nagios-plugins-standard" ].each do |p|
        package(p).must_be_installed
      end
    end
  end

  describe "services" do
    # You can assert that a service must be running following the converge:
    it "nrpe run as a deamon" do
      service("nrpe").must_be_running
    end

    # And that it will start when the server boots:
    it "nrpe launch on startup" do
      service("nagios-nrpe-server").must_be_enabled
    end
  end
end
