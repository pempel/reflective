namespace :grunt do
  desc "Build the current version."
  task :build => :environment do
    commands = [
      %{echo "-----> Building the application"},
      %{cd #{app_path}},
      %{grunt build > /dev/null 2>&1}
    ].each { |c| env.to_sym.equal?(:dev) ? system(c) : queue(c) }
  end
end
