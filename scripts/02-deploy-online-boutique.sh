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

echo
echo "🎉 Done! Online Boutique is now running on your GKE cluster."
echo "👉 Find the frontend service's EXTERNAL-IP with:"
echo "   kubectl get svc frontend-external"
echo "   Then open http://<EXTERNAL-IP> in your browser."