#!/usr/bin/env bash
set -euo pipefail

assert_ok() {
  local url="$1"
  local label="$2"
  local body
  body=$(curl -sS "$url")
  echo "$body" | python3 - <<'PY'
import json,sys
raw=sys.stdin.read().strip()
data=json.loads(raw)
required=['success','data','message','traceId']
for k in required:
    assert k in data, f"missing:{k}"
print('OK')
PY
  echo "PASS: $label"
}

assert_ok "http://localhost:8082/api/v1/products" "product-list"
assert_ok "http://localhost:8081/api/v1/users/me" "user-me"
assert_ok "http://localhost:8083/api/v1/orders/1" "order-get"
