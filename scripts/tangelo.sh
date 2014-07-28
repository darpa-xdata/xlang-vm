#!/usr/bin/env bash

# create tangelo user
sudo apt-get -y install makepasswd
PASSWORD=`cat /dev/urandom | head -n 1 | base64 | fold -w 10 | head -n 1`
echo $PASSWORD | sudo tee /root/tangelo_password.txt
passhash=$(sudo makepasswd --clearfrom=/root/tangelo_password.txt --crypt-md5 |awk '{print $2}')
sudo useradd tangelo -m -p $passhash
sudo usermod -s /bin/bash tangelo
# end create user

sudo apt-get install -y python-pip python-dev
sudo apt-get install -y git
sudo pip install tangelo
sudo rm -rf /home/tangelo/tangelo-webroot
sudo -u tangelo mkdir -p /home/tangelo/tangelo-webroot
sudo -u tangelo -H git clone https://github.com/XDATA-Year-2/internet-graph /home/tangelo/tangelo-webroot/internet-graph
sudo -u tangelo -H tangelo restart --logdir /home/tangelo --root /home/tangelo/tangelo-webroot
