#! /bin/bash

## TESTED: 06/07/2026
## TESTED BY: Suhaib
## TESTED ON: AWS
## AIM: Work as a script + user data on a fresh Ubuntu 24.04 LTS VM
## Purpose: Provision the MongoDB 8.2.5 for TTT app

echo Update the sources list...
sudo apt update -y
echo Done!

echo Upgrade any packages available...
sudo apt upgrade -y
echo Done!

echo Install the GPG key...
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
echo Done!

echo Create list file...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list
echo Done!

echo Updating new package...
sudo apt update -y
echo Done!

echo Installing MongoDB...
sudo apt-get install -y \
   mongodb-org=8.2.5 \
   mongodb-org-database=8.2.5 \
   mongodb-org-server=8.2.5 \
   mongodb-mongosh \
   mongodb-org-shell=8.2.5 \
   mongodb-org-mongos=8.2.5 \
   mongodb-org-tools=8.2.5 \
   mongodb-org-database-tools-extra=8.2.5
echo Installed MongoDB!

echo Enabling MongoDB to run on boot...
sudo systemctl enable mongod
echo Enabled MongoDB

echo Configuring MongoDB...
sudo cp /etc/mongod.conf /etc/mongod.conf.bak
sudo sed -i 's|bindIp: 127.0.0.1|bindIp: 0.0.0.0|' /etc/mongod.conf
echo Configured MongoDB

echo Starting MongoDB...
sudo systemctl start mongod
echo Started MongoDB
