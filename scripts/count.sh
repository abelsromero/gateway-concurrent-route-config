#!/bin/bash

set -euo pipefail

count_routes_all() {
  res=$(curl -s -X GET "http://localhost:8080/actuator/gateway/routes" | jq length)
  echo "Total: $res"
}
count_routes_by_group() {
  res=$(curl -s -X GET "http://localhost:8080/actuator/gateway/routes" | jq "[.[] | select(.metadata.group == \"group-$1\")] | length")
  echo "Routes for Group $1: $res"
}

echo "== Found routes:"
count_routes_all

for i in {1..5}; do
  count_routes_by_group "0$i"
done
