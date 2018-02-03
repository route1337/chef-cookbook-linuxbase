#
# Cookbook Name:: r1337-linux-base
# Spec:: thefuck
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-linux-base::thefuck

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

if os[:name] == 'ubuntu'

  describe file('/root/.config/thefuck/rules') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0750 }
  end

  describe file('/root/.config/thefuck/rules/README.md') do
    it { should exist }
  end

  describe package('python3-pip') do
    it { should be_installed }
  end

  describe package('python3-dev') do
    it { should be_installed }
  end

  describe file('/usr/local/bin/thefuck') do
    it { should exist }
  end
elsif os[:name] == 'centos'

  describe file('/root/.config/thefuck/rules') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0750 }
  end

  describe file('/root/.config/thefuck/rules/README.md') do
    it { should exist }
  end

  describe package('gcc') do
    it { should be_installed }
  end

  describe package('python34-pip') do
    it { should be_installed }
  end

  describe package('python34-devel') do
    it { should be_installed }
  end

  describe file('/usr/bin/thefuck') do
    it { should exist }
  end
else
  # Do nothing
end
