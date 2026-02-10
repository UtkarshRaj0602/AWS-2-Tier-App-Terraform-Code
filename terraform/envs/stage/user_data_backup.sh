#!/bin/bash
set -e

LOG_FILE="/var/log/hospital_app_setup.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "==================================================================="
echo " Hospital Management App Setup (EC2 User-Data | NodeJS + Express)"
echo "==================================================================="

# ---- VARIABLES ----
PROJECT_DIR="/var/www/html/Hospital-Management-Using-NodeJs-Mysql-Express"
NODE_VERSION="18"
APP_USER="ec2-user"

# ---- SYSTEM UPDATE ----
echo "[1/7] Updating system..."
yum update && yum upgrade -y

# ---- INSTALL BASE PACKAGES ----
echo "[2/7] Installing base packages..."
yum install -y \
  git \
  unzip \
  gzip \
  gcc-c++ \
  make

# ---- INSTALL NODE.JS ----
echo "[3/7] Installing Node.js ${NODE_VERSION}..."
curl -fsSL https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash -
yum install -y nodejs

echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

# ---- INSTALL NODEMON ----
echo "[4/7] Installing nodemon globally..."
npm install -g nodemon

# ---- CREATE PROJECT DIRECTORY ----
echo "[5/7] Preparing project directory..."
mkdir -p /var/www/html
chown -R ${APP_USER}:${APP_USER} /var/www

# ---- CLONE PROJECT (IF NOT EXISTS) ----
echo "[6/7] Cloning project repository..."
if [ ! -d "$PROJECT_DIR" ]; then
  sudo -u ${APP_USER} git clone \
    https://github.com/s-a-zhd/Hospital-Management-Using-NodeJs-Mysql-Express.git \
    "$PROJECT_DIR"
else
  echo "Project already exists, skipping clone."
fi

# ---- INSTALL NPM DEPENDENCIES AS ec2-user ----
echo "[7/7] Installing npm dependencies..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
npm install
EOF

# --- CREATING .env FILE ---
echo "[EXTRA] - Creating .env file"
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
touch .env
EOF

echo "==================================================================="
echo " Setup completed successfully ✅"
echo "==================================================================="

echo "Post-setup checklist:"
echo "1. Update DB config with AWS RDS endpoint"
echo "2. Ensure EC2 SG -> RDS SG allows 3306"
echo "3. Start app with PM2 or nodemon"
