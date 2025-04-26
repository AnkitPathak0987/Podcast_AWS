#!/bin/bash
set -e

echo "Installing Node.js and preparing environment..."

# Update package lists
yum update -y

# Install the Node.js 16.x repository
curl -sL https://rpm.nodesource.com/setup_16.x | bash -

# Install Node.js and npm
yum install -y nodejs

# Install PM2 globally
npm install -g pm2

# Create application directory if it doesn't exist
mkdir -p /var/www/podcaster

# Navigate to app directory and clean old dependencies if any
cd /var/www/podcaster || exit
rm -rf node_modules

# Check versions
echo "Node.js version:"
node -v
echo "npm version:"
npm -v
echo "PM2 version:"
pm2 -v

echo "Environment setup completed successfully."
