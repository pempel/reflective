#!/bin/bash

APP_PATH=$1
RUBY_VERSION=$2

function puts()
{
  echo "==> `hostname`: $1..."
}

function install()
{
  which $1 > /dev/null 2>&1
  if [[ $? -ne 0 ]]
  then
    puts "Installing $1"
    sudo apt-get update > /dev/null 2>&1
    sudo apt-get install -y -qq $1 > /dev/null 2>&1
  fi
}

#################################################################################
## Setting up the Europe/Moscow time zone
#################################################################################
cat /etc/timezone | grep 'Europe/Moscow' > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Setting up the Europe/Moscow time zone"
  sudo sh -c "echo 'Europe/Moscow' > /etc/timezone"
  sudo dpkg-reconfigure -f noninteractive tzdata > /dev/null 2>&1
fi

################################################################################
## Installing nginx
################################################################################
which nginx > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Installing nginx"
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install -y -qq nginx libssl-dev apache2-utils > /dev/null 2>&1
  sudo update-rc.d nginx defaults > /dev/null 2>&1
fi

###############################################################################
## Installing git, make, curl, g++, sshpass
###############################################################################
install "git"
install "make"
install "curl"
install "g++"
install "sshpass"

###############################################################################
## Installing rbenv, rbenv-binstubs, ruby-build
###############################################################################
if [[ ! -d "$HOME/.rbenv" ]]
then
  puts "Installing rbenv, rbenv-binstubs, ruby-build"
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
## Installing build-essential libssl-dev, libreadline-dev, apache2-utils, ruby
###############################################################################
cd $HOME
rbenv versions | grep $RUBY_VERSION > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Installing build-essential, libssl-dev, libreadline-dev, apache2-utils, ruby $RUBY_VERSION"
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install -y -qq build-essential libssl-dev libreadline-dev apache2-utils > /dev/null 2>&1
  curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch $RUBY_VERSION > /dev/null 2>&1
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
    puts "Installing bundler"
    gem install bundler > /dev/null 2>&1
  fi
  puts "Installing ruby gems"
  bundle install --path .bundle --binstubs .bundle/bin > /dev/null 2>&1
fi

###############################################################################
## Installing node.js and npm without sudo
###############################################################################
if [[ ! -d "$HOME/opt" ]]
then
  puts "Installing node.js and npm without sudo"
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
## Installing npm packages
###############################################################################
if [[ ! -d "$APP_PATH/node_modules" ]]
then
  cd $APP_PATH
  puts "Installing npm packages"
  npm install > /dev/null 2>&1
fi
