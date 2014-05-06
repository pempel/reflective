# vi: set ft=ruby

Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "reflective-dev" do |dev|
    dev.vm.box = "ubuntu/trusty64"
    dev.vm.hostname = "reflective-dev"
    dev.vm.network "private_network", ip: "192.168.56.101"
    dev.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
    dev.vm.synced_folder ".", "/var/apps/reflective", nfs: true
    dev.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective-dev"]
      virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
    end
    dev.vm.provision "shell" do |shell|
      shell.path = "config/supply/dev.sh"
      shell.args = ["/var/apps/reflective", `cat .ruby-version`.strip]
      shell.privileged = false
    end
  end

  config.vm.define "reflective-test" do |test|
    test.vm.box = "ubuntu/trusty64"
    test.vm.hostname = "reflective-test"
    test.vm.network "private_network", ip: "192.168.56.102"
    test.vm.network "forwarded_port", guest: 80, host: 8082, auto_correct: true
    test.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective-test"]
      virtualbox.customize ["modifyvm", :id, "--memory", "1024"]
    end
    test.vm.provision "shell" do |shell|
      shell.path = "config/supply/test.sh"
      shell.args = ["/var/apps/reflective", `cat .ruby-version`.strip]
      shell.privileged = false
    end
  end
end
