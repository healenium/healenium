# Healenium Pro - Installation Guide

## Prerequisites

Before you begin, ensure you have:

- **Docker** (20.10+) and **Docker Compose** (2.0+) installed (for Docker installation)
- **Java 11+** installed (for Shell installation)
- **Python 3.8+** installed (for Shell installation)
- **PostgreSQL 15+** installed (for Shell installation only)
- **GitHub Token** (provided via email after purchase)
- **Docker Hub credentials** (provided via email after purchase)
- Minimum **4GB RAM** and **10GB disk space** available

---

## Step 1: Receive Access Credentials

After purchasing Healenium Pro, you will receive an email from Healenium team containing:

- **GitHub Personal Access Token** (for downloading artifacts)
- **Docker Hub username** (for Docker installation)
- **Docker Hub password** (for Docker installation)
- **License information**

> ⚠️ **Important:** Keep these credentials secure. You'll need them to download Pro components.

---

## Step 2: Download Configuration Files

Clone or download the Healenium Pro configuration:

```bash
git clone https://github.com/healenium/healenium.git
cd healenium/pro
```

---

## Step 3: Configure Credentials

Create and configure the `.env` file with credentials from your email:

```bash
cp .env.example .env
nano .env
```

Add your credentials:

```properties
# GitHub token for downloading Pro artifacts (required for Shell installation)
GITHUB_TOKEN=your_github_token_here

# Docker Hub credentials (required for Docker installation)
DOCKER_USERNAME=your_docker_username
DOCKER_TOKEN=your_docker_password
```

---

## Step 4: Choose Installation Method

You can install Healenium Pro using one of two methods:

- **Option A: Docker Installation** (Recommended) - All services in containers
- **Option B: Shell Installation** - Manual setup with scripts

---

# Option A: Docker Installation (Recommended)

## A1. Login to Docker Registry

Run the login script to authenticate with Docker Hub:

```bash
chmod +x docker_login.sh
./docker_login.sh
```

This script will:
- Read credentials from `.env` file
- Login to Docker Hub

---

## A2. Start Services

### For Selenium:

```bash
docker compose -f docker-compose-pro-selenium.yaml up -d
```

This will start:
- PostgreSQL database
- Healenium Backend
- Healenium Proxy
- Selector Imitator
- AI Service
- UI Dashboard
- Selenium Grid (Hub + Chrome/Firefox/Edge nodes)

### For Playwright:

```bash
docker compose -f docker-compose-pro-playwright.yaml up -d
```

This will start:
- PostgreSQL database
- Healenium Backend
- Healenium Proxy
- Selector Imitator
- AI Service
- UI Dashboard
- Playwright Server
- Playwright Proxy

---

## A3. Verify Installation

Check that all services are running:

```bash
docker compose ps
```

Expected output:

```
NAME                        STATUS
postgres-db                 Up
healenium                   Up
hlm-proxy                   Up
selector-imitator           Up
healenium-ui-dashboard      Up
healenium-ai                Up
selenium-hub                Up (Selenium only)
node-chrome                 Up (Selenium only)
playwright-server           Up (Playwright only)
hlm-playwright-proxy        Up (Playwright only)
```

---

# Option B: Shell Installation

> ⚠️ **Prerequisites for Shell Installation:**
> - PostgreSQL 15+ must be installed and running
> - Java 11+ installed
> - Python 3.8+ installed
> - Selenium Server or Playwright Server running separately

---

## B1. Setup PostgreSQL Database

Create database and user:

```sql
CREATE DATABASE healenium;
CREATE USER healenium_user WITH PASSWORD 'YDk2nmNs4s9aCP6K';
GRANT ALL PRIVILEGES ON DATABASE healenium TO healenium_user;
```

Run initialization script:

```bash
psql -U healenium_user -d healenium -f db/sql/init.sql
```

---

## B2. Download Pro Artifacts

Navigate to shell installation directory:

```bash
cd shell-installation
```

### For Selenium:

```bash
chmod +x selenium_download_pro.sh
./selenium_download_pro.sh
```

This script will:
- Read GitHub token from `../.env` file
- Download latest Pro Selenium artifacts from GitHub
- Save as `{version}-pro-selenium.zip`

### For Playwright:

```bash
chmod +x playwright_download_pro.sh
./playwright_download_pro.sh
```

This script will:
- Read GitHub token from `../.env` file
- Download latest Pro Playwright artifacts from GitHub
- Save as `{version}-pro-playwright.zip`

---

## B3. Start Selenium/Playwright Server

You need to start Selenium or Playwright server separately:

### For Selenium Grid:

```bash
# Download Selenium Server
wget https://github.com/SeleniumHQ/selenium/releases/download/selenium-4.16.0/selenium-server-4.16.0.jar

# Start Selenium Hub
java -jar selenium-server-4.16.0.jar standalone --port 4444
```

Selenium Hub will be available at: `http://localhost:4444`

