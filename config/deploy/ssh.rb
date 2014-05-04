namespace :ssh do
  desc "Set up the ssh things."
  task :setup => :environment do
    set :ssh_host,          ENV["host"]
    set :ssh_host_name,     ENV["hostname"]
    set :ssh_host_user,     ENV["user"]
    set :ssh_host_password, ENV["password"]

    if env.to_sym.equal?(:dev)
      ssh       = "ssh #{ssh_host_user}@#{ssh_host_name}"
      sshpass   = "sshpass -p '#{ssh_host_password}' #{ssh}"
      sshconfig = parse_template("ssh.config.erb")
      id_rsa    = "~/.ssh/id_rsa"

      system %{
        echo "-----> Setting up ssh things" &&
        if [ ! -f #{id_rsa} ]; then
          ssh-keygen -b 2048 -t rsa -f #{id_rsa} -q -N "";
        fi &&
        cat #{id_rsa}.pub | #{sshpass} "cat >> ~/.ssh/authorized_keys" &&
        sudo sh -c "echo '#{sshconfig}' >> ~/.ssh/config"
      }
    end
  end
end
