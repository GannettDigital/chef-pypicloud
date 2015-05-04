#
# Cookbook Name:: pypicloud
# Recipe:: nginx
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#

ssl_cert = data_bag_item(node['pypicloud']['data_bag'], node['pypicloud']['ssl-name'])

template "#{node['pypicloud']['sslcert-path']}/#{node['pypicloud']['ssl-name']}.crt" do
  source 'pypicloud_cert.crt.erb'
  owner  node['pypicloud']['user']
  variables(
    :primary_cert => ssl_cert['primary_cert'],
    :intermediate_cert => ssl_cert['intermediate_cert']
  )
end

template "#{node['pypicloud']['sslcert-path']}/#{node['pypicloud']['ssl-name']}.key" do
  source 'pypicloud_cert.key.erb'
  owner  node['pypicloud']['user']
  variables(
    :private_key => ssl_cert['private_key']
  )
end

service 'nginx' do
  supports :status => true, :start => true, :stop => true, :restart => true
  action :nothing
end

template '/etc/nginx/sites-available/pypicloud-ssl' do
  source 'nginx-site-ssl.erb'
  mode 0644
  owner 'root'
  group 'root'
  action :create
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/pypicloud-ssl' do
  to '/etc/nginx/sites-available/pypicloud-ssl'
end
