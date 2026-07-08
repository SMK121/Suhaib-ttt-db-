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

#! /bin/bash

########################################################
# TESTED: 06/07/2026
# TESTED BY: Suhaib
# TESTED ON: AWS
# PURPOSE: Provision MongoDB database server (8.2.5)
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
