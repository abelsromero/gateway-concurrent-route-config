#!/bin/bash

set -euo pipefail

create_route() {
  local -r id="$1"
  local -r group="$2"

  curl -X POST "http://localhost:8080/actuator/gateway/routes" \
  -H 'Content-Type: application/json' \
  -d "[
    {
      \"id\": \"route-$id-group-$group\",
      \"uri\": \"http://go-httpbin\",
      \"predicates\": [ \"Path=/test/**\" ],
      \"filters\": [ \"StripPrefix=1\" ],
      \"metadata\": { \"group\": \"group-$group\" }
    }
  ]"
}

create_routes() {
  local -r group="$1"
  local -r routes="$2"

  init=$((group*100))
  limit=$((init+routes))

  for ((i=init; i<limit; i++)); do
    create_route "$i" "0$group"
  done
  echo "Created $routes routes, group 0$group"
}

for i in {1..5}; do
  create_routes $i 50
done
