#!/bin/bash
set -euo pipefail

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RED='\033[1;31m'
RESET='\033[0m'

echo -e "${CYAN}🐾 [Calico Cloud Demo] Let's create your Calico Policy Tiers!${RESET}"
echo -e "${YELLOW}---${RESET}"

# Define the tiers in desired order of precedence (do NOT include 'default')
TIERS=("security" "platform" "application")

for TIER in "${TIERS[@]}"; do
  echo -e "${CYAN}🎯 Creating Calico Tier: ${TIER}...${RESET}"
  cat <<EOF | kubectl apply -f -
apiVersion: projectcalico.org/v3
kind: Tier
metadata:
  name: ${TIER}
spec:
  order: $(case $TIER in
    security) echo 0 ;;
    platform) echo 10 ;;
    application) echo 20 ;;
    # default tier intentionally omitted!
  esac)
EOF
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Tier '${TIER}' created or already exists!${RESET}"
  else
    echo -e "${RED}⛔ Failed to create tier '${TIER}'. Please check for errors.${RESET}"
    exit 1
  fi
  sleep 0.5
done

echo -e "${YELLOW}---${RESET}"
echo -e "${GREEN}🏆 All Calico Policy Tiers are ready!${RESET}"
echo -e "${CYAN}You can now apply your policies in each tier and show off that segmentation magic!${RESET}"