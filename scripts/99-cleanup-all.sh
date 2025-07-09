#!/bin/bash
set -euo pipefail

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

function prompt_yes_no() {
  local PROMPT="$1"
  read -p "$(echo -e "${YELLOW}${PROMPT}${RESET}")" answer
  [[ "$answer" =~ ^[Yy]$ ]]
}

echo -e "${CYAN}\n🧹 Welcome to Demo Nuke Mode!\n${RESET}"
echo -e "${YELLOW}This script will *clean up* EVERYTHING this demo created:"
echo -e " • Calico policies"
echo -e " • Online Boutique app"
echo -e " • Your GKE cluster"
echo -e " • This demo folder (optional!)"
echo -e "You'll be prompted at every step. Hit 'y' to delete, anything else to skip.${RESET}"
echo -e "${YELLOW}-----------------------------------------------${RESET}"

# 1. Delete Calico policies
if prompt_yes_no "❓ Delete ALL Calico policies (NetworkPolicies & GlobalNetworkPolicies)? (y/n): "; then
  kubectl delete -f manifests/01-calico-policies/ || echo -e "${RED}No policies found or already deleted.${RESET}"
  echo -e "${GREEN}✅ Calico policies deleted.${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping Calico policy deletion.${RESET}"
fi
echo ""

# 2. Delete Online Boutique application
if prompt_yes_no "❓ Delete the Online Boutique application? (y/n): "; then
  kubectl delete -f manifests/03-online-boutique/ || echo -e "${RED}No Online Boutique manifests found or already deleted.${RESET}"
  kubectl delete ns online-boutique --ignore-not-found
  echo -e "${GREEN}✅ Online Boutique deleted.${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping Online Boutique deletion.${RESET}"
fi
echo ""

# 3. Delete GKE Cluster
# Auto-detect GCP project, region, and cluster name (works for single-cluster demo environments)
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_INFO=$(gcloud container clusters list --format="value(name,location)" --project "$PROJECT_ID" | head -n 1)
CLUSTER_NAME=$(echo $CLUSTER_INFO | awk '{print $1}')
REGION=$(echo $CLUSTER_INFO | awk '{print $2}')

if [ -z "$CLUSTER_NAME" ] || [ -z "$REGION" ]; then
  echo -e "${RED}⛔ Could not auto-detect a GKE cluster. Skipping GKE cluster deletion.${RESET}"
else
  echo -e "${RED}🚨 [WARNING] About to delete GKE cluster '${CLUSTER_NAME}' in region '${REGION}' (project '${PROJECT_ID}'). This is IRREVERSIBLE!${RESET}"
  if prompt_yes_no "❓ Nuke this GKE cluster and all resources? (y/n): "; then
    gcloud container clusters delete "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT_ID" --quiet
    echo -e "${GREEN}✅ GKE cluster deleted.${RESET}"
  else
    echo -e "${YELLOW}⏭️  Skipping GKE cluster deletion.${RESET}"
  fi
fi

# 4. Nuke local repo folder!
REPO_PATH="$(pwd)"
echo -e "${CYAN}💥 Almost done! Want to *completely* erase this demo folder from your machine?${RESET}"
echo -e "${YELLOW}Path: $REPO_PATH${RESET}"
if prompt_yes_no "❓ Delete this demo folder from your local machine too? (y/n): "; then
  cd ~
  rm -rf "$REPO_PATH"
  echo -e "${GREEN}✅ Demo folder deleted. You're 100% clean!${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping demo folder deletion. Delete manually if you want!${RESET}"
fi

echo -e "\n${GREEN}🎉 ALL DONE! Your cloud and local environment are sparkling clean. Go grab a ☕ or run the demo again! 🚀${RESET}"