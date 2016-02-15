name 'dm-crypt'
maintainer 'Danny Roberts'
maintainer_email 'danny@thefallenphoenix.net'
license 'BSD-2-Clause'
description 'Installs/Configures dm-crypt'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

%w(centos oracle redhat scientific).each do |os|
  supports os, '>= 7.0'
end
supports 'ubuntu', ['= 12.04', '=14.04']
supports 'debian', '>= 7.0'

source_url 'https://github.com/kemra102/dm-crypt-cookbook' if
  respond_to?(:source_url)
issues_url 'https://github.com/kemra102/dm-crypt-cookbook/issues' if
  respond_to?(:issues_url)
