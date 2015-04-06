#
# Cookbook Name:: chef-pypicloud
# Recipe:: storage-s3
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#

service 'uwsgi' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
end

udb = data_bag_item('pypicloud', 'users')
users = udb['users']

sdb = data_bag_item('pypicloud', 'storage')

template '/etc/uwsgi/appconf/pypicloud.ini' do
  source 'pypicloud.ini.erb'
  action :create
  mode 0644
  owner 'root'
  group 'root'
  variables(
    :users => users,
    :bucket => sdb['bucket'],
    :accesskey => sdb['access_key'],
    :secretkey => sdb['secret_key']
  )
  notifies :restart, 'service[uwsgi]'
end
