require_relative "environment"
require_relative "extra"

namespace :puppet do
  desc "Installs puppet if it is not installed yet."
  task :install => :environment do
    install_package("puppet")
  end

  desc "Applies the site.pp manifest"
  task :apply => :environment do
    manifest = "#{puppet_manifests_path}/site.pp"
    options =  "--modulepath #{puppet_modules_path}"
    queue %{echo "-----> Applying site.pp"}
    queue %{sudo puppet apply #{manifest} #{options} > /dev/null}
    queue %{echo "----->   Succeed."}
  end
end
