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
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost}.must_match /^NRPE v2.12/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c not-exist}.must_match /^NRPE: Command 'not-exist' not defined$/
    end
  end

  describe "Default test works" do
    it "Can launch default tests" do
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_all_disks}.must_match /^DISK OK/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_swap}.must_match /^SWAP OK/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_memory}.must_match /^OK: Free memory percentage/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_syslog}.must_match /, command name 'syslog-ng'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_total_procs}.must_match /^PROCS OK:/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_cron}.must_match /with command name 'cron'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_sshd}.must_match /with command name 'sshd'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_rsyslogd}.must_match /with command name 'rsyslogd'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_proc_syslogd}.must_match /processes with command name 'syslogd'/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_smtp}.must_match /^SMTP /
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_mailq}.must_match /mailq/
      %x{/usr/lib/nagios/plugins/check_nrpe -H localhost -c check_all_disks}.must_match /^DISK OK/
    end
  end
end
