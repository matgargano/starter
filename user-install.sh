#!/usr/bin/env bash

LOG_FILE='/home/vagrant/user-install.log'


trap ctrl_c INT
ctrl_c() {
  tput bold >&3; tput setaf 1 >&3; echo -e '\nCancelled by user' >&3; echo -e '\nCancelled by user'; tput sgr0 >&3; if [ -n "$!" ]; then kill $!; fi; exit 1
}

log2file() {
  exec 3>&1 4>&2
  trap 'exec 2>&4 1>&3' 0 1 2 3
  exec 1>$\{LOG_FILE\} 2>&1
}

log2file

echo "---- run user scripts ----" >&3
cd /vagrant
if [ ! -f /vagrant/wp-config.php ]; then

  ssh-keyscan bitbucket.org >> ~/.ssh/known_hosts
  ssh-keyscan github.com >> ~/.ssh/known_hosts
  mv /vagrant/wp/wp-config.php /vagrant/wp-config.php
  cp  /vagrant/wp/index.php /vagrant/index.php
  echo "---- globally install phpunit ----" >&3
  composer global require "phpunit/phpunit=4.2.*"


fi

echo "---- done with vagrant user stuff, logged to $LOG_FILE} ----" >&3
