require_relative "extra"

namespace :git do
  desc "Installs git if it is not installed yet."
  task :install => :environment do
    install_package("git")
  end
end
