#!/usr/bin/env bash

set -x

RUBY_VERSION="2.3.1"

# packages
if [ "$VAGRANT_DISTRO" == "opensuse" ]; then
  sudo zypper -n in -t pattern devel_basis
  sudo zypper -n in libopenssl-devel readline-devel \
       postgresql94-server postgresql94-devel libxml2-devel libxslt-devel
else
  sudo apt-get update
  sudo apt-get -y install libxslt1-dev libxml2-dev postgresql libpq-dev
fi

#
# chruby and ruby-install
#
wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
tar -xzvf chruby-0.3.9.tar.gz
cd chruby-0.3.9/
sudo make install
cd ..
rm chruby-0.3.9* -r

wget -O ruby-install-0.6.0.tar.gz https://github.com/postmodern/ruby-install/archive/v0.6.0.tar.gz
tar -xzvf ruby-install-0.6.0.tar.gz
cd ruby-install-0.6.0/
sudo make install
cd ..
rm ruby-install-0.6.0* -r

cat >>~/.zshrc <<EOF
source /usr/local/share/chruby/chruby.sh
EOF

cat >>~/.bash_profile <<EOF
source /usr/local/share/chruby/chruby.sh
EOF

#
# Rubygems
#
cat >$HOME/.gemrc <<EOF
---
install: --no-rdoc --no-ri
update: --no-rdoc --no-ri
EOF

#
# Ruby
#
RUBY_INSTALL_OPTS=""
if [ "$VAGRANT_DISTRO" == "opensuse" ]; then
    RUBY_INSTALL_OPTS="--no-install-deps"
fi
ruby-install $RUBY_INSTALL_OPTS ruby $RUBY_VERSION

source /usr/local/share/chruby/chruby.sh
chruby $RUBY_VERSION
gem install nokogiri -- --use-system-libraries
gem install rails
