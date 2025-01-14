‏#!/bin/bash

‏echo "Installing Python dependencies..."
‏pip install --upgrade pip
‏pip install -r requirements.txt

‏echo "Starting Backend server..."
‏uvicorn backend:app --host 0.0.0.0 --port 8000 &

‏echo "Installing Node.js dependencies..."
‏cd frontend

‏echo "Starting Frontend server..."
‏npm run dev