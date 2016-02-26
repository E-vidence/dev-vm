# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|

  config.vm.box = "vStone/centos-7.x-puppet.3.x"

  config.vm.box_check_update = true

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5432, host: 5432

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.100.100"

  config.vm.synced_folder "../api", "/evidence_api"
  config.vm.synced_folder "../etl", "/evidence_etl"

  # config.vm.synced_folder "template_fi`les", "/etc/puppet/files"
  # config.vm.share_folder  "template_files", "/tmp/vagrant-puppet/templates"
  # config.vm.share_folder("modules", "/etc/puppet/modules", "modules")



  config.vm.hostname = "evidence-dev-box"


  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
  
    # Customize the amount of memory on the VM:
    vb.memory = "768"
  end

  # config.vm.provision "shell", path: "bootstrap.sh", run: "once"
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifest"
    puppet.manifest_file = "evidence.pp"
    puppet.module_path = "puppet/modules"

    puppet.options = ["--verbose", "--debug"]
  end

end
