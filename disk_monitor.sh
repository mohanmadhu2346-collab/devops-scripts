#!/usr/bin/env bash
set -euo pipefail
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
THRESHOLD="${1:-80}"
if [[ "$DISK_USAGE" -ge "$THRESHOLD" ]]; then
	echo "[WARNING] Disk usage is at ${DISK_USAGE}%, exceeding threshold of ${THRESHOLD}%!"
else
	echo "[HEALTHY] Disk usage is at ${DISK_USAGE}% (Threshold: ${THRESHOLD}%)"
fi

