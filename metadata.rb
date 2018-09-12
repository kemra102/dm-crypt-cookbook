name 'dm-crypt'
maintainer 'Danny Roberts'
maintainer_email 'danny@thefallenphoenix.net'
license 'BSD-2-Clause'
description 'Installs/Configures dm-crypt'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.1'

chef_version '>= 12.5' if respond_to?(:chef_version)

%w[centos oracle redhat scientific].each do |os|
  supports os, '>= 7.0'
end
supports 'ubuntu', '>= 14.04'
supports 'debian', '>= 8.0'

source_url 'https://github.com/kemra102/dm-crypt-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/kemra102/dm-crypt-cookbook/issues' if
  respond_to?(:issues_url)
