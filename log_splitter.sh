#!/usr/bin/env bash
set -u

LOG_DIR="./logs"
mkdir -p "$LOG_DIR"

APP_LOG="$LOG_DIR/app.log"
ERR_LOG="$LOG_DIR/error.log"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting log splitter test" >> "$APP_LOG"

# 1. Successful command -> goes to app.log
echo "Valid operation: System uptime is $(uptime -p)" >> "$APP_LOG" 2>> "$ERR_LOG"

# 2. Failing command -> error automatically routes to error.log
ls /non_existent_directory_for_test >> "$APP_LOG" 2>> "$ERR_LOG"

# 3. Another successful command
echo "Valid operation: Memory check finished" >> "$APP_LOG" 2>> "$ERR_LOG"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Finished operations" >> "$APP_LOG"
