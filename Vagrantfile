# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  # ========================================
  # VM 1 : srv-db (Serveur Base de Données)
  # ========================================
  config.vm.define "srv-db" do |db|
    db.vm.box = "ubuntu/jammy64"
    db.vm.hostname = "srv-db"
    db.vm.network "private_network", ip: "192.168.56.11"
    
    db.vm.provider "virtualbox" do |vb|
      vb.name = "srv-db"
      vb.memory = "1024"
      vb.cpus = 1
    end
    
    db.vm.provision "shell", inline: <<-SHELL
      apt-get update
      echo "✓ VM srv-db créée avec succès!"
    SHELL
  end
  
  # ========================================
  # VM 2 : srv-app (Serveur Application)
  # ========================================
  config.vm.define "srv-app" do |app|
    app.vm.box = "ubuntu/jammy64"
    app.vm.hostname = "srv-app"
    app.vm.network "private_network", ip: "192.168.56.10"
    app.vm.network "forwarded_port", guest: 8080, host: 8081
    
    app.vm.provider "virtualbox" do |vb|
      vb.name = "srv-app"
      vb.memory = "2048"
      vb.cpus = 2
    end
    
    app.vm.provision "shell", inline: <<-SHELL
      apt-get update
      echo "✓ VM srv-app créée avec succès!"
    SHELL
  end
  
end