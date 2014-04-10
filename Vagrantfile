# vi: set ft=ruby

$provision = <<SCRIPT
sudo sh -c "echo 'Europe/Moscow' > /etc/timezone"
sudo dpkg-reconfigure -f noninteractive tzdata > /dev/null

wget http://apt.puppetlabs.com/puppetlabs-release-precise.deb
sudo dpkg -i puppetlabs-release-precise.deb
sudo apt-get update
sudo apt-get -y install puppet
SCRIPT

Vagrant.configure("2") do |config|
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.define "reflective.app" do |app|
    app.vm.box = "hashicorp/precise64"
    app.vm.hostname = "reflective.app"
    app.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true

    app.vm.provider "virtualbox" do |virtualbox|
      virtualbox.customize ["modifyvm", :id, "--name", "reflective.app", "--memory", "256"]
    end

    app.vm.provision "shell", inline: $provision
    app.vm.provision "puppet" do |puppet|
      puppet.module_path = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "site.pp"
      puppet.options = "--verbose"
    end
  end
end
