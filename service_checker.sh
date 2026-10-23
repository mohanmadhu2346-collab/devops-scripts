#!/usr/bin/env bash
set -euo pipefail

TARGET_FILE="${1:-targets.txt}"

if [[ ! -f "$TARGET_FILE" ]]; then
    echo "[ERROR] Target list file '$TARGET_FILE' does not exist."
    exit 1
fi

echo "[INFO] Reading targets from: $TARGET_FILE"

while read -r DOMAIN; do
    # Skip empty lines
    [[ -z "$DOMAIN" ]] && continue

    echo -n "Checking $DOMAIN... "
    if ping -c 1 -W 1 "$DOMAIN" > /dev/null 2>&1; then
        echo "[ONLINE]"
    else
        echo "[UNREACHABLE]"
    fi
done < "$TARGET_FILE"
