#!/bin/bash
set -euo pipefail

echo "🎮 [Step] Creating 'testpod' namespace for hands-on testing..."
kubectl create namespace testpod || echo "Namespace already exists!"

echo "🔍 Deploying Netshoot (powerful test pod) in 'testpod' namespace..."
kubectl apply -n testpod -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: netshoot
  labels:
    app: netshoot
spec:
  containers:
  - name: netshoot
    image: nicolaka/netshoot:latest
    command: ["/bin/bash", "-c", "sleep infinity"]
    securityContext:
      runAsUser: 0
      privileged: true
  restartPolicy: Always
EOF

echo "⏳ Waiting for Netshoot pod to be ready..."
kubectl wait --for=condition=Ready pod/netshoot -n testpod --timeout=60s

echo "✅ 'testpod/netshoot' is up! Use it as your Jumpbox for all connectivity tests."
echo "Tip: Try 'kubectl exec -n testpod netshoot -- curl http://frontend.online-boutique:8080/' after policies are in place."
echo "Next: Use this pod to validate connectivity and microsegmentation policies!"