name 'r1337-linux-base'
maintainer 'Matthew Ahrenstein'
maintainer_email 'matthew@route1337.com'
license 'MIT'
description 'Confgure basic settings, packages and services on Linux servers'
long_description 'This Chef cookbook will configure some basic system settings, add/remove some common packages, and deploy standard configurations for some common services'
version '0.1.6'
chef_version '>= 13.6.4' if respond_to?(:chef_version)
issues_url 'https://github.com/route1337/chef-cookbook-linuxbase/issues'
source_url 'https://github.com/route1337/chef-cookbook-linuxbase'
depends          'apt'
depends          'yum-epel'

%w{ ubuntu centos }.each do |os|
  supports os
end

recipe 'r1337-linux-base::default', 'Call this recipe to run the various tweaks from the cookbook'
recipe 'r1337-linux-base::prereqs', 'Called by default. Run all the prerequisites to system management'
recipe 'r1337-linux-base::bash', 'Called by default. Configures the custom bash profile'
recipe 'r1337-linux-base::thefuck', 'Called by default. Installs and configures thefuck'
recipe 'r1337-linux-base::ntp', 'Called by default. Installs and configures ntp for the New York timezone'
