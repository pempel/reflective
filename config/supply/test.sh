#!/bin/bash

function puts()
{
  echo "==> `hostname`: $1..."
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
## Installing git
###############################################################################
which git > /dev/null 2>&1
if [[ $? -ne 0 ]]
then
  puts "Installing git"
  sudo apt-get update > /dev/null 2>&1
  sudo apt-get install -y -qq git > /dev/null 2>&1
fi
