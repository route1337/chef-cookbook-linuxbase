#
# Cookbook Name:: r1337-linux-base
# Recipe:: prereqs
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# Run apt cookbook to refresh apt cache on Ubuntu-based systems
case node['platform']
  when 'ubuntu'
    include_recipe 'apt'
  else
    # Do nothing
end

# Make sure yum EPEL repo is added on CentOS-based systems
case node['platform']
  when 'centos'

    # Make sure the broken Fedora Rawhide repo is removed
    file '/etc/yum.repos.d/fedora-rawhide.repo' do
      action :delete
    end

    # Make sure the EPEL repo is added
    include_recipe 'yum-epel'
  else
    # Do nothing
end

# Purge unneeded default packages from the system based on OS
case node['platform']
  when 'ubuntu'
    # This creates an array of strings and performs the Chef package functionality of each array entry via a do loop
    %w{landscape-client-ui landscape-client-ui-install landscape-client landscape-common update-motd}.each do |pkg|
      package pkg do
        action :purge
      end
    end
  when 'centos'
    # No unneeded packages in CentOS right now
  else
    # Do nothing
end

# Install any needed packages we consider default
case node['platform']
  when 'ubuntu'
    %w{bmon htop vim curl gnupg2 atop git molly-guard python-pip python-dev python3-pip unzip psmisc}.each do |pkg|
      package pkg do
        action :install
      end
    end
  when 'centos'
    %w{vim-enhanced curl htop gnupg2 git lsof telnet net-tools bmon atop wget python2-pip python34-pip python34-devel unzip gcc psmisc bind-utils}.each do |pkg|
      package pkg do
        action :install
      end
    end
  else
    # Do nothing
end

# Make sure the tools directory exists
case node['platform']
  when 'ubuntu', 'centos'
    directory '/tools' do
      owner 'root'
      group 'root'
      mode 0700
      action :create
    end
  else
    # Do nothing
end

# Install any needed python 2.7 packages we consider default
case node['platform']
  when 'ubuntu'
    # Make sure python 2.7 has the latest pip
    execute 'Ensure latest pip2' do
      command '/usr/bin/python -m pip install --upgrade pip'
      not_if { File.exist?('/usr/lib/python2.7/dist-packages/pip') }
      action :run
    end
    # Specify the install manually since Chef does not have the best python management
    %w{urllib3 pyasn1}.each do |pypkg|
      execute "install #{pypkg}" do
        command "/usr/bin/python -m pip install --ignore-installed --upgrade #{pypkg}" # Let's just manually specify our python binary to be sure it's 2.7
        not_if { File.exist?("/usr/lib/python2.7/dist-packages/#{pypkg}") }
        action :run
      end
    end
  when 'centos'
    # Make sure python 2.7 has the latest pip
    execute 'Ensure latest pip2' do
      command '/usr/bin/python -m pip install --upgrade pip'
      not_if { File.exist?('/usr/lib/python2.7/site-packages/pip') }
      action :run
    end
    # Specify the install manually since Chef does not have the best python management
    %w{urllib3 pyasn1}.each do |pypkg|
      execute "install #{pypkg}" do
        command "/usr/bin/python -m pip install --ignore-installed --upgrade #{pypkg}" # Let's just manually specify our python binary to be sure it's 2.7
        not_if { File.exist?("/usr/lib/python2.7/site-packages/#{pypkg}") }
        action :run
      end
    end
  else
    # Do nothing
end
