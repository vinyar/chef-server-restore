name 'chef-server-restore'
maintainer 'Alex Vinyar'
maintainer_email 'alex@chef.io'
license 'all_rights'
description 'Installs Chef Server and optionally restores backup'
long_description 'Installs Chef Server, Supermarket and optionally restores chef-server from backup'
version '0.2.0'

issues_url 'https://github.com/vinyar/chef-server-restore/issues' if respond_to?(:issues_url)
source_url 'https://github.com/vinyar/chef-server-restore' if respond_to?(:source_url)

depends 'chef-server'
depends 'supermarket-omnibus-cookbook'
