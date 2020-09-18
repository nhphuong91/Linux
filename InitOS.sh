#!/bin/bash

sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo add-apt-repository ppa:umang/indicator-stickynotes
sudo apt-get update
sudo apt-get -y install aptitude
sudo aptitude -y install git htop cmake ibus-bamboo python-pip python3-pip indicator-stickynotes

ibus restart
