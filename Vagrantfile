# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hiroshima-arc/manhattan"
  config.vm.box_version = "1.0.2"

  config.vm.network :forwarded_port, guest:5000, host:5000, id:"rails"
  config.vm.network :forwarded_port, guest:9292, host:9292, id:"node"
  config.vm.network :forwarded_port, guest:8808, host:8808, id:"docs"
  config.vm.network :forwarded_port, guest:8080, host:9000, id:"jenkins"
  config.vm.network :forwarded_port, guest:3306, host:3306, id:"mysql"
  config.vm.network :forwarded_port, guest:5432, host:5432, id:"postgresql"
  config.vm.network :forwarded_port, guest:6379, host:6379, id:"redis"
  config.vm.network :forwarded_port, guest:27017, host:27017, id:"mongodb"
  config.vm.network :private_network, ip:"127.0.0.1"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
