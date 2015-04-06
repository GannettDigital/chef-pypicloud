#
# Cookbook Name:: chef-pypicloud
# Recipe:: default
#
# Copyright 2015, Gannett
#
# All rights reserved - Do Not Redistribute
#

# Create user/group

user node['pypicloud']['user'] do
  action :create
end

group node['pypicloud']['group'] do
  members node['pypicloud']['user']
  action :create
end

# Create Path

directory node['pypicloud']['installdir'] do
  mode 0755
  owner node['pypicloud']['user']
  group node['pypicloud']['group']
  recursive true
end

# Create Virtualenv

python_virtualenv node['pypicloud']['installdir'] do
  owner node['pypicloud']['user']
  group node['pypicloud']['group']
  action :create
end

# Install pypicloud

python_pip 'pypicloud' do
  action :upgrade
  version node['pypicloud']['version']
  virtualenv node['pypicloud']['installdir']
end

python_pip 'pastescript' do
  action :upgrade
  virtualenv node['pypicloud']['installdir']
end

python_pip 'redis' do
  action :upgrade
  virtualenv node['pypicloud']['installdir']
  only_if { node['pypicloud']['cachedb']['type'] == 'redis' }
end

include_recipe 'pypicloud::redis' if node['pypicloud']['cachedb']['type'] == 'redis'
include_recipe 'pypicloud::nginx'
include_recipe 'pypicloud::uwsgi'
