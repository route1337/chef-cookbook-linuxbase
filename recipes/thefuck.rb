#
# Cookbook Name:: r1337-linux-base
# Recipe:: thefuck
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# Install thefuck
case node['platform']
  when 'ubuntu'
    # Make sure python 3 has the latest pip
    execute 'Ensure latest pip3' do
      command '/usr/bin/python3 -m pip install --upgrade pip'
      not_if { File.exist?('/usr/lib/python3/dist-packages/pip') }
      action :run
    end

    # The below case block deals with Ubuntu 14.04 not having up to date python3 repos due to Canonical not keeping things updated
    case node['platform_version']
      when '14.04'
        # Specify thefuck to be installed locked to version 3.00 due to Canonical's poor repo management
        execute 'install thefuck' do
          command 'pip3 install thefuck==3.00' # Let's just manually specify our python binary to be sure it's 3
          not_if { File.exist?('/usr/local/bin/thefuck') }
          action :run
        end
      else
        # Specify the install manually since Chef does not have the best python management
        execute 'install thefuck' do
          command '/usr/bin/python3 -m pip install --ignore-installed --upgrade thefuck' # Let's just manually specify our python binary to be sure it's 3
          not_if { File.exist?('/usr/local/bin/thefuck') }
          action :run
        end
    end

    # Specify the install manually since Chef does not have the best python management
    execute 'install thefuck' do
      command 'pip3 install thefuck==3.00' # Let's just manually specify our python binary to be sure it's 3
      not_if { File.exist?('/usr/local/bin/thefuck') }
      action :run
    end
  when 'centos'
    # Make sure python 3 has the latest pip
    execute 'Ensure latest pip3' do
      command '/usr/bin/python3.4 -m pip install --upgrade pip'
      not_if { File.exist?('/usr/lib/python3.4/site-packages/pip') }
      action :run
    end
    # Specify the install manually since Chef does not have the best python management
    execute 'install thefuck' do
      command 'pip3 install --ignore-installed --upgrade thefuck' # Let's just manually specify our python binary to be sure it's 3
      not_if { File.exist?('/usr/bin/thefuck') }
      action :run
    end
  else
    # Do nothing
end

# Check out custom thefuck rules provided by Ahrenstein
case node['platform']
  when 'ubuntu', 'centos'
    # Create the directory structure for the repo
    %w{/root/.config /root/.config/thefuck /root/.config/thefuck/rules}.each do |confdir|
      directory confdir do
        owner 'root'
        group 'root'
        mode 0750
        action :create
      end
    end

    # Checkout the repi
    git 'thefuck rules' do
      destination '/root/.config/thefuck/rules'
      repository 'https://github.com/ahrenstein/thefuck-rules.git'
      revision 'master'
      action :sync
    end

    # Make sure the repo is not tampered with by resetting it
    execute 'git reset thefuck rules' do
      command 'git reset --hard HEAD && git clean -fd'
      cwd '/root/.config/thefuck/rules'
    end
  else
    # Do nothing
end
