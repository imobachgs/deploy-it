#!/usr/bin/env bash

set -x

sudo apt-get update
sudo apt-get -y install curl
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.19.6
