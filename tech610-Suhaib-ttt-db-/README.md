# MongoDB Provisioning Script (AWS EC2 - Ubuntu 24.04)

<!--
This project contains a Bash script used to automatically install and configure MongoDB
on a fresh AWS EC2 Ubuntu 24.04 LTS instance for the TTT (Tic Tac Toe) application.
-->

---

## 📌 Project Overview

This script provisions **MongoDB 8.2.5** for the TTT app on AWS EC2.

It automates:
- System updates
- MongoDB repository setup
- MongoDB installation
- Service startup

---

## ⚙️ What the script does

- Updates system packages
- Upgrades system packages
- Installs dependencies (curl, gnupg)
- Adds MongoDB GPG key
- Adds MongoDB repository
- Installs MongoDB
- Starts and enables MongoDB service

---

## 📁 Files

- `setup.sh` → Main MongoDB installation script

---

## 🚀 How to run

```bash
chmod +x setup.sh
./setup.sh


💻 Code Preview (setup.sh)

Below is the full Bash script used for MongoDB provisioning.

#! /bin/bash

########################################################
# TESTED: 06/07/2026
# TESTED BY: Suhaib
# TESTED ON: AWS
# PURPOSE: Provision MongoDB 8.2.5 for TTT app
########################################################

# ----------------------------------------
# STEP 1: Update system packages
# ----------------------------------------
echo "Update the sources list..."
sudo apt update -y
echo "Done!"

# ----------------------------------------
# STEP 2: Upgrade system packages
# ----------------------------------------
echo "Upgrade any packages available..."
sudo apt upgrade -y
echo "Done!"

# ----------------------------------------
# STEP 3: Install dependencies
# ----------------------------------------
echo "Installing dependencies..."
sudo apt-get install -y gnupg curl
echo "Done!"

# ----------------------------------------
# STEP 4: Add MongoDB GPG key
# ----------------------------------------
echo "Install the GPG key..."
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
echo "Done!"

# ----------------------------------------
# STEP 5: Add MongoDB repository
# ----------------------------------------
echo "Create list file..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

echo "MongoDB repository added!"

# ----------------------------------------
# STEP 6: Refresh package list
# ----------------------------------------
echo "Updating package list..."
sudo apt update -y
echo "Done!"

# ----------------------------------------
# STEP 7: Install MongoDB
# ----------------------------------------
echo "Installing MongoDB..."
sudo apt-get install -y \
   mongodb-org=8.2.5 \
   mongodb-org-database=8.2.5 \
   mongodb-org-server=8.2.5 \
   mongodb-mongosh \
   mongodb-org-shell=8.2.5 \
   mongodb-org-mongos=8.2.5 \
   mongodb-org-tools=8.2.5 \
   mongodb-org-database-tools-extra=8.2.5

echo "MongoDB installed!"

# ----------------------------------------
# STEP 8: Start MongoDB service
# ----------------------------------------
sudo systemctl start mongod

# ----------------------------------------
# STEP 9: Enable MongoDB on boot
# ----------------------------------------
sudo systemctl enable mongod

# ----------------------------------------
# STEP 10: Check service status
# ----------------------------------------
sudo systemctl status mongod



