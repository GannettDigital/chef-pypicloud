#
# Cookbook Name:: chef-pypicloud
# Recipe:: storage-file
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#

service 'uwsgi' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
end

directory node['pypicloud']['storage']['filedir'] do
  mode 0755
  owner node['pypicloud']['uwsgi']['uid']
  group node['pypicloud']['group']
  recursive true
end

udb = data_bag_item('pypicloud', 'users')
users = udb['users']

template '/etc/uwsgi/appconf/pypicloud.ini' do
  source 'pypicloud.ini.erb'
  action :create
  mode 0644
  owner 'root'
  group 'root'
  variables :users => users
  notifies :restart, 'service[uwsgi]'
end
