#!/bin/bash
echo "Running app_start.sh"
cd /var/www/podcaster || exit
npm install
npm run start &
