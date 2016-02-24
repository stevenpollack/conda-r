#!/bin/bash

#sudo apt-get update
sudo apt-get install -y \
  apt-transport-https ca-certificates \
  linux-image-extra-$(uname -r)

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

DOCKER_LIST=/etc/apt/sources.list.d/docker.list
if [ ! -f $DOCKER_LIST ]; then
  sudo touch $DOCKER_LIST
fi

sudo cat > $DOCKER_LIST << APPEND
deb https://apt.dockerproject.org/repo ubuntu-trusty main
APPEND
 
sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-get install -y docker-engine
