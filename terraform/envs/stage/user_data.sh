#!/bin/bash
set -e

LOG_FILE="/var/log/hospital_app_setup.log"
exec > >(tee -a $LOG_FILE) 2>&1

echo "==================================================================="
echo " Hospital Management App Setup (EC2 User-Data | NodeJS + Express)"
echo "==================================================================="

PROJECT_DIR="/var/www/html/Hospital-Management-Using-NodeJs-Mysql-Express"
NODE_VERSION="18"
APP_USER="root"

############################
# SYSTEM LEVEL (ROOT ONLY)
############################

echo "[1] Updating system..."
dnf update -y

echo "[2] Installing base packages..."
dnf install -y git unzip gzip gcc-c++ make mariadb105

echo "[3] Installing Node.js..."
curl -fsSL https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash -
dnf install -y nodejs

echo "Node version: $(node -v)"
echo "NPM version: $(npm -v)"

############################
# APPLICATION LEVEL (root)
############################

mkdir -p /var/www/html
chown -R ${APP_USER}:${APP_USER} /var/www

sudo -u ${APP_USER} bash <<EOF

cd /var/www/html

echo "[4] Cloning repository..."
if [ ! -d "$PROJECT_DIR" ]; then
  git clone https://github.com/s-a-zhd/Hospital-Management-Using-NodeJs-Mysql-Express.git
fi

cd $PROJECT_DIR

echo "[5] Installing npm dependencies..."
npm install
npm install dotenv

echo "[6] Installing PM2 locally for ec2-user..."
npm install -g pm2

echo "[7] Creating .env file..."
cat <<EOT > .env
DB_HOST=REPLACE_WITH_RDS_ENDPOINT
DB_USER=admin
DB_PASSWORD=REPLACE_WITH_PASSWORD
DB_NAME=stage_db
PORT=3306
EOT

echo "[8] Ensuring dotenv is loaded..."
grep -q "dotenv" app.js || sed -i '1irequire("dotenv").config();' app.js

echo "[9] Ensuring app binds to 0.0.0.0..."
sed -i 's/app.listen(/app.listen(process.env.PORT || 3000, "0.0.0.0", /g' app.js || true

echo "[10] Adding health endpoint..."
grep -q "/health" app.js || echo '
app.get("/health", (req, res) => {
  res.status(200).send("OK");
});
' >> app.js

EOF

### Add these below commented ones before EOF in the above

# echo "[11] Starting app with PM2..."
# pm2 start app.js --name hospital-app
# pm2 save

# echo "[12] Configuring PM2 startup..."
# pm2 startup systemd -u root --hp /

echo "==================================================================="
echo " Setup Completed Successfully (ec2-user controlled) ✅"
echo "==================================================================="

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
