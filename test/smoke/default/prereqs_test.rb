#
# Cookbook Name:: r1337-linux-base
# Spec:: prereqs
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# # encoding: utf-8

# Inspec test for recipe r1337-linux-base::prereqs

if os[:name] == 'ubuntu'

  # Check for the tools directory
  describe file('/tools') do
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0700 }
  end

  # Verify the packages we don't want are removed
  %w{landscape-client-ui landscape-client-ui-install landscape-client landscape-common update-motd}.each do |pkg|
    describe package(pkg) do
      it { should_not be_installed }
    end
  end

  # Verify the packages we want are installed
  %w{bmon htop vim curl gnupg2 atop git molly-guard python-pip python-dev python3-pip unzip psmisc}.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  # Verify all required python 2.7 packages are installed
  %w{urllib3 pyasn1}.each do |pypkg|
    describe pip(pypkg) do
      it { should be_installed }
    end
  end

elsif os[:name] == 'centos'

  # Make sure the broken Fedore Rawhide repo was removed
  describe file('/etc/yum.repos.d/fedora-rawhide.repo') do
    it { should_not exist }
  end

  # Make sure the EPEL repo is here
  describe file('/etc/yum.repos.d/epel.repo') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 0644 }
    its(:content) { should match /mirrors\.fedoraproject\.org/ }
    its(:content) { should match /RPM-GPG-KEY-EPEL-7/ }
  end

  # Verify the packages we want are installed
  %w{vim-enhanced curl htop gnupg2 git lsof telnet net-tools bmon atop wget python2-pip python34-pip python34-devel unzip gcc psmisc bind-utils}.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end

  # Verify all required python 2.7 packages are installed
  %w{urllib3 pyasn1}.each do |pypkg|
    describe pip(pypkg) do
      it { should be_installed }
    end
  end
else
  # Do nothing
end
