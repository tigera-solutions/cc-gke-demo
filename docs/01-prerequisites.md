# ⚡ Prerequisites

Welcome! Before starting your Calico Cloud GKE PoC, please make sure you have the following ready to ensure a smooth experience. If you run into any blockers, check our [Troubleshooting Guide](./troubleshooting.md) or reach out!

---

## ☁️ GKE Cluster Requirements
- **GKE Version:** v1.28+ ([Supported versions](https://docs.tigera.io/calico-cloud/get-started/gke))
- **Nodes:** 4–6 x `n2-standard-4` (or equivalent)
- **Network Policy:** Must be enabled at cluster creation (see [GKE Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy))
- **Region:** Your preferred GCP region

---

## 🖥️ Local Machine Requirements
- `kubectl` v1.28+ ([Install guide](https://kubernetes.io/docs/tasks/tools/install-kubectl/))
- `helm` v3+ ([Install guide](https://helm.sh/docs/intro/install/))
- Access to your GCP project with cluster-admin permissions
- Modern web browser (for Calico Cloud UI)

---

## 🔐 Permissions Needed
- GCP project **Owner** or equivalent permissions
- Ability to create and manage GKE clusters and service accounts
- [Calico Cloud](https://calicocloud.tigera.io) account (sign up if you don’t have one!)

---

## 💸 Estimated Cost
- Typical demo: ~$30–$50 for 1–2 days of testing (depends on region/node type)
- Clean up resources after testing to avoid unwanted charges!

---

## 🔗 Useful Links
- [Calico Cloud GKE Quickstart](https://docs.tigera.io/calico-cloud/get-started/gke)
- [GKE Pricing Calculator](https://cloud.google.com/products/calculator)
- [Calico Cloud Documentation](https://docs.tigera.io/calico-cloud)
- [GKE Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy)

---

**You’re ready to go! Next: head to the [🚀 Quickstart Guide](./quickstart.md) to deploy your demo cluster.**