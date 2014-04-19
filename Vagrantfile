# vi: set ft=ruby

Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "reflective-work" do |work|
    work.vm.box = "hashicorp/precise64"
    work.vm.hostname = "reflective-work"
    work.vm.network "private_network", ip: "33.33.13.31"
    work.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
    work.vm.synced_folder ".", "/var/apps/reflective", nfs: true
    work.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective-work"]
      virtualbox.customize ["modifyvm", :id, "--memory", "256"]
    end
    work.vm.provision "shell" do |shell|
      shell.path = "config/shell/work.sh"
      shell.args = ["/var/apps/reflective", ENV["TIME_ZONE"] || "Europe/Moscow"]
      shell.privileged = false
    end
  end

  config.vm.define "reflective-test" do |test|
    test.vm.box = "hashicorp/precise64"
    test.vm.hostname = "reflective-test"
    test.vm.network "private_network", ip: "33.33.13.32"
    test.vm.network "forwarded_port", guest: 80, host: 8082, auto_correct: true
    test.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective-test"]
      virtualbox.customize ["modifyvm", :id, "--memory", "256"]
    end
  end
end
