require_relative "deploy/application"

desc "Deploys the current version to the server (shortcut for application:deploy)."
task :deploy do
  invoke "application:deploy"
end
