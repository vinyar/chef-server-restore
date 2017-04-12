## ============================================== START test code ==============================================
# require 'pry';binding.pry

a = directory '/var/opt/chef-backup'
a.run_action(:create)

remote_file '/var/opt/chef-backup/server-backup.tgz' do
  source 'file:///vagrant/chef-backup-2017-04-11-06-40-04.tgz'
end

# not sure if this actually works
delete_resource(:ingredient_config, 'chef-server')

# chef-server-ctl user-create alex alex vinyar alex@chef.io alexalex
# chef-server-ctl org-create alex_org alex_org_long_name -a alex
# chef-server-ctl org-user-add alex_org alex -a
# chef-server-ctl grant-server-admin-permissions alex
## ============================================== END test code ==============================================

# chef-server-ctl cleanse yes
omnibus_service 'prepare chef server for restoration by nuking all data' do
  ctl_command 'chef-server-ctl cleanse yes'
  notifies :create, 'directory[/etc/opscode]', :immediately
  notifies :touch, 'file[server_restored]', :immediately
  not_if { File.exist?('/etc/opscode/server_restored') }
end

directory '/etc/opscode' do
  action :nothing
end

file 'server_restored' do
  name '/etc/opscode/server_restored'
  action :nothing
end

# copy backup locally to a staging folder
backup_to_restore = "#{node['chef-server-restore']['backup_staging']}/backup_to_restore.tgz"

remote_file backup_to_restore do
  source lazy {
    a = case node['chef-server-restore']['file_to_restore']
        when 'latest'
          # Find the latest file in the directory. Probably wont work with S3
          # Can later add some call to S3
          Dir.glob("#{node['chef-server-restore']['backups_folder']}/*").sort_by { |f| File.mtime(f) }.reverse[0]
        else
          File.join(node['chef-server-restore']['backups_folder'], node['chef-server-restore']['file_to_restore'])
        end
    # remote_file needs absolute uri in /// format.
    Addressable::URI.convert_path(a).to_s
  }
end

omnibus_service 'restore backup' do
  ctl_command "chef-server-ctl restore #{backup_to_restore} -c"
  only_if { File.exist?('/etc/opscode/server_restored') }
  not_if { File.exist?('/etc/opscode/backup_restored') }
  notifies :touch, 'file[/etc/opscode/backup_restored]', :immediately
end

file '/etc/opscode/backup_restored' do
  action :nothing
end
