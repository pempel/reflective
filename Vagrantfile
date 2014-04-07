Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |provider|
    provider.customize ["modifyvm", :id, "--name", "reflective", "--memory", "256"]
  end
  config.vm.box = "precise64"
  config.vm.hostname = "reflective"
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
