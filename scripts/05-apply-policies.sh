#!/bin/bash
set -euo pipefail

echo "🚦 Applying Calico Network Policies by Tier..."

for tier in security platform application default; do
  DIR="manifests/01-calico-policies/tier-${tier}"
  if [ -d "$DIR" ]; then
    echo "➡️ Applying policies in tier: $tier"
    kubectl apply -f "$DIR/"
  fi
done

echo "✅ All policies applied!"