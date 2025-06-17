#!/bin/bash
set -euo pipefail

# -------------------------------------------------------------
# Calico Cloud GKE Demo Cluster Setup Script
# -------------------------------------------------------------
# This script will create a GKE cluster with Calico (network policy)
# enabled, using recommended settings for Calico Cloud PoCs.
# -------------------------------------------------------------

# 1. Customize these variables as needed
# --------------------------------------
PROJECT_ID="your-gcp-project-id"         # <-- REPLACE with your GCP Project ID
CLUSTER_NAME="calico-demo-cluster"       # <-- You can name this whatever you like
REGION="us-central1"                     # <-- Use your preferred region (e.g., us-central1, us-west1)
NODE_COUNT=4                             # <-- 4-6 nodes recommended for PoC
MACHINE_TYPE="n2-standard-4"             # <-- Change if you want a different node size

# Prompt if the PROJECT_ID hasn't been updated from the default
if [[ "$PROJECT_ID" == "your-gcp-project-id" ]]; then
  read -p "Enter your actual GCP Project ID (e.g., my-gcp-project): " PROJECT_ID
fi

# Prompt if the CLUSTER_NAME is still the default
if [[ "$CLUSTER_NAME" == "calico-demo-cluster" ]]; then
  read -p "Enter your preferred GKE Cluster Name (e.g., calico-gke-demo): " CLUSTER_NAME
fi

# Prompt if the REGION is still the default
if [[ "$REGION" == "us-central1" ]]; then
  read -p "Enter your preferred GCP region (e.g., us-central1, us-west1, europe-west1): " REGION
fi

echo "---------------------------------------------"
echo "Setting up your GKE cluster with Calico..."
echo "Project:      $PROJECT_ID"
echo "Cluster Name: $CLUSTER_NAME"
echo "Region:       $REGION"
echo "Nodes:        $NODE_COUNT x $MACHINE_TYPE"
echo "---------------------------------------------"
echo

# 2. Authenticate with Google Cloud (skip if already done)
# --------------------------------------------------------
echo "🔑 Authenticating with Google Cloud..."
echo "If you haven't already, run: gcloud auth login"
echo

# 3. Set your project in gcloud
gcloud config set project "$PROJECT_ID"

# 4. Create the GKE cluster with network policy enabled
# -----------------------------------------------------
echo "⚠️  NOTE: Cluster will be created with Kubernetes version 1.31 due to Calico compatibility."
echo "🚀 Creating the GKE cluster (this may take a few minutes)..."
gcloud container clusters create "$CLUSTER_NAME" \
  --project "$PROJECT_ID" \
  --region "$REGION" \
  --num-nodes "$NODE_COUNT" \
  --machine-type "$MACHINE_TYPE" \
  --release-channel "regular" \
  --cluster-version "1.31" \
  --enable-ip-alias


if [ $? -ne 0 ]; then
  echo "❌ Failed to create cluster. Please check your settings and permissions."
  exit 1
fi

echo "✅ GKE cluster created successfully!"
echo

# 5. Get kubectl credentials for your new cluster
# -----------------------------------------------
echo "🔗 Fetching kubectl credentials for your cluster..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "❌ Failed to get credentials. Check gcloud CLI and cluster status."
  exit 1
fi

echo "✅ kubectl is now configured for your new cluster!"
echo

# 6. Verify Calico is running in the kube-system namespace
# --------------------------------------------------------
echo "🔍 Verifying Calico pods are running in kube-system namespace..."
kubectl get pods -n kube-system | grep calico

echo
echo "🎉 Done! Your GKE cluster is ready for Calico Cloud onboarding."
echo "👉 Next: Deploy the Online Boutique demo app."
