#
# Cookbook Name:: pypicloud
# Recipe:: uwsgi
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#

service 'uwsgi' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
end

template '/etc/security/limits.d/uwsgi.conf' do
  source 'uwsgi.limits.erb'
end

template '/etc/uwsgi/uwsgi.ini' do
  source 'uwsgi.ini.erb'
  mode 0644
  owner 'root'
  group 'root'
  variables(
    :emperor => node['pypicloud']['uwsgi']['emperor'],
    :uid => node['pypicloud']['uwsgi']['uid']
  )
  notifies :restart, 'service[uwsgi]'
end

include_recipe "pypicloud::storage-#{node['pypicloud']['storage']['type']}"

link '/etc/uwsgi/siteconf/pypicloud.ini' do
  to '/etc/uwsgi/appconf/pypicloud.ini'
end
