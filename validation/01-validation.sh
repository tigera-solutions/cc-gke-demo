#!/bin/bash

# 🚦 Calico Cloud GKE Policy Validation Suite (Demo)
# Run this *from your local terminal or Cloud Shell*—no testpod required!
# Requires: kubectl access to your cluster

YELLOW='\033[1;33m'
RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RESET='\033[0m'

function test_cmd() {
  DESC="$1"
  CMD="$2"
  POLICY="$3"
  echo -e "${CYAN}🔎 $DESC...${RESET}"
  eval "$CMD" >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ PASS${RESET}  (${POLICY})"
  else
    echo -e "${RED}⛔ FAIL${RESET}  (${POLICY})"
  fi
  echo ""
}

echo -e "${YELLOW}=== 🚦 Calico Cloud Policy Test Suite (Demo) ===${RESET}"
echo ""

# 1. DNS Lookup (should always PASS if DNS is allowed)
test_cmd "DNS Lookup (nslookup google.com from loadgenerator pod)" \
  "kubectl exec -n online-boutique deploy/loadgenerator -- nslookup google.com" \
  "Platform: DNS Allow"

# 2. Service-to-Service: LoadGen → Frontend
test_cmd "LoadGenerator to Frontend (curl frontend:8080 from loadgenerator)" \
  "kubectl exec -n online-boutique deploy/loadgenerator -- curl -s --max-time 2 http://frontend:8080/" \
  "Application: LoadGen→Frontend Allow"

# 3. Service-to-Service: Frontend → ProductCatalogService
test_cmd "Frontend to ProductCatalogService (curl productcatalogservice:3550 from frontend)" \
  "kubectl exec -n online-boutique deploy/frontend -- curl -s --max-time 2 http://productcatalogservice:3550/products" \
  "Application: Frontend→ProductCatalog Allow"

# 4. Service-to-Service: PaymentService → Redis (should FAIL if blocked)
test_cmd "PaymentService to Redis (curl redis-cart:6379 from paymentservice)" \
  "kubectl exec -n online-boutique deploy/paymentservice -- curl -s --max-time 2 redis-cart:6379" \
  "Application: Payment→Redis Block"

# 5. Egress: PaymentService → GitHub (should PASS if allowed)
test_cmd "PaymentService egress to GitHub (curl https://github.com from paymentservice)" \
  "kubectl exec -n online-boutique deploy/paymentservice -- curl -s --max-time 5 https://github.com" \
  "Application: Payment→GitHub Allow"

echo -e "${YELLOW}=== Test complete! Review PASS/FAIL to verify your segmentation & egress policies. ===${RESET}"
echo -e "📝 Tip: Run before and after applying policies for instant wow!"