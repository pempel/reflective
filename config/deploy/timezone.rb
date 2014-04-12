namespace :timezone do
  namespace :moscow do
    desc "Sets the moscow time zone"
    task :set => :environment do
      queue %{echo "-----> Setting up the moscow time zone"}
      queue %{sudo sh -c "echo 'Europe/Moscow' > /etc/timezone"}
      queue %{sudo dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1}
      queue %{echo "----->   Succeed."}
    end
  end
end
