#
# Cookbook:: syseng-chefsrv
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'chef-server'

include_recipe '::_restore_backup' if node['chef-server-restore']['restore']

include_recipe 'chef-server::addons'
