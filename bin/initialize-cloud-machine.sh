#!/bin/bash
apt update
apt upgrade -y

apt install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg2 \
  software-properties-common

curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y \
  docker-ce \
  docker-compose \
  git

docker info
docker-compose version
git --version

