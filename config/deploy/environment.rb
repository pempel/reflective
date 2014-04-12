namespace :environment do
  desc ""
  task :base do
    set :repository,             "https://github.com/pempel/reflective.git"
    set :branch,                 "deployment"
    set :app,                    "reflective"
    set :deploy_to,              "/var/apps/#{app}"
    set :shared_log_path,        "#{deploy_to}/#{shared_path}/log"
    set :shared_config_path,     "#{deploy_to}/#{shared_path}/config"
    set :puppet_manifests_path,  "#{deploy_to}/#{current_path}/config/puppet/manifests"

    set :nginx_user,             "www-data"
    set :nginx_path,             "/etc/nginx"
    set :nginx_log_path,         "#{shared_log_path}/nginx"
    set :nginx_config_path,      "#{shared_config_path}"
    set :nginx_config,           "#{nginx_config_path}/nginx.conf"
    set :nginx_available_config, "#{nginx_path}/sites-available/#{app}.conf"
    set :nginx_enabled_config,   "#{nginx_path}/sites-enabled/#{app}.conf"
    set :nginx_server_name,      ".#{app}.app"
  end

  desc ""
  task :test => :base do
    set :user,            "vagrant"
    set :domain,          "reflective.app"
    set :ssh_config_path, "#{Dir.home}/.vagrant.d/tmp/ssh/config"
    set :ssh_config,      "#{ssh_config_path}/#{domain}"
    set :ssh_options,     "-F #{ssh_config}"

    `mkdir -p #{ssh_config_path} && touch #{ssh_config}`
    `vagrant ssh-config #{domain} > #{ssh_config}`
  end
end

desc ""
task :environment do
  invoke "environment:#{ENV['env'] || :test}"
end
