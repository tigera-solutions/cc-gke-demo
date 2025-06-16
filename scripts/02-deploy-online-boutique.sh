#!/bin/bash
set -euo pipefail

# -------------------------------------------------------------
# Deploy Online Boutique Demo App to GKE Cluster
# -------------------------------------------------------------
# This script will deploy Google's Online Boutique demo app to your
# active GKE cluster context. Make sure your kubectl is configured!
# -------------------------------------------------------------

echo "---------------------------------------------"
echo "Deploying Online Boutique Demo App to GKE..."
echo "---------------------------------------------"
echo

# 1. Download the Online Boutique release manifest
echo "⬇️  Downloading the latest Online Boutique manifest from Google..."
curl -sSLf -o /tmp/online-boutique.yaml https://raw.githubusercontent.com/GoogleCloudPlatform/microservices-demo/main/release/kubernetes-manifests.yaml

if [ $? -ne 0 ]; then
  echo "❌ Failed to download manifest. Check your internet connection."
  exit 1
fi

echo "✅ Manifest downloaded successfully."
echo

# 2. Deploy the app to your cluster
echo "🚀 Applying Online Boutique manifest to the cluster..."
kubectl apply -f /tmp/online-boutique.yaml

if [ $? -ne 0 ]; then
  echo "❌ Failed to deploy Online Boutique. Check your kubectl config and cluster."
  exit 1
fi

echo "✅ Online Boutique resources created!"
echo

# 3. Wait for all pods to be running
echo "⏳ Waiting for all Online Boutique pods to be ready..."
kubectl wait --for=condition=Ready pods --all -n default --timeout=180s

echo
echo "🔎 Checking Online Boutique services and pods:"
kubectl get svc
kubectl get pods

# Get External IP for frontend-external service
EXTERNAL_IP=$(kubectl get svc frontend-external -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null)

if [ -z "$EXTERNAL_IP" ]; then
  echo "⏳ The EXTERNAL-IP for the frontend service is still pending."
  echo "🔄 It may take a couple minutes for GKE to assign it."
  echo "👉 Run this command in a few moments to check again:"
  echo "   kubectl get svc frontend-external"
  echo "🌐 Once you see an EXTERNAL-IP, open http://<EXTERNAL-IP> in your browser!"
else
  echo "🎉 Online Boutique is live! Open in your browser:"
  echo "   http://$EXTERNAL_IP"
fi