### For Playwright Server:

```bash
# Install Playwright
npm install -g playwright@1.55.1

# Start Playwright Server
npx playwright run-server --host 0.0.0.0 --port 5000
```

Playwright Server will be available at: `ws://localhost:5000`

---

## B4. Start Healenium Services

### For Selenium:

```bash
chmod +x selenium_start_pro.sh
./selenium_start_pro.sh
```

This script will:
- Unzip downloaded artifacts
- Link JAR files
- Start Healenium Backend (port 7878)
- Start Healenium Proxy (port 8085)
- Install and start Selector Imitator (port 8000)
- Start UI Dashboard (port 5173)
- Start AI Service (port 6565)

### For Playwright:

```bash
chmod +x playwright_start_pro.sh
./playwright_start_pro.sh
```

This script will:
- Unzip downloaded artifacts
- Link JAR files
- Start Healenium Backend (port 7878)
- Start Healenium Proxy (port 8085)
- Install and start Selector Imitator (port 8000)
- Start UI Dashboard (port 5173)
- Start AI Service (port 6565)
- Start Playwright Proxy (port 8095)

---

## B5. Verify Installation

Check that processes are running:

```bash
# Check Java processes
jps -l

# Check Python process
ps aux | grep app.py

# Check process ID files
ls -la pid-*.file
```

---

## Verification (Both Methods)

**Access the UI Dashboard:**

Open your browser and navigate to:

```
http://localhost:5173
```

**Check Backend API:**

```bash
curl http://localhost:7878/healenium/health
```

Expected response:
```json
{"status":"UP"}
```

**Check Proxy:**

```bash
curl http://localhost:8085/health
```

---

## Service Ports

| Service                | Port | Description                        |
|------------------------|------|------------------------------------|
| **Healenium Backend**  | 7878 | Core healing engine API            |
| **Healenium Proxy**    | 8085 | WebDriver proxy with healing       |
| **UI Dashboard**       | 5173 | Web interface for reports          |
| **AI Service**         | 6565 | AI-powered healing service         |
| **PostgreSQL**         | 5432 | Database for healing data          |
| **Selector Imitator**  | 8000 | Selector generation service        |
| **Selenium Hub**       | 4444 | Selenium Grid (Selenium setup)     |
| **Playwright Server**  | 5000 | Playwright remote server (PW only) |
| **Playwright Proxy**   | 8095 | Playwright proxy (PW only)         |

---

## Stopping Services

### Docker Installation:

```bash
# Stop all services
docker compose down

# Stop and remove volumes
docker compose down -v
```

### Shell Installation:

```bash
cd shell-installation

# Kill processes using PID files
for pid_file in pid-*.file; do
  if [ -f "$pid_file" ]; then
    kill $(cat "$pid_file") 2>/dev/null
    rm "$pid_file"
  fi
done
```

---

## Troubleshooting

### Docker Installation Issues:

**Issue: Cannot pull images**

```bash
# Verify credentials in .env file
cat .env | grep DOCKER

# Re-run login script
./docker_login.sh
```

**Issue: Port already in use**

```bash
# Find process using port
lsof -i :8085

# Kill the process
kill -9 <PID>
```

**Issue: Services not starting**

```bash
# Check logs
docker compose logs -f healenium

# Restart specific service
docker compose restart healenium
```

### Shell Installation Issues:

**Issue: Cannot download artifacts**

```bash
# Verify GitHub token in .env
cat ../.env | grep GITHUB_TOKEN

# Test token manually
curl -H "Authorization: token YOUR_TOKEN" \
  https://api.github.com/repos/healenium/aws-healenium-pro/releases/latest
```

**Issue: Database connection failed**

```bash
# Verify PostgreSQL is running
ps aux | grep postgres

# Test connection
psql -U healenium_user -d healenium -c "SELECT 1;"

# Check credentials in start script
grep POSTGRES selenium_start_pro.sh
```

**Issue: Port already in use**

```bash
# Find process using port
lsof -i :7878

# Kill the process
kill -9 <PID>
```

**Issue: Java process not starting**

```bash
# Check Java version
java -version

# Check JAR files exist
ls -la *.jar

# Check logs
tail -f logs/*.log
```

---

## Next Steps

- 📖 [Integration Guide](https://healenium.io/docs/integration) - Connect with your tests
- 🔧 [Configuration Reference](https://healenium.io/docs/configuration) - Advanced settings
- 📊 [Using the Dashboard](https://healenium.io/docs/dashboard) - Monitor healing activity

---

## Support

**Pro Users:**
- 📧 Email: support@healenium.io
- 💬 Priority Slack channel (link in your welcome email)

**Community:**
- 💬 Telegram: [@healenium](https://t.me/healenium)
- 🐛 GitHub Issues: [healenium/healenium](https://github.com/healenium/healenium/issues)

---

*Credentials: Provided via email after purchase*
