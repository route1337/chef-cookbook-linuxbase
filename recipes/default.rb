#
# Cookbook Name:: r1337-linux-base
# Recipe:: default
#
# Copyright 2018, Route 1337, LLC, All Rights Reserved.
#
# Maintainers:
# - Matthew Ahrenstein: matthew@route1337.com
#
# See LICENSE
#

# Default is just going to call the other recipes in this cookbook where the actual meat of the code is
# We check for the correct OS in the included recipes

# Run all the prerequisites to system management
include_recipe 'r1337-linux-base::prereqs'

# Deploy the custom bash profile
include_recipe 'r1337-linux-base::bash'

# Install and configure thefuck
include_recipe 'r1337-linux-base::thefuck'

# Install and configure ntp for the New York timezone
include_recipe 'r1337-linux-base::ntp'
