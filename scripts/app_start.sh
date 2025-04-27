#!/bin/bash
set -e

APP_DIR="/var/www/podcaster/backend"

# Navigate to the backend directory
cd "$APP_DIR" || exit

echo "Starting Node application from $APP_DIR..."

# Write .env file in the backend folder
cat > ".env" << EOF
PORT=1000
MONGO_URI=mongodb+srv://ankit123:ankit123@cluster0.3cwlb.mongodb.net/podcaster
JWT_SECRET=ankit09876
EOF

echo ".env file created successfully."

# (Re)install Node.js dependencies, if needed
echo "Installing dependencies..."
npm install

# Ensure PM2 is installed
if ! command -v pm2 &> /dev/null; then
    echo "Installing PM2 globally..."
    npm install -g pm2
fi

# Stop any existing instance
echo "Stopping existing PM2 process (if any)..."
pm2 stop podcaster || true
pm2 delete podcaster || true

# Start the application via PM2
echo "Launching app.js with PM2..."
pm2 start app.js --name "podcaster" --env production

# Enable PM2 to restart on reboot
pm2 startup | bash || echo "PM2 startup script failed"
pm2 save || echo "PM2 save command failed"

echo "Application started successfully."