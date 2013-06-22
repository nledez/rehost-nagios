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

  describe "NRPE is running" do
    it "Can speak with nrpe in local" do
      `/usr/lib/nagios/plugins/check_nrpe -H localhost`.match /^NRPE v2.12/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c not-exist`.match /^NRPE: Command 'not-exist' not defined$/
    end
  end

  describe "Default test works" do
    it "Can launch default tests" do
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_all_disks`.match /^DISK OK/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_swap`.match /^SWAP OK/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_memory`.match /^OK: Free memory percentage/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_syslog`.match /, command name 'syslog-ng'$/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_total_procs`.match /^PROCS OK:/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_cron`.match /with command name 'cron'/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_sshd`.match /with command name 'sshd'$/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_rsyslogd`.match /processes with command name 'rsyslogd'$/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_syslogd`.match /processes with command name 'syslogd'$/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_smtp`.match /^SMTP /
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_mailq`.match /mailq/
      `/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_all_disks`.match /^DISK OK/
    end
  end
end
