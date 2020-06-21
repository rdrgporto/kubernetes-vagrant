# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    # Configure VM
    config.vm.box = "ubuntu/xenial64"
    config.ssh.insert_key = true
    config.vm.network "public_network"

    # Configure provisioning
    config.vm.provision "shell", path: "./provision/bootstrap.sh"

    # Configure Virtualbox
    config.vm.provider "virtualbox" do |vb, override|
        vb.cpus = 2
        vb.memory = 2048
        vb.gui = false
        vb.name = "kubernetes"
    end

end
