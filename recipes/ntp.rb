#
# Cookbook Name:: r1337-linux-base
# Recipe:: ntp
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# Set the correct time zone for localtime
link 'localtime' do
  target_file '/etc/localtime'
  to '/usr/share/zoneinfo/America/New_York'
  link_type :symbolic
  action :create
end

# Ubuntu also needs the timezone file configured
case node['platform']
  when 'ubuntu'
    # Only Ubuntu uses the timezone file as well
    file 'timezone' do
      path '/etc/timezone'
      content 'America/New_York'
      force_unlink true
      owner 'root'
      group 'root'
      mode 0644
    end
  else
    # Do nothing
end

package 'ntp' do
  action :install
end

# Set variables for making sure the ntp service is started and enabled
case node['platform']
  when 'ubuntu'
    ntp_service_name = 'ntp'
  when 'centos'
    ntp_service_name = 'ntpd'
  else
    ntp_service_name = 'ntp' #We'll just assume everyone else uses ntp
end

# Make sure the ntp service is running and enabled
service ntp_service_name do
  action [ :enable, :start]
  subscribes :restart, 'file[/etc/ntp.conf', :immediately #Restart ntp service if Chef edits ntp.conf
end

# Deploy the ntp.conf
template '/etc/ntp.conf' do
  source 'ntp.conf.erb'
  owner 'root'
  group 'root'
  mode 0644
end
