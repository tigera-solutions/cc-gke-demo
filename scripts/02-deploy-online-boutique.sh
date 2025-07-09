#!/bin/bash
set -euo pipefail

# -------------------------------------------------------------
# Deploy Online Boutique Demo App to GKE Cluster (with namespace creation)
# -------------------------------------------------------------
# This script deploys Google's Online Boutique demo app to your
# active GKE cluster. Make sure your kubectl context is correct!
# -------------------------------------------------------------

NAMESPACE="online-boutique"
MANIFEST_URL="https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml"

echo "---------------------------------------------"
echo "Deploying Online Boutique Demo App to GKE..."
echo "---------------------------------------------"
echo

# 1. Create Namespace (if it doesn't exist)
if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
  kubectl create namespace "$NAMESPACE"
  echo "✅ Namespace '$NAMESPACE' created."
else
  echo "ℹ️  Namespace '$NAMESPACE' already exists."
fi

# 2. Download the Online Boutique release manifest
echo "⬇️  Downloading the latest Online Boutique manifest from Google..."
curl -sSLf -o /tmp/online-boutique.yaml "$MANIFEST_URL"

if [ $? -ne 0 ]; then
  echo "❌ Failed to download manifest. Check your internet connection."
  exit 1
fi

echo "✅ Manifest downloaded successfully."
echo

# 3. Deploy the app to your cluster in the correct namespace
echo "🚀 Applying Online Boutique manifest to the cluster in namespace '$NAMESPACE'..."
kubectl apply -n "$NAMESPACE" -f /tmp/online-boutique.yaml

if [ $? -ne 0 ]; then
  echo "❌ Failed to deploy Online Boutique. Check your kubectl config and cluster."
  exit 1
fi

echo "✅ Online Boutique resources created in namespace '$NAMESPACE'!"
echo

# 4. Wait for all pods to be running
echo "⏳ Waiting for all Online Boutique pods to be ready in '$NAMESPACE'..."
kubectl wait --for=condition=Ready pods --all -n "$NAMESPACE" --timeout=300s || \
  echo "⚠️  Some pods may still be starting. Check with: kubectl get pods -n $NAMESPACE"

echo
echo "🔎 Checking Online Boutique services and pods:"
kubectl get svc -n "$NAMESPACE"
kubectl get pods -n "$NAMESPACE"

# 5. Expose the frontend via LoadBalancer (should be default, but just in case)
if ! kubectl get svc frontend-external -n "$NAMESPACE" >/dev/null 2>&1; then
  kubectl expose deployment frontend --type=LoadBalancer --name=frontend-external -n "$NAMESPACE" --port=80 --target-port=8080
  echo "Service 'frontend-external' exposed as LoadBalancer."
else
  echo "Service 'frontend-external' already exposed."
fi

# 6. Wait for the external IP
echo "Waiting for the LoadBalancer's external IP (can take 2-5 minutes on GKE)..."
for i in {1..30}; do
  EXTERNAL_IP=$(kubectl get svc frontend-external -n "$NAMESPACE" -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || true)
  if [[ -n "$EXTERNAL_IP" ]]; then
    break
  fi
  sleep 10
done

if [[ -n "$EXTERNAL_IP" ]]; then
  echo "🎉 Online Boutique is live! Open in your browser:"
  echo "   http://$EXTERNAL_IP"
else
  echo "❌ Could not get an external IP for the service after several minutes."
  echo "Please check 'kubectl get svc -n $NAMESPACE' and GCP Console for more info."
fi

echo
echo "✅ Deployment script complete."
echo "If you see a 404 or timeout, wait a bit and refresh."
echo "-------------------------------------------------------------"