#! /bin/bash

## TESTED: 06/07/2026
## TESTED BY: Suhaib
## TESTED ON: AWS
## AIM: Work as a script + user data on a fresh Ubuntu 24.04 LTS VM
## Purpose: Provision the MongoDB 8.2.5 for TTT app

# --------------------------------------------
# STEP 1: Update system package list
# --------------------------------------------
echo Update the sources list...
sudo apt update -y
echo Done!
 
# --------------------------------------------
# STEP 2: Upgrade existing packages
# --------------------------------------------
echo Upgrade any packages available...
sudo apt upgrade -y
echo Done!

# --------------------------------------------
# STEP 3: Add MongoDB GPG key (authentication)
# --------------------------------------------
echo Install the GPG key...
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
echo Done!

# --------------------------------------------
# STEP 4: Add MongoDB repositories
# (8.0 and 8.2 sources added for version access)
# --------------------------------------------
echo Create list file...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
echo Done!

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list

# --------------------------------------------
# STEP 5: Refresh package index after repo changes
# --------------------------------------------
echo Updating new package...
sudo apt update
echo Done!

# --------------------------------------------
# STEP 6: Install MongoDB packages (version pinned)
# --------------------------------------------
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

# --------------------------------------------
# STEP 7: Start and enable MongoDB service
# --------------------------------------------
sudo systemctl start mongod
sudo systemctl enable mongod

# --------------------------------------------
# STEP 8: Check MongoDB service status
# --------------------------------------------
sudo systemctl status mongod