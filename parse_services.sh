#!/usr/bin/env bash
set -euo pipefail

# Simulated JSON payload (identical to what cloud APIs or microservice health endpoints return)
METRICS_JSON='{
  "cluster": "production-south",
  "services": [
    {"name": "payment-api", "status": "UP", "latency_ms": 42},
    {"name": "cart-api", "status": "UP", "latency_ms": 35},
    {"name": "auth-api", "status": "DOWN", "latency_ms": 0}
  ]
}'

CLUSTER=$(echo "$METRICS_JSON" | jq -r '.cluster')
echo "[INFO] Inspecting cluster: $CLUSTER"

# Process each service entry line by line
echo "$METRICS_JSON" | jq -c '.services[]' | while read -r SERVICE_ROW; do
    NAME=$(echo "$SERVICE_ROW" | jq -r '.name')
    STATUS=$(echo "$SERVICE_ROW" | jq -r '.status')
    LATENCY=$(echo "$SERVICE_ROW" | jq -r '.latency_ms')

    if [[ "$STATUS" != "UP" ]]; then
        echo "[CRITICAL ALERT] $NAME is $STATUS (Latency: ${LATENCY}ms)"
    else
        echo "[OK] $NAME is healthy (${LATENCY}ms)"
    fi
done
