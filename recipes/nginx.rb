#
# Cookbook Name:: pypicloud
# Recipe:: nginx
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#
service 'nginx' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
end

template '/etc/nginx/conf.d/http.conf' do
  source 'http.conf.erb'
  mode 0644
  owner 'root'
  group 'root'
  action :create
  notifies :restart, 'service[nginx]'
end

template '/etc/nginx/sites-available/pypicloud' do
  source 'nginx-site.erb'
  mode 0644
  owner 'root'
  group 'root'
  action :create
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/pypicloud' do
  to '/etc/nginx/sites-available/pypicloud'
end
