require "mina/git"

require_relative "environment"
require_relative "nginx"

set :repository, "https://github.com/pempel/reflective.git"
set :branch,     "deployment"

namespace :deploy do
  desc ""
  task :setup => :environment do
    queue! %{sudo mkdir -p "#{deploy_to}"}
    queue! %{sudo mkdir -p "#{shared_log_path}"}
    queue! %{sudo mkdir -p "#{shared_config_path}"}
    queue! %{sudo chown -R "#{user}" "#{deploy_to}"}
    invoke "setup"
    invoke "nginx:setup"
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke "git:clone"
    invoke "nginx:config:update"

    to :launch do
      invoke "nginx:restart"
    end
  end
end
