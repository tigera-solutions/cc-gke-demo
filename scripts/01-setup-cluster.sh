#!/bin/bash
set -euo pipefail

# ------------------- COLOR PROMPTS -----------------------
YELLOW='\033[1;33m'
RESET='\033[0m'

# ------------------- INTERACTIVE INPUT -------------------
while [[ -z "${PROJECT_ID:-}" || "$PROJECT_ID" == "your-gcp-project-id" ]]; do
  read -p "$(echo -e "${YELLOW}🌐 Enter your GCP Project ID (e.g., my-gcp-project): ${RESET}")" PROJECT_ID
done

while [[ -z "${CLUSTER_NAME:-}" || "$CLUSTER_NAME" == "calico-demo-cluster" ]]; do
  read -p "$(echo -e "${YELLOW}🧩 Enter a name for your GKE cluster (e.g., calico-gke-demo): ${RESET}")" CLUSTER_NAME
done

while [[ -z "${REGION:-}" || "$REGION" == "us-central1" ]]; do
  read -p "$(echo -e "${YELLOW}🌎 Enter your preferred GCP region (e.g., us-central1, us-west1, europe-west1): ${RESET}")" REGION
done

NODE_COUNT=4
MACHINE_TYPE="n2-standard-4"
K8S_VERSION="1.31"   # Update if Calico supports higher, per https://docs.tigera.io/calico-cloud/get-started/gke

echo "---------------------------------------------"
echo "Setting up your GKE cluster for Calico Cloud PoC..."
echo "Project:      $PROJECT_ID"
echo "Cluster Name: $CLUSTER_NAME"
echo "Region:       $REGION"
echo "Nodes:        $NODE_COUNT x $MACHINE_TYPE"
echo "K8s Version:  $K8S_VERSION"
echo "---------------------------------------------"
echo

# 1. Authenticate (if needed)
echo "🔑 Authenticating with Google Cloud..."
echo "If you haven't already, run: gcloud auth login"
echo

# 2. Set GCP project
gcloud config set project "$PROJECT_ID"

# 3. Create the cluster -- NOTE: no --enable-network-policy!
echo "⚠️  NOTE: No network policy add-on will be enabled (required for Calico Cloud)."
echo "⚠️  NOTE: Enabling intra-node visibility for full flow log support."
echo "🚀 Creating the GKE cluster (this may take a few minutes)..."

gcloud container clusters create "$CLUSTER_NAME" \
  --project "$PROJECT_ID" \
  --region "$REGION" \
  --num-nodes "$NODE_COUNT" \
  --machine-type "$MACHINE_TYPE" \
  --release-channel "regular" \
  --cluster-version "$K8S_VERSION" \
  --enable-ip-alias \
  --enable-intra-node-visibility \
  --no-enable-network-policy

if [ $? -ne 0 ]; then
  echo "❌ Failed to create cluster. Please check your settings and permissions."
  exit 1
fi

echo "✅ GKE cluster created successfully!"
echo

# 4. Get kubeconfig
echo "🔗 Fetching kubectl credentials for your cluster..."
gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID"

if [ $? -ne 0 ]; then
  echo "❌ Failed to get credentials. Check gcloud CLI and cluster status."
  exit 1
fi

echo "✅ kubectl is now configured for your new cluster!"
echo
echo "🎉 Done! Your GKE cluster is ready for Calico Cloud onboarding."
echo "👉 Next: Deploy the Online Boutique demo app."
