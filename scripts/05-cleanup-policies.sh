#!/bin/bash
set -euo pipefail

echo "🧹 Cleaning up Calico Network Policies by Tier..."

for tier in security platform application default; do
  DIR="manifests/02-calico-policies/tier-${tier}"
  if [ -d "$DIR" ]; then
    echo "❌ Deleting policies in tier: $tier"
    kubectl delete -f "$DIR/" --ignore-not-found
  fi
done

echo "✅ All policies cleaned up!"