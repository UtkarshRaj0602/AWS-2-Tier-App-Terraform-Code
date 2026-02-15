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

####################
#######EXTRAS#######
####################

# ---- INSTALL MYSQL CLIENT (AL2023) ----
echo "[EXTRA] Installing MariaDB client..."
dnf install -y mariadb105

# ---- CREATE AND POPULATE .env FILE ----
echo "[EXTRA] Creating and populating .env file..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
cat <<EOT > .env
DB_HOST=REPLACE_WITH_RDS_ENDPOINT
DB_USER=admin
DB_PASSWORD=REPLACE_WITH_PASSWORD
DB_NAME=stage_db
EOT
EOF

# ---- ENSURE DOTENV IS LOADED ----
echo "[EXTRA] Ensuring dotenv is required..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
grep -q "dotenv" app.js || sed -i '1irequire("dotenv").config();' app.js
EOF

# ---- FIX APP BIND ADDRESS ----
echo "[EXTRA] Ensuring app listens on 0.0.0.0..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
sed -i 's/app.listen(/app.listen(process.env.PORT || 3000, "0.0.0.0", /g' app.js || true
EOF

# ---- INSTALL PM2 ----
echo "[EXTRA] Installing PM2..."
npm install -g pm2

# ---- START APP WITH PM2 ----
echo "[EXTRA] Starting app with PM2..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
pm2 start app.js --name hospital-app
pm2 startup systemd -u ${APP_USER} --hp /home/${APP_USER}
pm2 save
EOF

# ---- ADD HEALTH CHECK ENDPOINT ----
echo "[EXTRA] Adding /health endpoint..."
sudo -u ${APP_USER} bash <<EOF
cd $PROJECT_DIR
grep -q "/health" app.js || echo '
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});
' >> app.js
EOF

###########Verification Script##############

echo "=================================================="
echo " Hospital App – EC2 Verification Script"
echo "=================================================="

echo
echo "1️⃣ OS & USER"
echo "--------------------------------------------------"
whoami
cat /etc/os-release | head -n 2

echo
echo "2️⃣ Node & NPM"
echo "--------------------------------------------------"
node -v || echo "❌ Node not installed"
npm -v  || echo "❌ NPM not installed"

echo
echo "3️⃣ PM2 Status"
echo "--------------------------------------------------"
pm2 status || echo "❌ PM2 not running"

echo
echo "4️⃣ Application Process"
echo "--------------------------------------------------"
pm2 list | grep hospital-app || echo "❌ hospital-app not found in PM2"

echo
echo "5️⃣ App Port (3000)"
echo "--------------------------------------------------"
ss -tulpn | grep 3000 || echo "❌ App not listening on port 3000"

echo
echo "6️⃣ Health Endpoint"
echo "--------------------------------------------------"
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:3000/health || echo "❌ Health endpoint not responding"

echo
echo "7️⃣ Environment Variables (.env)"
echo "--------------------------------------------------"
cd /var/www/html/Hospital-Management-Using-NodeJs-Mysql-Express || exit 1
grep DB_HOST .env && grep DB_USER .env && grep DB_NAME .env || echo "❌ .env missing values"

# echo
# echo "8️⃣ Database Connectivity (via App Logs)"
# echo "--------------------------------------------------"
# pm2 logs hospital-app --lines 20 | grep -i "Database" || echo "⚠️ Check DB connection logs manually"

echo
echo "9️⃣ MySQL Client"
echo "--------------------------------------------------"
mysql --version || echo "❌ MySQL/MariaDB client not installed"

echo
echo "=================================================="
echo " ✅ Verification Script Finished"
echo "=================================================="

##################33

echo "==================================================================="
echo " Setup completed successfully ✅"
echo "==================================================================="

echo "Post-setup checklist:"
echo "1. Update DB config with AWS RDS endpoint"
echo "2. Ensure EC2 SG -> RDS SG allows 3306"
echo "3. Start app with PM2 or nodemon"
