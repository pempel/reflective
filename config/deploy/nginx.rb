namespace :nginx do
  desc "Set up the nginx directory structure."
  task :setup => :environment do
    command = %{
      echo "-----> Setting up #{nginx_logs_path}" &&
      if [ -d #{nginx_logs_path} ]; then
        echo "----->   Already set up.";
      else
        #{echo_cmd %{sudo mkdir -p "#{nginx_logs_path}"}} &&
        #{echo_cmd %{sudo chown -R "#{nginx_user}" "#{nginx_logs_path}"}} &&
        echo "----->   Succeed."
      fi
    }
    env.to_sym.equal?(:dev) ? system(command) : queue(command)
  end

  desc "Restart nginx."
  task :restart => :environment do
    commands = [
      %{echo "-----> Restarting nginx"},
      %{sudo service nginx restart > /dev/null 2>&1}
    ].each { |c| env.to_sym.equal?(:dev) ? system(c) : queue(c) }
  end

  namespace :config do
    desc "Update the nginx configuration file."
    task :update => [:move, :link]

    desc "Move the nginx configuration file to the sites-available directory"
    task :move => :environment do
      file_path = "#{nginx_sites_available_path}/#{app}"
      commands = [
        %{echo "-----> Moving nginx.conf to #{file_path}"},
        %{sudo sh -c "echo '#{parse_template("nginx.conf")}' > #{file_path}"}
      ].each { |c| env.to_sym.equal?(:dev) ? system(c) : queue(c) }
    end

    desc "Link to the nginx configuration file."
    task :link => :environment do
      file_path = "#{nginx_sites_available_path}/#{app}"
      link_name = "#{nginx_sites_enabled_path}/#{app}"
      commands = [
        %{echo "-----> Creating a symbolic link to #{file_path}"},
        %{sudo ln -fs #{file_path} #{link_name}}
      ].each { |c| env.to_sym.equal?(:dev) ? system(c) : queue(c) }
    end

    desc "Print the nginx configuration file to STDOUT."
    task :print => :environment do
      puts parse_template("nginx.conf")
    end
  end
end
