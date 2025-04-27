#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

APP_DIR="/var/www/podcaster"

# Navigate to the application directory where code was deployed
cd $APP_DIR || exit

echo "Starting Node application from $APP_DIR..."

# Write .env file directly with hardcoded values
echo "Writing .env file..."

cat > "$APP_DIR/.env" << EOF
PORT=1000
MONGO_URI=mongodb+srv://ankit123:ankit123@cluster0.3cwlb.mongodb.net/podcaster
JWT_SECRET=ankit09876
EOF

echo ".env file created successfully."

# Install Node.js dependencies
echo "Installing dependencies..."
npm install

# Check if PM2 is installed globally
if ! command -v pm2 &> /dev/null; then
    echo "PM2 not found. Installing PM2 globally..."
    npm install -g pm2
fi

# Check if Node.js is available
if ! command -v node &> /dev/null; then
    echo "Node.js not found. Please ensure Node.js is installed."
    exit 1
fi

# Start the application with PM2
echo "Starting the application with PM2..."
pm2 start server.js --name "podcaster" --env production

# Ensure PM2 restarts on server reboot
pm2 startup | bash || echo "PM2 startup script failed, manual setup may be needed"
pm2 save || echo "PM2 save command failed"

echo "Application started successfully."