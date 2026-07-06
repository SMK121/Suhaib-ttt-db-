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
