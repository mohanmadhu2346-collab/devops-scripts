#!/usr/bin/env bash
set -euo pipefail

if [[ $#  -lt 1]]; then	
	echo "Usage: $0 <path-to-folder-to-backup>"
	exit 1
fi
TARGET_DIR="$1"
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' does not exist!"
    exit 2
fi
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="/tmp/backups"
mkdir -p "$BACKUP_DIR"
ARCHIVE_NAME="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"
tar -czf "$ARCHIVE_NAME" "$TARGET_DIR" 2>/dev/null
echo "[SUCCESS] Backup created at: $ARCHIVE_NAME"
