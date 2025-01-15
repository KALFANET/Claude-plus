#!/bin/bash

# Install PM2 globally if not installed
if ! command -v pm2 &> /dev/null; then
    echo "PM2 is not installed. Installing PM2..."
    npm install -g pm2
fi

# Navigate to the workspace directory
echo "Navigating to project directory..."
cd /workspace/claude-plus || { echo "Directory not found!"; exit 1; }

# Start Backend with PM2
echo "Starting Backend server with PM2..."
pm2 start uvicorn --name "Backend" -- backend:app --host 0.0.0.0 --port 8000

# Start Frontend with PM2
echo "Starting Frontend server with PM2..."
cd frontend || { echo "Frontend directory not found!"; exit 1; }
pm2 start npm --name "Frontend" -- run dev

# Save PM2 process list for auto-restart
echo "Saving PM2 process list..."
pm2 save

# Set up PM2 startup script (specific to Gitpod)
echo "Setting up PM2 startup..."
pm2 startup

# Configure SSH keep-alive for Gitpod environment
echo "Configuring SSH keep-alive..."
if ! grep -q "ServerAliveInterval" ~/.ssh/config 2>/dev/null; then
    echo -e "\nHost *\n    ServerAliveInterval 60\n    ServerAliveCountMax 5" >> ~/.ssh/config
    echo "SSH keep-alive configured."
else
    echo "SSH keep-alive already configured."
fi

# Confirm services are running
echo "Confirming services are running..."
pm2 list

echo "All services are running and managed by PM2. You can safely disconnect from Gitpod."