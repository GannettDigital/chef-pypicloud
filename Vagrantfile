#-*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'pypicloud'
  config.vm.box = 'Centos6.5'
  config.omnibus.chef_version = :latest
  config.vm.network 'forwarded_port', guest: 80, host: 8000

  config.berkshelf.enabled = false

  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = '~/gitrepos/chef/cookbooks'
    chef.roles_path = '~/gitrepos/chef/roles'
    chef.data_bags_path = '~/gitrepos/chef/data_bags'
    chef.add_role('pypicloud')
    chef.json = {
    }
  end
end
