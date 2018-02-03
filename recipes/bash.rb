#
# Cookbook Name:: r1337-linux-base
# Recipe:: bash
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# Remove root's bash
case node['platform']
  when 'ubuntu'
    file '/root/.bashrc' do
      action :delete
    end
  when 'centos'
    # Do nothing
  else
    # Do nothing
end

# Set the custom bashrc path
case node['platform']
  when 'ubuntu'
    bashpath =  '/etc/bash.bashrc'
  when 'centos'
    bashpath = '/etc/bashrc'
  else
    bashpath = '/etc/bash.bashrc' # Just to avoid throwing errors
end

# Deploy the custom bashrc and required git.bash
case node['platform']
  when 'ubuntu', 'centos'
    template "#{bashpath}" do
      source 'bash.bashrc.erb'
      owner 'root'
      group 'root'
      mode 0644
    end

    template '/opt/git.bash' do
      source 'git.bash.erb'
      owner 'root'
      group 'root'
      mode 0644
    end
  else
    # Do nothing
end
