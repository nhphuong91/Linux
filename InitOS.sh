#!/bin/bash

sudo apt-get update
sudo apt-get -y install aptitude
sudo aptitude -y install git htop cmake ibus-unikey python-pip python3-pip

ibus restart
