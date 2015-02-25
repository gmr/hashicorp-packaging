# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

$install = <<INSTALL
sudo apt-get update -q
sudo apt-get install -y -qq ruby-dev build-essential curl unzip
sudo gem install fpm
INSTALL

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'Ubuntu'
  config.vm.provision 'shell', inline: $install
  config.vm.synced_folder '.', '/home/vagrant/src'
  config.berkshelf.enabled = false
  if Vagrant.has_plugin?('vagrant-vbguest') then
    config.vbguest.auto_update = false
  end
end
