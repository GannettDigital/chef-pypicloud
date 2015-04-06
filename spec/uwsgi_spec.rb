# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'pypicloud::uwsgi' do
  let :chef_run do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache').converge(described_recipe)
  end

  before do
    stub_data_bag_item('pypicloud', 'users').and_return({ id: 'users', users: { user: 'password' } })
    stub_data_bag_item('pypicloud', 'storage').and_return({ id: 'storage', bucket: 'can-has-bucket', access_key: 'can-has-access', secret_key: 'I-have-a-secret'  })
  end

  it 'creates a template for /etc/security/limits.d/uwsgi.conf' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_template('/etc/security/limits.d/uwsgi.conf').with(
      source: 'uwsgi.limits.erb'
    )
  end

  it 'does not restart uwsgi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to_not restart_service('uwsgi')
  end

  it 'creates a template /etc/uwsgi/uwsgi.ini and notifies uwsgi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_template('/etc/uwsgi/uwsgi.ini').with(
      source: 'uwsgi.ini.erb',
      mode:   0644,
      owner: 'root',
      group: 'root'
    )
    resource = chef_run.template('/etc/uwsgi/uwsgi.ini')
    expect(resource).to notify('service[uwsgi]').to(:restart).delayed
  end

  it 'includes the pypicloud::storage-file recipe by default' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('pypicloud::storage-file')
  end

  it 'includes the pypicloud::storage-s3 recipe when cachedb is set to `s3`' do
    chef_run.node.set['pypicloud']['storage']['type'] = 's3'
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('pypicloud::storage-s3')
  end

  it 'creates a link /etc/uwsgi/siteconf/pypicloud.ini' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_link('/etc/uwsgi/siteconf/pypicloud.ini').with(
      to: '/etc/uwsgi/appconf/pypicloud.ini'
    )
  end
end
