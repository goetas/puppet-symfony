Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu_1404_64"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  config.vm.network :private_network, ip: "192.168.10.10"

  config.vm.synced_folder "../", "/vagrant/", :nfs => true

  config.vm.provider :virtualbox do |vb|
     vb.gui = false
     vb.customize ["modifyvm", :id, "--memory", "512"]
   end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = ".puppet/manifests"
    puppet.module_path = ".puppet/modules"
    puppet.manifest_file  = "dev.pp"
  end
end
