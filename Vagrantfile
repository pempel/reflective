Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.box = "puppetlabs/ubuntu-13.10-64-puppet"
  config.vm.hostname = "reflective"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.customize ["modifyvm", :id, "--name", "reflective", "--memory", "256"]
  end

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file = "main.pp"
    puppet.module_path = "puppet/modules"
    puppet.options = "--verbose"
  end
end
