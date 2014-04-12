require "mina/git"

require_relative "environment"
require_relative "timezone"
require_relative "puppet"
require_relative "nginx"
require_relative "git"

namespace :application do
  desc "Configures the environment."
  task :configure => :environment do
    invoke "timezone:moscow:set"
    invoke "puppet:install"
    invoke "git:install"
  end

  desc "Sets up the directory structure."
  task :setup => :configure do
    queue %{
      echo "-----> Setting up the #{app} application directory structure" &&
      if [ -d #{deploy_to} ]; then
        echo "----->   Already set up.";
      else
        #{echo_cmd %{sudo mkdir -p "#{deploy_to}/#{releases_path}"}} &&
        #{echo_cmd %{sudo mkdir -p "#{deploy_to}/#{shared_path}"}} &&
        #{echo_cmd %{sudo mkdir -p "#{nginx_log_path}"}} &&
        #{echo_cmd %{sudo mkdir -p "#{nginx_config_path}"}} &&
        #{echo_cmd %{sudo chown -R #{user} "#{deploy_to}"}} &&
        #{echo_cmd %{sudo chown -R "#{nginx_user}" "#{nginx_log_path}"}}
        echo "----->   Succeed."
      fi
    }
  end

  desc "Deploys the current version to the server."
  task :deploy => :setup do
    deploy do
      invoke "git:clone"

      to :launch do
        invoke "puppet:apply"
        invoke "nginx:config:update"
        invoke "nginx:restart"
      end
    end
  end
end
