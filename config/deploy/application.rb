require "mina/git"
require_relative "environment"
require_relative "extra"
require_relative "grunt"
require_relative "nginx"
require_relative "ssh"

namespace :app do
  desc "Set up the application directory structure."
  task :setup => :environment do
    unless env.to_sym.equal?(:dev)
      queue %{
        echo "-----> Setting up #{deploy_to}" &&
        if [ -d #{deploy_to} ]; then
          echo "----->   Already set up.";
        else
          #{echo_cmd %{sudo mkdir -p "#{deploy_to}"}} &&
          #{echo_cmd %{sudo chown -R `whoami` "#{deploy_to}"}} &&
          #{echo_cmd %{sudo chmod g+rx,u+rwx "#{deploy_to}"}} &&
          #{echo_cmd %{cd "#{deploy_to}"}} &&
          #{echo_cmd %{sudo mkdir -p "#{releases_path}"}} &&
          #{echo_cmd %{sudo chmod g+rx,u+rwx "#{releases_path}"}} &&
          #{echo_cmd %{sudo mkdir -p "#{shared_path}"}} &&
          #{echo_cmd %{sudo chmod g+rx,u+rwx "#{shared_path}"}} &&
          echo "----->   Succeed."
        fi
      }
    end
  end

  desc "Deploy the current version to the server."
  task :deploy => ["app:setup", "nginx:setup"]  do
    if env.to_sym.equal?(:dev)
      invoke "grunt:build"
      invoke "nginx:config:update"
      invoke "nginx:restart"
    else
      deploy do
        invoke "git:clone"
        to :launch do
          invoke "nginx:config:update"
          invoke "nginx:restart"
        end
      end
    end
  end
end
