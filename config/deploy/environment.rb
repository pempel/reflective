namespace :environment do
  desc "Initialize the base environment."
  task :base do
    set :env,                        ""
    set :app,                        "reflective"
    set :app_path,                   ""
    set :nginx_user,                 "www-data"
    set :nginx_path,                 "/etc/nginx"
    set :nginx_root_path,            ""
    set :nginx_logs_path,            "/var/log/nginx/#{app}"
    set :nginx_sites_available_path, "#{nginx_path}/sites-available"
    set :nginx_sites_enabled_path,   "#{nginx_path}/sites-enabled"
    set :nginx_server_name,          ""
  end

  desc "Initialize the dev environment."
  task :dev => :base do
    set :env,               "dev"
    set :app_path,          "/var/apps/#{app}"
    set :nginx_root_path,   "#{app_path}/public"
    set :nginx_server_name, "#{app}.work"
  end

  desc "Initialize the test environment."
  task :test => :base do
    set :env,               "test"
    set :user,              "vagrant"
    set :domain,            "#{app}-test"
    set :deploy_to,         "/var/apps/#{app}"
    set :repository,        "https://github.com/pempel/reflective.git"
    set :branch,            "development"
    set :app_path,          "#{deploy_to}/#{current_path}"
    set :nginx_root_path,   "#{app_path}/public"
    set :nginx_server_name, "#{app}.test"
  end

  desc "Initialize the live environment."
  task :live => :base do
    set :env,               "live"
    set :deploy_to,         "/var/apps/#{app}"
    set :app_path,          "#{deploy_to}/#{current_path}"
    set :nginx_root_path,   "#{app_path}/public"
    set :nginx_server_name, "pempel.in"
  end
end

desc "Initialize the ENV['env'] environment."
task :environment do
  invoke "environment:#{ENV['env'] || :dev}"
end
