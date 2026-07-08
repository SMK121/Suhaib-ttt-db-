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

The provisioning script automatically:

- Updates system packages
- Upgrades existing packages
- Installs required dependencies (`curl`, `gnupg`)
- Adds MongoDB GPG key for package verification
- Adds MongoDB repository sources
- Installs MongoDB database server
- Configures MongoDB remote access using `bindIp`
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

```text
127.0.0.1
```

To allow the Tic Tac Toe App VM to connect to the separate MongoDB Database VM, MongoDB remote access was configured.

The MongoDB configuration was updated automatically by the provisioning script using:

```bash
sudo sed -i 's/bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf
```

The configuration change:

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

```text
Port: 27017
```

After updating the configuration, MongoDB is started and enabled:

```bash
sudo systemctl start mongod
sudo systemctl enable mongod
```

The service status can be checked using:

```bash
sudo systemctl status mongod
```

---

# 🔗 Application Database Connection

The Tic Tac Toe application connects to the MongoDB Database VM using the `MONGODB_URI` environment variable.

The connection was configured on the App VM:

```bash
export MONGODB_URI=mongodb://<DATABASE_PRIVATE_IP>:27017/tictactoe
```

Connection breakdown:

- `<DATABASE_PRIVATE_IP>` → Private IP address of the MongoDB Database VM
- `27017` → MongoDB default port
- `tictactoe` → Application database name

After setting the environment variable, PM2 was restarted so the application could reload the database connection:

```bash
pm2 restart all
```

This allows the Tic Tac Toe application running on the App VM to communicate with the MongoDB database server.

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

[Full script here]
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
- MongoDB accepts connections from the App VM
- Tic Tac Toe application connects using `MONGODB_URI`



---

# 🖥️ Manual Application to Database Connection Setup

After provisioning the MongoDB Database VM, the Tic Tac Toe application was manually configured on the separate App VM to connect to the database.

The App VM and MongoDB VM communicate using the AWS private network.

---

## 1. Connect to the App VM

SSH into the application EC2 instance:

```bash
ssh -i <key.pem> ubuntu@<APP_PUBLIC_IP>
