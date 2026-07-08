#!/bin/bash

## TESTED: 08/07/2026
## TESTED BY: Suhaib
## TESTED ON: AWS Ubuntu 24.04 LTS
## AIM: Provision Tic Tac Toe App VM and connect to MongoDB VM

echo Updating packages...
sudo apt update -y
sudo apt upgrade -y
echo Done!


echo Installing required packages...
sudo apt install -y git nginx curl
echo Done!


echo Installing Node.js...
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs
echo Done!


echo Installing PM2...
sudo npm install pm2 -g
echo Done!


echo Cloning application...

cd /home/ubuntu

git clone <YOUR-GITHUB-REPO-URL>

cd <YOUR-APP-FOLDER>

echo Installing dependencies...
npm install
echo Done!


echo Configuring MongoDB connection...

echo 'export MONGODB_URI=mongodb://172.31.56.200:27017/tictactoe' >> ~/.bashrc

source ~/.bashrc

echo MongoDB connection configured!


echo Starting application with PM2...

pm2 start npm --name tictactoe -- start

pm2 save

echo Application started!


echo Installing Nginx reverse proxy...

sudo systemctl enable nginx
sudo systemctl start nginx

echo Setup complete!