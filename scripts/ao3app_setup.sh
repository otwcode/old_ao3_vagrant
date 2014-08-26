#!/bin/bash

set -e
echo installing perl
/home/vagrant/bin/reset_perl

echo installing RVM
/home/vagrant/bin/reset_rvm force
PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

mkdir -p /home/vagrant/app/releases
cd /home/vagrant/app/releases
git clone https://github.com/otwcode/otwarchive.git
cd /home/vagrant/app/releases/otwarchive
git checkout master
cd /home/vagrant/app
ln -s  releases/otwarchive current
cd current
bundle install
for i in database.yml  local.yml  redis.yml ;  do
  cp ~/conf/$i ./config
done
export RAILS_ENV=development
bundle exec rake db:drop:all
bundle exec rake db:create:all
zcat  ~/conf/seed.dump.gz  | mysql
bundle exec rake db:migrate
bundle exec rake After
bundle exec rake skins:load_site_skins
bundle exec rake db:test:prepare
for i in Tag  Work Pseud Bookmark
do
  echo "Reindexing $i"
  bundle exec rake environment tire:import CLASS="$i" FORCE=true
done
exit 0
