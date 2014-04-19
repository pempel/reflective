require_relative "../utils"

namespace :work do
  task :setup do
    set :app,      "reflective"
    set :app_path, "/var/apps/#{app}"

    set :nginx_user,                 "www-data"
    set :nginx_path,                 "/etc/nginx"
    set :nginx_log_path,             "#{app_path}/log"
    set :nginx_root_path,            "#{app_path}/public"
    set :nginx_sites_available_path, "#{nginx_path}/sites-available"
    set :nginx_sites_enabled_path,   "#{nginx_path}/sites-enabled"
    set :nginx_server_name,          ".#{app}.dev"
  end

  task :build do
    `mkdir -p #{app_path}/log`
    `grunt build`
    `grunt watch > /dev/null 2>&1 &`
  end

  task :deploy => ["build", "nginx:config:update", "nginx:restart"]

  namespace :nginx do
    task :restart do
      `echo "-----> Restarting nginx..."`
      `sudo service nginx restart > /dev/null 2>&1`
    end

    namespace :config do
      task :update => [:move, :link]

      task :move => :setup do
        `echo "-----> Moving nginx.conf to #{nginx_sites_available_path}/#{app}..."`
        `echo "#{parse_template("nginx.conf.erb")}" > "#{nginx_sites_available_path}/#{app}"`
      end

      task :link => :setup do
        `echo "-----> Creating symbolic links to #{nginx_sites_available_path}/#{app}..."`
        `sudo ln -fs "#{nginx_sites_available_path}/#{app}" "#{nginx_sites_enabled_path}/#{app}"`
      end

      task :print => :setup do
        puts parse_template("nginx.conf.erb")
      end
    end
  end
end
