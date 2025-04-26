#!/bin/bash
echo "Running app_stop.sh"
echo "Stopping existing Node.js app"
pkill node || echo "No node process running"
