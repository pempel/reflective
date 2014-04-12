require_relative "environment"
require_relative "extra"

namespace :nginx do
  %w(stop start restart reload status).each do |action|
    desc "#{action.capitalize} nginx."
    task action.to_sym do
      queue %{echo "-----> #{action.capitalize} nginx"}
      queue echo_cmd %{sudo service nginx "#{action}"}
    end
  end

  namespace :config do
    desc ""
    task :update => [:upload, :link]

    desc ""
    task :upload => :environment do
      queue %{echo "-----> Put nginx.conf to #{nginx_config}"}
      queue %{echo "#{parse_template("nginx.conf.erb")}" > "#{nginx_config}"}
    end

    desc ""
    task :link => :environment do
      queue %{echo "-----> Create symbolic links to nginx.conf"}
      queue echo_cmd %{sudo ln -fs "#{nginx_config}" "#{nginx_available_config}"}
      queue echo_cmd %{sudo ln -fs "#{nginx_config}" "#{nginx_enabled_config}"}
    end

    desc ""
    task :print => :environment do
      puts parse_template("nginx.conf.erb")
    end
  end
end
