# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'pypicloud::storage-s3' do
  let :chef_run do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache').converge(described_recipe)
  end

  before do
    stub_data_bag_item('pypicloud', 'users').and_return({ id: 'users', users: { user: 'password' } })
    stub_data_bag_item('pypicloud', 'storage').and_return({ id: 'storage', bucket: 'can-has-bucket', access_key: 'can-has-access', secret_key: 'I-have-a-secret'  })
  end

  it 'creates a template /etc/uwsgi/appconf/pypicloud.ini and notifies uwsgi' do
    chef_run.converge(described_recipe)
    expect(chef_run).to create_template('/etc/uwsgi/appconf/pypicloud.ini').with(
      source: 'pypicloud.ini.erb',
      mode:   0644,
      owner: 'root',
      group: 'root'
    )
    resource = chef_run.template('/etc/uwsgi/appconf/pypicloud.ini')
    expect(resource).to notify('service[uwsgi]').to(:restart).delayed
  end
end
