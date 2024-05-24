#!/bin/bash

set -euo pipefail

refresh_routes() {
  curl -X POST "http://localhost:8080/actuator/gateway/refresh?metadata=group:group-$1" -I &
  echo "Refresh for Group $1 sent: $(date)"
}

for i in {1..5}; do
  refresh_routes "0$i"
done
