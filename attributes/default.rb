
## General
default['chef-server']['version'] = '12.14.0'
default['chef-server']['addons'] = { manage: '2.5.0' }
default['chef-server']['accept_license'] = true
# default['chef-server']['configuration'] = <<-CONFIG
# custom stuff goes here
# if anything is applicable
# CONFIG

## Backup related
default['chef-server-restore']['restore'] = true
default['chef-server-restore']['backup_staging'] = Chef::Config[:file_cache_path]
default['chef-server-restore']['backups_folder'] = '/var/opt/chef-backup'
default['chef-server-restore']['file_to_restore'] = 'latest'

## Supermarket specific attributes
default['supermarket_omnibus']['package_version'] = '3.0.0'
default['supermarket_omnibus']['chef_server_url'] = 'https://chef_server01.labkey.com'
default['supermarket_omnibus']['chef_oauth2_app_id'] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
default['supermarket_omnibus']['chef_oauth2_secret'] = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'

## Additional attributes
# default['supermarket_omnibus']['chef_oauth2_verify_ssl'] = false
# default['supermarket_omnibus']['package_url'] = nil # in case you host packages internally
# default['supermarket_omnibus']['chef_oauth2_verify_ssl'] = false
# default['supermarket_omnibus']['config']['nginx']['force_ssl'] = true
# default['supermarket_omnibus']['config']['ssl']['certificate'] = '/etc/supermarket/certs/custom_cert.pem'
# default['supermarket_omnibus']['config']['ssl']['certificate_key'] = '/etc/supermarket/certs/custom_cert_nopass.key'
