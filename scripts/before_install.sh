#!/bin/bash
echo "Running before_install.sh"
cd /var/www/podcaster || exit
rm -rf node_modules
