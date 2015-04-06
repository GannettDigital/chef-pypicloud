# encoding: utf-8
require 'chefspec'
require 'spec_helper'
require 'fauxhai'

describe 'pypicloud::nginx' do
  let :chef_run do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache').converge(described_recipe)
  end

  it 'does not restart nginx' do
    expect(chef_run).to_not restart_service('nginx')
  end

  it 'creates a template /etc/nginx/conf.d/http.conf and notifies nginx' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/http.conf').with(
      source: 'http.conf.erb',
      mode:   0644,
      owner: 'root',
      group: 'root',
      action: [:create]
    )
    resource = chef_run.template('/etc/nginx/conf.d/http.conf')
    expect(resource).to notify('service[nginx]').to(:restart).delayed
  end

  it 'creates a template /etc/nginx/sites-available/pypicloud and notifies nginx' do
    expect(chef_run).to create_template('/etc/nginx/sites-available/pypicloud').with(
      source: 'nginx-site.erb',
      mode:   0644,
      owner: 'root',
      group: 'root',
      action: [:create]
    )
    resource = chef_run.template('/etc/nginx/sites-available/pypicloud')
    expect(resource).to notify('service[nginx]').to(:restart).delayed
  end

  it 'creates a link /etc/nginx/sites-enabled/pypicloud' do
    expect(chef_run).to create_link('/etc/nginx/sites-enabled/pypicloud').with(
      to: '/etc/nginx/sites-available/pypicloud'
    )
  end
end
