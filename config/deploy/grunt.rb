namespace :grunt do
  desc "Build the current version."
  task :build => :environment do
    if env.to_sym.equal?(:dev)
      system %{echo "-----> Building the application"}
      system %{cd #{deploy_to}}
      system %{grunt build > /dev/null 2>&1}
    end
  end
end
