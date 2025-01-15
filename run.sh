#!/bin/bash

# פונקציה להפעלת Backend עם PM2
start_backend() {
    echo "Starting backend server with PM2..."
    pm2 start uvicorn --name backend -- backend:app --host 0.0.0.0 --port 8000 --reload
    echo "Backend server started with PM2."
}

# פונקציה להפעלת Frontend עם PM2
start_frontend() {
    echo "Starting frontend server with PM2..."
    pm2 start npm --name frontend -- run dev --prefix frontend
    echo "Frontend server started with PM2."
}

# פונקציה לעצירת כל התהליכים
stop_servers() {
    echo "Stopping all servers with PM2..."
    pm2 stop all
    pm2 delete all
    echo "All servers stopped and removed from PM2."
}

# פונקציה לצפייה בלוגים
view_logs() {
    echo "Showing logs for all servers..."
    pm2 logs
}

# בדיקה איזו פעולה להריץ
case "$1" in
    start)
        start_backend
        start_frontend
        ;;
    stop)
        stop_servers
        ;;
    restart)
        stop_servers
        start_backend
        start_frontend
        ;;
    logs)
        view_logs
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|logs}"
        exit 1
        ;;
esac