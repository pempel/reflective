# vi: set ft=ruby

Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "reflective.app" do |app|
    app.vm.box = "hashicorp/precise64"
    app.vm.hostname = "reflective"
    app.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

    app.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective.app"]
      virtualbox.customize ["modifyvm", :id, "--memory", "256"]
    end
  end
end
