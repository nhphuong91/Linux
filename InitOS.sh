#!/bin/bash

sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get -y install aptitude
sudo aptitude -y install git htop cmake \
                         exfat-fuse exfat-utils \
                         ibus-bamboo python-pip python3-pip indicator-stickynotes

ibus restart

# install docker
sudo aptitude install apt-transport-https \
                        ca-certificates \
                        curl \
                        gnupg-agent \
                        software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo aptitude install docker-ce docker-ce-cli containerd.io
# run docker as non-root user
sudo usermod -aG docker <your-user>

