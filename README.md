Note: This cookbook is still in quasi-dev state and will not pass test kitchen without a backup file.
For dev/testing purposes I snap backup of a vanila chef server with a few changes.
I keep it in the root of the cookbook which I mount as /varant via .kitchen.yml


This cookbook is based on chef-server cookbook. 
It adds additional functionality to:
* restore from backup
* lock versions of add-ons instead of always installing the latest (locked in Berksfile)
* install supermarket

# Attributes
You can wrap all chef-server attributes as you would with a regular wrapper cookbook via `default['chef-server']...`
You can wrap all supermartket attributes via `default['supermarket_omnibus']`

You can enable restore from backup by specifying the following attributes:
default['chef-server-restore']['restore'] = true
default['chef-server-restore']['backup_staging'] = Chef::Config[:file_cache_path]
default['chef-server-restore']['backups_folder'] = '/var/opt/chef-backup'
default['chef-server-restore']['file_to_restore'] = 'latest'

When ['chef-server-restore']['restore'] is set to true, restore from backup recipe will be executed.
['backup_staging'] - attribute controls where the backup file will be stored on the server.
['backups_folder'] - local or remote location where all backups are stored
['file_to_restore'] - specific file to restore from remote location, or 'latest' to just pull the latest.