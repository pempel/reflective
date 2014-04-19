#!/bin/bash

APP_PATH=$1
TIME_ZONE=$2
RUBY_VERSION=`cat $APP_PATH/.ruby-version`

function puts()
{
  echo "==> `hostname`: $1"
}

#################################################################################
## Setting up the specified time zone
#################################################################################
cat /etc/timezone | grep $TIME_ZONE > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Setting up the $TIME_ZONE time zone..."
  sudo sh -c "echo '$TIME_ZONE' > /etc/timezone"
  sudo dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1
fi

################################################################################
## Installing nginx
################################################################################
which nginx > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Installing nginx..."
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install -y -qq nginx > /dev/null 2>&1
  update-rc.d nginx defaults > /dev/null 2>&1
fi

###############################################################################
## Installing git, make, g++, curl, libssl-dev, apache2-utils
###############################################################################
which git > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Installing git, make, g++, curl, libssl-dev, apache2-utils..."
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install -y -qq git make g++ curl > /dev/null 2>&1
  sudo apt-get install -y -qq libssl-dev apache2-utils > /dev/null 2>&1
fi


###############################################################################
## Installing node.js and npm without sudo
###############################################################################
if [[ ! -d "$HOME/opt" ]]
then
  puts "Installing node.js and npm without sudo..."
  git clone https://github.com/joyent/node.git ~/.node > /dev/null 2>&1
  cd ~/.node
  mkdir ~/opt
  export PREFIX=~/opt; ./configure > /dev/null 2>&1
  make > /dev/null 2>&1
  make install > /dev/null 2>&1
  echo 'export PATH="$HOME/opt/bin:$PATH"' >> ~/.bashrc
fi
export PATH="$HOME/opt/bin:$PATH"

###############################################################################
## Installing rbenv, rbenv-binstubs, ruby-build
###############################################################################
if [[ ! -d "$HOME/.rbenv" ]]
then
  puts "Installing rbenv, rbenv-binstubs, ruby-build..."
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv > /dev/null 2>&1
  mkdir -p ~/.rbenv/plugins
  cd ~/.rbenv/plugins
  git clone https://github.com/ianheggie/rbenv-binstubs.git > /dev/null 2>&1
  git clone https://github.com/sstephenson/ruby-build.git > /dev/null 2>&1
  git clone https://github.com/sstephenson/rbenv-gem-rehash.git > /dev/null 2>&1
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

###############################################################################
## Installing ruby
###############################################################################
cd $HOME
rbenv versions | grep $RUBY_VERSION > /dev/null
if [[ $? -ne 0 ]]
then
  puts "Installing ruby $RUBY_VERSION..."
  rbenv install $RUBY_VERSION > /dev/null 2>&1
fi

###############################################################################
## Installing bundler and ruby gems
###############################################################################
if [[ ! -d "$APP_PATH/.bundle" ]]
then
  cd $APP_PATH
  gem list | grep bundler > /dev/null 2>&1
  if [[ $? -ne 0 ]]
  then
    puts "Installing bundler..."
    gem install bundler > /dev/null 2>&1
  fi
  puts "Installing ruby gems..."
  bundle install --path .bundle --binstubs .bundle/bin > /dev/null 2>&1
fi

###############################################################################
## Installing npm packages
###############################################################################
if [[ ! -d "$APP_PATH/node_modules" ]]
then
  cd $APP_PATH
  puts "Installing npm packages..."
  npm install > /dev/null 2>&1
fi

###############################################################################
## Deploying the applicaiton
###############################################################################
if [[ ! -d "$APP_PATH/public" ]]
then
  cd $APP_PATH
  puts "Deploying the application..."
  mina work:deploy > /dev/null 2>&1
fi
