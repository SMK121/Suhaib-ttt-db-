# MongoDB Database Provisioning Script (AWS EC2 - Ubuntu 24.04)

<!--
This project contains a Bash script used to automatically install and configure MongoDB
on a fresh AWS EC2 Ubuntu 24.04 LTS instance.
-->

---

## 📌 Project Overview

This script provisions and configures a **MongoDB database server (8.2.5)** on AWS EC2.

It is designed for database setup and backend infrastructure preparation.

---

## ⚙️ What the script does

- Updates system packages
- Upgrades existing packages
- Installs required dependencies (curl, gnupg)
- Adds MongoDB GPG key for package verification
- Adds MongoDB repository sources
- Installs MongoDB database server
- Starts MongoDB service
- Enables MongoDB on system boot

---

## 🖥️ Requirements

- AWS EC2 instance (Ubuntu 24.04 LTS)
- Internet access
- sudo privileges

---

## 📁 Files

- `setup.sh` → Main MongoDB database installation script

---

## 🚀 How to run

```bash
chmod +x setup.sh
./setup.sh




#💻 Code Preview (setup.sh)

Below is the full Bash script used to provision MongoDB.

#!/bin/bash

## TESTED: 06/07/2026
## TESTED BY: Suhaib
## TESTED ON: AWS, Ubuntu 24.04 LTS, t3.micro
## AIM: Work as a script + user data on a fresh Ubuntu 24.04 LTS VM
## Purpose: Provision the MongoDB 8.2.5 for TTT app

# --------------------------------------------
# STEP 1: Update system package list
# --------------------------------------------
echo Update the sources list...
sudo apt-get update -y
echo Done!


# --------------------------------------------
# STEP 2: Upgrade existing packages
# --------------------------------------------
echo Upgrade any packages available...
sudo apt-get upgrade -y
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
# STEP 4: Add MongoDB 8.2 repository
# --------------------------------------------
echo Create list file...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list
echo Done!


# --------------------------------------------
# STEP 5: Refresh package index after repository change
# --------------------------------------------
echo Update the sources list...
sudo apt-get update
echo Done!


# --------------------------------------------
# STEP 6: Install MongoDB 8.2.5 packages
# --------------------------------------------
echo Install MongoDB...
sudo apt-get install -y \
   mongodb-org=8.2.5 \
   mongodb-org-database=8.2.5 \
   mongodb-org-server=8.2.5 \
   mongodb-mongosh \
   mongodb-org-shell=8.2.5 \
   mongodb-org-mongos=8.2.5 \
   mongodb-org-tools=8.2.5 \
   mongodb-org-database-tools-extra=8.2.5
echo Done!


# --------------------------------------------
# STEP 7: Start and enable MongoDB service
# --------------------------------------------
sudo systemctl start mongod
sudo systemctl enable mongod


# --------------------------------------------
# STEP 8: Check MongoDB service status
# --------------------------------------------
sudo systemctl status mongod
