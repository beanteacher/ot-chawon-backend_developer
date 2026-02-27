#!/usr/bin/env bash
set -euo pipefail

SPEC_FILE="${1:-specs/openapi-v0.yaml}"

if [ ! -f "$SPEC_FILE" ]; then
  echo "[FAIL] spec file not found: $SPEC_FILE"
  exit 1
fi

required_paths=(
  "/health"
  "/products"
  "/size/predict"
)

echo "[INFO] checking required OpenAPI paths in $SPEC_FILE"
for path in "${required_paths[@]}"; do
  if rg -q "^\s{2}${path}:" "$SPEC_FILE"; then
    echo "[PASS] path exists: $path"
  else
    echo "[FAIL] path missing: $path"
    exit 1
  fi
done

echo "[DONE] openapi required path check passed"
