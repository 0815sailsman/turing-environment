#!/bin/bash
set -e

echo "[GitOps] Pulling latest changes..."
git pull

for dir in services/*; do
  svc_name=$(basename "$dir")
  echo "[GitOps] Checking service: $svc_name"

  pushd "$dir" >/dev/null

  # Build hash from compose + env + any config
  CURRENT_HASH=$(cat docker-compose.yml .env 2>/dev/null | sha256sum | awk '{print $1}')
  LAST_HASH_FILE=".last-deploy-hash"

  if [[ ! -f "$LAST_HASH_FILE" ]] || [[ "$CURRENT_HASH" != "$(cat $LAST_HASH_FILE)" ]]; then
    echo "[GitOps] → Changes detected. Restarting $svc_name..."

    podman-compose down
    podman-compose up -d

    echo "$CURRENT_HASH" > "$LAST_HASH_FILE"
  else
    echo "[GitOps] → No changes. Skipping $svc_name."
  fi

  popd >/dev/null
done

echo "[GitOps] Deployment complete."

