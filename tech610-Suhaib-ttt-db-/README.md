# MongoDB Database Provisioning Script (AWS EC2 - Ubuntu 24.04)

<!--
This project contains a Bash script used to automatically install and configure MongoDB
on a fresh AWS EC2 Ubuntu 24.04 LTS instance.
-->

---

## 📌 Project Overview

This script provisions and configures a **MongoDB database server (8.2.5)** on AWS EC2.

It is designed for database setup and backend infrastructure preparation for the Tic Tac Toe application.

---

## ⚙️ What the script does

The script automatically:

- Updates system packages
- Upgrades existing packages
- Installs required dependencies (`curl`, `gnupg`)
- Adds MongoDB GPG key for package verification
- Adds MongoDB repository sources
- Installs MongoDB database server
- Configures MongoDB remote access
- Starts MongoDB service
- Enables MongoDB on system boot

---

## 🖥️ Requirements

- AWS EC2 instance (Ubuntu 24.04 LTS)
- Internet access
- sudo privileges

---

## 📁 Files

- `setup.sh` → Main MongoDB database provisioning script

---

# 🌐 MongoDB Network Configuration

By default, MongoDB only accepts connections from the local machine:

```
127.0.0.1
```

To allow the Tic Tac Toe App VM to connect to the separate MongoDB Database VM, MongoDB must accept external connections.

The MongoDB configuration file was edited:

```bash
sudo nano /etc/mongod.conf
```

The following setting was changed:

Before:

```yaml
bindIp: 127.0.0.1
```

After:

```yaml
bindIp: 0.0.0.0
```

This allows MongoDB to accept connections from external machines, such as the App VM.

MongoDB runs on:

```
Port: 27017
```

After updating the configuration, MongoDB was restarted:

```bash
sudo systemctl restart mongod
```

The service status was checked:

```bash
sudo systemctl status mongod
```

The final configuration allows the Tic Tac Toe application running on the App VM to communicate with the MongoDB database server.

---

# 🚀 How to run

Make the script executable:

```bash
chmod +x setup.sh
```

Run the provisioning script:

```bash
./setup.sh
```

---

# 💻 Code Preview (setup.sh)

Below is the full Bash script used to provision MongoDB.

```bash
#!/bin/bash

## TESTED: 06/07/2026
## TESTED BY: Suhaib
## TESTED ON: AWS, Ubuntu 24.04 LTS, t3.micro
## AIM: Work as a script + user data on a fresh Ubuntu 24.04 LTS VM
## Purpose: Provision MongoDB 8.2.5 for TTT app

...
```

---

# ✅ Testing

MongoDB service can be checked using:

```bash
sudo systemctl status mongod
```

MongoDB port can be checked using:

```bash
sudo ss -tulpn | grep 27017
```

Expected result:

- MongoDB service running
- MongoDB listening on port 27017
- App VM able to connect using the database private IP
