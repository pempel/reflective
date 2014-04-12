require_relative "environment"
require_relative "extra"

namespace :nginx do
  desc "Restarts nginx."
  task :restart do
    queue %{echo "-----> Restarting nginx"}
    queue %{sudo service nginx restart > /dev/null}
  end

  namespace :config do
    desc "Updates the nginx config file."
    task :update => [:upload, :link]

    desc "Parses the nginx config file and uploads it to the server"
    task :upload => :environment do
      queue %{echo "-----> Put nginx.conf to #{nginx_config}"}
      queue %{echo "#{parse_template("nginx.conf.erb")}" > "#{nginx_config}"}
    end

    desc "Creates symbolic links to the nginx config file."
    task :link => :environment do
      queue %{echo "-----> Create symbolic links to nginx.conf"}
      queue echo_cmd %{sudo ln -fs "#{nginx_config}" "#{nginx_available_config}"}
      queue echo_cmd %{sudo ln -fs "#{nginx_config}" "#{nginx_enabled_config}"}
    end

    desc "Parses the nginx config file and outputs it to STDOUT (local task)."
    task :print => :environment do
      puts parse_template("nginx.conf.erb")
    end
  end
end
