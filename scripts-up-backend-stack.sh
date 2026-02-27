#!/usr/bin/env bash
set -euo pipefail

docker compose -f docker-compose.backend.yml up -d --build

echo "backend stack started"
