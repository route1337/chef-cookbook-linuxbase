#
# Cookbook Name:: r1337-linux-base
# Spec:: ntp
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-linux-base::ntp

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os[:name] == 'ubuntu'

  # Verify the NTP config exists
  describe file('/etc/ntp.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0644 }
  end

  # Verify the ntp package is installed
  describe package('ntp') do
    it { should be_installed }
  end

  # Verify the localtime is set correctly
  describe file('/etc/localtime') do
    it { should be_symlink }
    it { should be_linked_to '/usr/share/zoneinfo/posixrules' } # This is the final link for /usr/share/zoneinfo/America/New_York on Ubuntu and inspec goes all the way down when checking symlinks
  end

  # Verify the timezone file is correct
  describe file('/etc/timezone') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0644 }
    its(:content) { should match /America\/New_York/ }
  end

  # Verify the ntp service is running and enabled
  describe service('ntp') do
    it { should be_enabled }
    it { should be_running }
  end

elsif os[:name] == 'centos'

  # Verify the NTP config exists
  describe file('/etc/ntp.conf') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0644 }
  end

  # Verify the ntp package is installed
  describe package('ntp') do
    it { should be_installed }
  end

  # Verify the localtime is set correctly
  describe file('/etc/localtime') do
    it { should be_symlink }
    it { should be_linked_to '/usr/share/zoneinfo/America/New_York' }
  end

  # Verify the ntp service is running and enabled
  describe service('ntpd') do
    it { should be_enabled }
    it { should be_running }
  end
else
  # Do nothing
end
