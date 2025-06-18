#!/bin/bash
set -euo pipefail

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
RESET='\033[0m'

function prompt_yes_no() {
  local PROMPT="$1"
  read -p "$(echo -e "${YELLOW}${PROMPT}${RESET}")" answer
  [[ "$answer" =~ ^[Yy]$ ]]
}

echo -e "${YELLOW}🧹 [Cleanup Script] Interactive teardown for your Calico GKE PoC environment.${RESET}"
echo -e "${YELLOW}Each step will prompt you for confirmation (y/n).${RESET}"
echo "-----------------------------------------------"

# 1. Delete Calico policies
echo ""
if prompt_yes_no "❓ Do you want to DELETE all Calico NetworkPolicies and GlobalNetworkPolicies? (y/n): "; then
  echo -e "${YELLOW}🚨 Deleting Calico policies...${RESET}"
  kubectl delete -f manifests/policies/ || echo -e "${RED}No policies found or already deleted.${RESET}"
  echo -e "${GREEN}✅ Policies deleted. Verifying...${RESET}"
  kubectl get networkpolicies,globalnetworkpolicies -A || echo -e "${GREEN}No Calico policies found.${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping Calico policy deletion.${RESET}"
fi

echo ""
# 2. Delete Online Boutique application
if prompt_yes_no "❓ Do you want to DELETE the Online Boutique application? (y/n): "; then
  echo -e "${YELLOW}🛒 Deleting Online Boutique application...${RESET}"
  kubectl delete -f manifests/online-boutique/ || echo -e "${RED}No Online Boutique manifests found or already deleted.${RESET}"
  echo -e "${GREEN}✅ Online Boutique deleted. Verifying...${RESET}"
  kubectl get all -n online-boutique || echo -e "${GREEN}No resources found in online-boutique namespace.${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping Online Boutique deletion.${RESET}"
fi

echo ""
# 3. Delete testpod namespace
if prompt_yes_no "❓ Do you want to DELETE the testpod namespace? (y/n): "; then
  echo -e "${YELLOW}🔬 Deleting testpod namespace...${RESET}"
  kubectl delete namespace testpod || echo -e "${RED}Namespace 'testpod' not found or already deleted.${RESET}"
  echo -e "${GREEN}✅ testpod namespace deleted. Verifying...${RESET}"
  kubectl get ns testpod || echo -e "${GREEN}Namespace 'testpod' does not exist.${RESET}"
else
  echo -e "${YELLOW}⏭️  Skipping testpod namespace deletion.${RESET}"
fi

echo ""
# 4. Delete GKE Cluster
echo -e "${RED}🚨 [WARNING] Deleting your GKE cluster is IRREVERSIBLE and removes ALL workloads.${RESET}"
if prompt_yes_no "❓ Do you want to DELETE your GKE cluster as well? (y/n): "; then
  # Prompt for cluster name and region
  read -p "$(echo -e "${YELLOW}Enter your GKE cluster name: ${RESET}")" CLUSTER_NAME
  read -p "$(echo -e "${YELLOW}Enter your GKE cluster region: ${RESET}")" REGION

  echo -e "${RED}About to delete cluster '${CLUSTER_NAME}' in region '${REGION}'. This cannot be undone!${RESET}"
  if prompt_yes_no "🚨 Are you ABSOLUTELY SURE you want to DELETE this GKE cluster? (y/n): "; then
    gcloud container clusters delete "$CLUSTER_NAME" --region "$REGION"
    echo -e "${GREEN}✅ GKE cluster deleted.${RESET}"
  else
    echo -e "${YELLOW}⏭️  Skipping GKE cluster deletion.${RESET}"
  fi
else
  echo -e "${YELLOW}⏭️  Skipping GKE cluster deletion.${RESET}"
fi

echo -e "\n${GREEN}🎉 Cleanup process complete! Your environment should now be clean.${RESET}"
