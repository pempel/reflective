namespace :environment do
  desc "Initialize the base environment."
  task :base do
    # You have to set the following variables for each environment:
    # env, nginx_root_path, nginx_server_name.
    set :app,                        "reflective"
    set :deploy_path,                "/var/apps"
    set :deploy_to,                  "#{deploy_path}/#{app}"
    set :repository,                 "https://github.com/pempel/reflective.git"
    set :nginx_user,                 "www-data"
    set :nginx_path,                 "/etc/nginx"
    set :nginx_logs_path,            "/var/log/nginx/#{app}"
    set :nginx_sites_available_path, "#{nginx_path}/sites-available"
    set :nginx_sites_enabled_path,   "#{nginx_path}/sites-enabled"
  end

  desc "Initialize the dev environment."
  task :dev => :base do
    set :env,               "dev"
    set :nginx_root_path,   "#{deploy_to}/public"
    set :nginx_server_name, "#{app}.dev"
  end

  desc "Initialize the test environment."
  task :test => :base do
    set :env,               "test"
    set :nginx_root_path,   "#{deploy_to}/#{current_path}/public"
    set :nginx_server_name, "#{app}.test"
    set :user,              "vagrant"
    set :domain,            "#{app}-test"
    set :address,           "192.168.56.102"
    set :branch,            "development"
  end

  desc "Initialize the live environment."
  task :live => :base do
    set :env,               "live"
    set :nginx_root_path,   "#{deploy_to}/#{current_path}/public"
    set :nginx_server_name, "pempel.in"
    set :user,              "depp"
    set :domain,            "#{app}-live"
    set :address,           "95.85.41.230"
    set :branch,            "development"
  end
end

desc "Initialize the ENV['env'] environment."
task :environment do
  invoke "environment:#{ENV['env'] || :dev}"
end
