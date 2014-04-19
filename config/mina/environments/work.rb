require_relative "../utils"

namespace :work do
  desc "Initialize the environment."
  task :initialize do
    set :app,                        "reflective"
    set :app_path,                   "/var/apps/#{app}"
    set :nginx_user,                 "www-data"
    set :nginx_path,                 "/etc/nginx"
    set :nginx_root_path,            "#{app_path}/public"
    set :nginx_logs_path,            "/var/log/nginx/#{app}"
    set :nginx_sites_available_path, "#{nginx_path}/sites-available"
    set :nginx_sites_enabled_path,   "#{nginx_path}/sites-enabled"
    set :nginx_server_name,          ".#{app}.work"
  end

  desc "Deploy the application."
  task :deploy do
    puts "-----> Deploying the application..."
    invoke "work:grunt:build"
    invoke "work:nginx:configure"
    invoke "work:nginx:config:update"
    invoke "work:nginx:restart"
  end

  namespace :grunt do
    desc "Build the application."
    task :build => :initialize do
      puts "-----> Building the application..."
      system %{cd #{app_path}}
      system %{grunt build > /dev/null 2>&1}
    end
  end

  namespace :nginx do
    desc "Configure nginx."
    task :configure do
      puts "-----> Configuring nginx..."
      system %{sudo mkdir -p #{nginx_logs_path}}
    end

    desc "Restart nginx."
    task :restart do
      puts "-----> Restarting nginx..."
      system %{sudo service nginx restart > /dev/null 2>&1}
    end

    namespace :config do
      desc "Update the nginx configuration file."
      task :update => [:move, :link]

      desc "Move the nginx configuration file to the sites-available directory"
      task :move => :initialize do
        puts "-----> Moving nginx.conf to #{nginx_sites_available_path}/#{app}..."
        system %{sudo sh -c "echo '#{parse_template("nginx.conf.erb")}' > #{nginx_sites_available_path}/#{app}"}
      end

      desc "Link to the nginx configuration file."
      task :link => :initialize do
        puts "-----> Creating a symbolic link to #{nginx_sites_available_path}/#{app}..."
        system %{sudo ln -fs #{nginx_sites_available_path}/#{app} #{nginx_sites_enabled_path}/#{app}}
      end

      desc "Print the nginx configuration file to STDOUT."
      task :print => :initialize do
        puts parse_template("nginx.conf.erb")
      end
    end
  end
end
