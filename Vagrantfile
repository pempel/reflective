Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--name", "reflective", "--memory", "256"]
    virtualbox.customize ["setextradata", :id, "VBoxInternal/Devices/VMMDev/0/Config/GetHostTimeDisabled", 1]
  end
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "main.pp"
    puppet.options = "--verbose"
  end
  config.vm.box = "precise64"
  config.vm.hostname = "reflective"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
