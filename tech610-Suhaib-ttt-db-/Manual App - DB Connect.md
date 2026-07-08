# 🔌 Manual App VM → MongoDB Database VM Connection

After configuring MongoDB for remote access, the Tic Tac Toe application VM was manually connected to the MongoDB Database VM.

The application and database are running on separate EC2 instances:

```
App EC2 Instance
(Node.js + PM2)
        |
        |
        | MongoDB connection
        | Port 27017
        |
        |
MongoDB EC2 Instance
(MongoDB Server)
```

---

# 🔐 AWS Security Group Configuration

The MongoDB database instance required an inbound rule to allow connections from the App VM.

MongoDB uses:

```
TCP Port: 27017
```

The MongoDB EC2 security group was configured with:

| Type       | Protocol | Port Range | Source                             |
| ---------- | -------- | ---------- | ---------------------------------- |
| Custom TCP | TCP      | 27017      | App VM private IP / security group |

This allows the application server to communicate with MongoDB while keeping database access restricted.

---

# 🧪 Test MongoDB Network Connection

Before configuring the application, connectivity between the App VM and Database VM was tested.

Run from the App VM:

```bash
nc -zv <DATABASE_PRIVATE_IP> 27017
```

Example:

```bash
nc -zv 172.31.56.200 27017
```

Successful result:

```
Connection to 172.31.56.200 27017 port [tcp/*] succeeded!
```

This confirms:

* MongoDB server is reachable
* Port 27017 is open
* Network communication between EC2 instances works

---

# 🌍 Configure MongoDB Connection String

The Tic Tac Toe application uses an environment variable to store the MongoDB connection string.

From the App VM application directory:

```bash
export MONGODB_URI=mongodb://<DATABASE_PRIVATE_IP>:27017/tictactoe
```

Example:

```bash
export MONGODB_URI=mongodb://172.31.56.200:27017/tictactoe
```

The connection string contains:

| Value         | Purpose                        |
| ------------- | ------------------------------ |
| 172.31.56.200 | MongoDB Database VM private IP |
| 27017         | MongoDB default port           |
| tictactoe     | Application database name      |

Verify the variable:

```bash
echo $MONGODB_URI
```

Expected:

```
mongodb://172.31.56.200:27017/tictactoe
```

---

# 🔄 Restart Application With Updated Environment Variables

The application was already running using PM2.

After adding the MongoDB environment variable, PM2 needed to reload the updated environment.

Restart command:

```bash
pm2 restart all --update-env
```

The `--update-env` flag ensures PM2 loads the new environment variables.

Check application status:

```bash
pm2 list
```

Expected:

```
npm   online
```

---

# 📋 Check Application Logs

PM2 logs were checked to confirm the application restarted successfully.

Command:

```bash
pm2 logs
```

Expected:

```
Server running at http://localhost:3000
```

---

# 🌐 Application Verification

The application was accessed through the App EC2 public IP:

```
http://<APP_PUBLIC_IP>
```

The Tic Tac Toe application loaded successfully.

The browser displayed:

```
Mode: Persistent with Mongo DB
```

This confirms:

* Node.js application is running
* PM2 is managing the process
* MongoDB connection is configured
* Application is using persistent storage

---

# 🛠️ Troubleshooting Commands Used

## Check MongoDB Service

Run on Database VM:

```bash
sudo systemctl status mongod
```

---

## Check MongoDB Listening Port

Run on Database VM:

```bash
sudo ss -tlnp | grep 27017
```

Expected:

```
LISTEN 0 4096 0.0.0.0:27017 users:(("mongod"))
```

---

## Check MongoDB Environment Variable

Run on App VM:

```bash
echo $MONGODB_URI
```

---

## Test Database Connectivity

Run on App VM:

```bash
nc -zv <DATABASE_PRIVATE_IP> 27017
```

Successful output:

```
Connection succeeded
```

---

## Restart Application After Configuration Changes

Run on App VM:

```bash
pm2 restart all --update-env
```

---

# ✅ Final Deployment Result

The Tic Tac Toe application is now running using a two-server AWS architecture.

Completed setup:

✅ Separate App EC2 instance
✅ Separate MongoDB Database EC2 instance
✅ MongoDB configured for remote connections
✅ MongoDB listening on port 27017
✅ App VM connected using `MONGODB_URI`
✅ PM2 managing Node.js application
✅ Persistent game data stored in MongoDB

The application successfully communicates with MongoDB and stores data externally from the application server.


<img width="1678" height="1532" alt="image" src="https://github.com/user-attachments/assets/99413b93-0a4b-4bc1-8e9a-53c75ea6f23f" />


