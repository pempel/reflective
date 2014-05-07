namespace :ssh do
  desc "Set up the ssh things."
  task :setup => :environment do
    unless env.to_sym.equal?(:dev)
      password    = ENV['password']
      ssh_config  = parse_template("ssh.config")
      ssh_key     = "~/.ssh/#{domain}_rsa"
      ssh_cmd     = "ssh #{user}@#{address} -o 'StrictHostKeyChecking no'"
      sshpass_cmd = "sshpass -p '#{password}' #{ssh_cmd}"

      system %{
        echo "-----> Setting up ssh things";
        if [ ! -f #{ssh_key} ]; then
          ssh-keygen -b 2048 -t rsa -f #{ssh_key} -q -N "";
        fi
      }

      if password.nil? or password.empty?
        system %{
          cat ~/.ssh/config 2>/dev/null | grep #{domain} > /dev/null 2>&1;
          if [ $? -ne 0 ]; then
            echo "----->   Failed. Try again with password.";
            exit;
          else
            echo "----->   Already set up.";
          fi
        }
      else
        system %{
          cat ~/.ssh/config 2>/dev/null | grep #{domain} > /dev/null;
          if [ $? -ne 0 ]; then
            cat #{ssh_key}.pub | #{sshpass_cmd} "cat >> ~/.ssh/authorized_keys";
            sudo sh -c "echo '#{ssh_config}' >> ~/.ssh/config";
          else
            echo "----->   Already set up.";
          fi
        }
      end
    end
  end
end
