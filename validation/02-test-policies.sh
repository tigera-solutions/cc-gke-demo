#!/bin/bash

# 🚦 Calico Cloud GKE Policy Validation Suite
# Run *inside* your testpod (netshoot/busybox/curl), or use 'kubectl exec' from your machine.
#
# Example: kubectl exec -it testpod -n testpod -- /bin/bash

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

echo -e "${YELLOW}=== 🚦 Calico Cloud Tiered Network Policy Test Suite ===${RESET}"
echo -e "🧪 *Run this from your test pod (e.g., netshoot in testpod namespace) or any app pod for microseg testing*"
echo ""

# 1. DNS Lookup (FQDN/egress DNS policy)
test_cmd "DNS Lookup (dig google.com)" \
  "dig +short google.com" \
  "Platform/Network DNS egress allow"

# 2. HTTP to Internet (egress policy)
test_cmd "HTTP Egress to Internet (curl https://google.com)" \
  "curl -s --max-time 5 https://google.com" \
  "Should PASS only if egress to Internet allowed"

# 3. ICMP Ping (optional egress)
test_cmd "ICMP Ping (ping 8.8.8.8)" \
  "ping -c 1 -W 1 8.8.8.8" \
  "Should FAIL unless ICMP explicitly allowed"

# 4. Service-to-Service: LoadGen → Frontend
test_cmd "LoadGenerator to Frontend (curl frontend:8080)" \
  "curl -s --max-time 2 http://frontend:8080/" \
  "Should PASS if allowed by app policy"

# 5. Service-to-Service: Frontend → ProductCatalogService
test_cmd "Frontend to ProductCatalogService (curl productcatalogservice:3550)" \
  "curl -s --max-time 2 http://productcatalogservice:3550/products" \
  "Should PASS if app-to-app allowed"

# 6. Namespace Isolation: TestPod → Online Boutique Frontend
test_cmd "TestPod → Online Boutique Frontend (curl frontend.online-boutique.svc.cluster.local:8080)" \
  "curl -s --max-time 2 http://frontend.online-boutique.svc.cluster.local:8080/" \
  "Should FAIL if microsegmentation is working"

# 7. FQDN Test: Only allow/deny specific external FQDNs (if policy applied)
test_cmd "FQDN Egress (curl https://www.github.com)" \
  "curl -s --max-time 5 https://www.github.com" \
  "Should PASS/FAIL based on FQDN policy"

# 8. Port-based Deny Test (if you have specific port denies)
test_cmd "Port 443 to Google (curl https://google.com:443)" \
  "curl -s --max-time 5 https://google.com:443" \
  "Should PASS/FAIL based on port policy"

# 9. Blocked Test: Unrelated Pod → PaymentService (should FAIL)
test_cmd "TestPod → PaymentService (curl paymentservice.online-boutique.svc.cluster.local:50051)" \
  "curl -s --max-time 2 http://paymentservice.online-boutique.svc.cluster.local:50051/" \
  "Should FAIL if default deny in place"

echo -e "${YELLOW}=== Test complete! Review PASS/FAIL for your segmentation, FQDN, and egress controls. ===${RESET}"
echo -e "📝 Tip: Run before and after applying policies for instant feedback!"