#!/usr/bin/env bash
set -euo pipefail

ENV="${1:-staging}"
echo "[INFO] Inspecting cluster in environment: $ENV"

CLUSTER_DATA='{"nodes": [{"id": "node-1", "cpu_percent": 45}, {"id": "node-2", "cpu_percent": 88}, {"id": "node-3", "cpu_percent": 60}]}'

echo "$CLUSTER_DATA" | jq -c '.nodes[]' | while read -r NODE; do
    ID=$(echo "$NODE" | jq -r '.id')
    CPU=$(echo "$NODE" | jq -r '.cpu_percent')

    if [[ "$CPU" -gt 75 ]]; then
        echo "[ALERT] $ID has high CPU usage: ${CPU}%"
    else
        echo "[OK] $ID CPU usage normal: ${CPU}%"
    fi
done
