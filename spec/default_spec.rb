# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'pypicloud::default' do
  let :chef_run do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache').converge(described_recipe)
  end

  before do
    stub_data_bag_item('pypicloud', 'users').and_return({ id: 'users', users: { user: 'password' } })
  end

  it 'creates a user pypi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_user('pypi')
  end

  it 'creates a group pypi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_group('pypi').with(
      members: [ 'pypi' ]
    )
  end

  it 'creates a directory `/opt/pypi`' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_directory('/opt/pypi').with(
      mode: 0755,
      user: 'pypi',
      group: 'pypi'
    )
  end

  it 'creates a virtualenv `/opt/pypi`' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_python_virtualenv('/opt/pypi')
  end

  it 'installs pypicloud' do
    chef_run.converge(described_recipe)
    expect(chef_run).to upgrade_python_pip('pypicloud')
  end

  it 'installs pastescript' do
    chef_run.converge(described_recipe)
    expect(chef_run).to upgrade_python_pip('pastescript')
  end

  it 'do not install redis if not enabled' do
    chef_run.converge(described_recipe)
    expect(chef_run).to_not upgrade_python_pip('redis')
  end

  it 'installs redis when enabled' do
    chef_run.node.set['pypicloud']['cachedb']['type'] = 'redis'
    chef_run.converge(described_recipe)
    expect(chef_run).to upgrade_python_pip('redis')
  end

  it 'includes pypicloud::redis when enabled' do
    chef_run.node.set['pypicloud']['cachedb']['type'] = 'redis'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('pypicloud::redis')
  end

  it 'includes pypicloud::uwsgi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('pypicloud::uwsgi')
  end

  it 'includes pypicloud::nginx' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('pypicloud::nginx')
  end
end
