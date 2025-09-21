#!/bin/bash

# Subway Deploy Script
# Place in /home/webdev/deploy_subway.sh

set -e  # Exit on any error

# Configuration
REPO_DIR="/home/webdev/subway"
LOG_FILE="/home/webdev/deploy_subway.log"

# Logging function
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Starting subway deployment..."

# Navigate to repository
cd "$REPO_DIR"

nvm use 24

# Pull latest changes
log "Pulling latest changes from GitHub..."
git fetch origin
git reset --hard origin/main  # or origin/master depending on your default branch

# Install/update dependencies
log "Installing dependencies..."
yarn

# Build the application
log "Building application..."
yarn run build

# Restart PM2 process
log "Restarting PM2 process..."
pm2 restart subway

log "Subway deployment completed successfully!"

log "Deployment finished."