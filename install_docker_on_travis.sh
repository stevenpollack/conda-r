#!/bin/bash

apt-get update
apt-get install -y \
  apt-transport-https ca-certificates \
  linux-image-extra-$(uname -r)

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

cat > /etc/apt/sources.list.d/docker.list <<APPEND
deb https://apt.dockerproject.org/repo ubuntu-trusty main
APPEND
 
apt-get update
apt-get purge lxc-docker
apt-get install -y docker-engine
