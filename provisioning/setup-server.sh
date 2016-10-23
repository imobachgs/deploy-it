#!/usr/bin/env bash

set -x

sudo apt-get update

# Do not install ChefDK (let's 'Deploy It!' to do for us).
# Just uncomment the following lines if you want it.
# sudo apt-get -y install curl
# curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.19.6
