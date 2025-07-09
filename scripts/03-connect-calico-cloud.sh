#!/bin/bash
set -euo pipefail

echo ""
echo "🚀 [Step 3] Connect your GKE cluster to Calico Cloud"
echo "---------------------------------------------------------------"

echo "Step 1: Sign up for Calico Cloud (if you haven't already)"
echo "👉 Go to: https://calicocloud.io/"
echo "    - Use your business email to start a free trial."
echo "    - Complete email verification & login."

echo ""
read -p "Press [Enter] when you are signed into the Calico Cloud UI..."

echo ""
echo "Step 2: In Calico Cloud UI, click 'Add a Cluster' or 'Install Calico Cloud Agent'"
echo "    - Select 'GKE' as your platform."
echo "    - Copy the provided installation command (it starts with 'kubectl apply -f ...')"

# Capture install command and validate it
echo ""
read -p "Paste the full install command here and press [Enter]: " CALICO_INSTALL_CMD

if [[ ! "$CALICO_INSTALL_CMD" =~ kubectl ]]; then
  echo "❌ The install command doesn't look like a 'kubectl ...' command."
  echo "Please try again and paste the full command from the Calico Cloud UI."
  exit 1
fi

echo ""
echo "Running the Calico Cloud agent install command:"
echo "$CALICO_INSTALL_CMD"
eval "$CALICO_INSTALL_CMD"

echo ""
echo "⏳ Waiting for Calico Cloud agent pods to be ready (this may take 1-5 minutes)..."

# Wait for pods in likely namespaces
NAMESPACES="tigera-operator tigera-system calico-system"
READY_PODS=0

for i in {1..30}; do
  READY_PODS=0
  for ns in $NAMESPACES; do
    READY_PODS=$((READY_PODS + $(kubectl get pods -n $ns --no-headers 2>/dev/null | grep -c 'Running' || true)))
  done
  if [[ "$READY_PODS" -ge 1 ]]; then
    break
  fi
  sleep 10
done

echo ""
echo "✅ Calico Cloud agent install command executed!"
echo ""
echo "You can check agent status with:"
echo "    kubectl get pods -A | grep tigera"
echo ""
echo "Or view component status with:"
echo "    kubectl get tigerastatus"
echo ""
echo "Go back to the Calico Cloud UI. Your GKE cluster should appear as 'Connected' within a few minutes."
echo ""
echo "Next up: Apply network policies, microsegmentation, and test scenarios!"
echo "---------------------------------------------------------------"