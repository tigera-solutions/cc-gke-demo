#!/bin/bash
set -euo pipefail

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

echo -e "${CYAN}\n💥 Nuke Mode: Destroying ALL Demo Resources...\n${RESET}"

# 1. Delete Calico policies
echo -e "${YELLOW}Deleting ALL Calico policies (NetworkPolicies & GlobalNetworkPolicies)...${RESET}"
kubectl delete -f manifests/01-calico-policies/ || echo -e "${RED}No policies found or already deleted.${RESET}"

# 2. Delete Online Boutique app & namespace
echo -e "${YELLOW}Deleting Online Boutique application and namespace...${RESET}"
kubectl delete -f manifests/03-online-boutique/ || echo -e "${RED}No Online Boutique manifests found or already deleted.${RESET}"
kubectl delete ns online-boutique --ignore-not-found

# 3. Delete GKE cluster (auto-detects project, cluster, region)
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_INFO=$(gcloud container clusters list --format="value(name,location)" --project "$PROJECT_ID" | head -n 1)
CLUSTER_NAME=$(echo $CLUSTER_INFO | awk '{print $1}')
REGION=$(echo $CLUSTER_INFO | awk '{print $2}')

if [ -z "$CLUSTER_NAME" ] || [ -z "$REGION" ]; then
  echo -e "${RED}⛔ No GKE cluster found for auto-detection. Skipping GKE cluster deletion.${RESET}"
else
  echo -e "${RED}🚨 Deleting GKE cluster '${CLUSTER_NAME}' in region '${REGION}' (project '${PROJECT_ID}')...${RESET}"
  gcloud container clusters delete "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID" --quiet
fi

# 4. Delete demo repo folder itself (runs last!)
REPO_PATH="$(pwd)"
echo -e "${CYAN}Deleting local demo folder: $REPO_PATH${RESET}"
cd ~
rm -rf "$REPO_PATH"

echo -e "\n${GREEN}🎉 Nuke complete! ALL resources and this folder are gone. 🚀${RESET}"