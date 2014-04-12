require_relative "environment"
require_relative "extra"

namespace :puppet do
  desc "Install puppet if it is not installed yet."
  task :install => :environment do
    install_package("puppet")
  end

  desc "Apply the site.pp puppet manifest"
  task :apply => :environment do
    queue %{puppet apply "#{puppet_manifests_path}/site.pp"}
  end
end
