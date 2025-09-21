#!/bin/bash

# React Build and Deploy Script
# Place in /home/webdev/deploy.sh

set -e  # Exit on any error

# Configuration
REPO_DIR="/home/webdev/reddkingllc"
WEB_ROOT="/var/www/reddkingllc"
BUILD_DIR="$REPO_DIR/dist"
LOG_FILE="/home/webdev/deploy.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting deployment..."

# Navigate to repository
cd "$REPO_DIR"

# Pull latest changes
log "Pulling latest changes from GitHub..."
git fetch origin
git reset --hard origin/main  # or origin/master depending on your default branch

# Install/update dependencies
log "Installing dependencies..."
yarn

# Build the React app
log "Building React application..."
yarn run build

# Check if build was successful
if [ ! -d "$BUILD_DIR" ]; then
    log "ERROR: Build directory not found. Build may have failed."
    exit 1
fi

# Deploy new build
log "Deploying new build..."
cp -r "$BUILD_DIR"/* "$WEB_ROOT/reddkingllc/"

log "Deployment completed successfully!"

# Optional: Clean up old node_modules to save space
log "Cleaning up..."
rm -rf "$REPO_DIR/node_modules"

log "Deployment finished."
