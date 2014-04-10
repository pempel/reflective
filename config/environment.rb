namespace :environment do
  desc ""
  task :base do
    set :app,                "reflective"
    set :deploy_to,          "/var/apps/#{app}"
    set :shared_log_path,    "#{deploy_to}/#{shared_path}/log"
    set :shared_config_path, "#{deploy_to}/#{shared_path}/config"

    set :nginx_user,             "www-data"
    set :nginx_path,             "/etc/nginx"
    set :nginx_log_path,         "#{shared_log_path}/nginx"
    set :nginx_config,           "#{shared_config_path}/nginx.conf"
    set :nginx_available_config, "#{nginx_path}/sites-available/#{app}.conf"
    set :nginx_enabled_config,   "#{nginx_path}/sites-enabled/#{app}.conf"
    set :nginx_server_name,      ".#{app}.app"
  end

  desc ""
  task :test => :base do
    set :domain,      "reflective.app"
    set :user,        "vagrant"
    set :ssh_options, "-F #{Dir.pwd}/.ssh-config"
    #set :domain,        `vagrant ssh-config | grep 'HostName '     | awk '{print $2}'`.strip
    #set :user,          `vagrant ssh-config | grep 'User '         | awk '{print $2}'`.strip
    #set :port,          `vagrant ssh-config | grep 'Port '         | awk '{print $2}'`.strip
    #set :identity_file, `vagrant ssh-config | grep 'IdentityFile ' | awk '{print $2}'`.strip
  end
end

desc ""
task :environment do
  invoke "environment:#{ENV['env'] || :test}"
end
