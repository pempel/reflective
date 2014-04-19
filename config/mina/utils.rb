def parse_template(name)
  erb("#{File.dirname(__FILE__)}/templates/#{name}")
end

def install_package(name)
  queue %{
    echo "-----> Installing #{name}";
    command -v "#{name}" > /dev/null 2>&1;
    if [ $? -eq 0 ]; then
      echo "----->   Already installed.";
    else
      sudo apt-get update > /dev/null 2>&1;
      sudo apt-get install -qq -y #{name} > /dev/null 2>&1;
      if [ $? -eq 0 ]; then
        echo "----->   Succeed.";
      else
        echo "----->   Failed.";
      fi
    fi
  }
end
