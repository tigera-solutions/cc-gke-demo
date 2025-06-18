# ⚡ Prerequisites

Welcome! Before starting your Calico Cloud GKE PoC, please make sure you have the following ready for a smooth, frustration-free experience.

> 🆓 **Tip:** New to Google Cloud? [Sign up here](https://cloud.google.com/free/) for $300 in free credits—plenty for this PoC!

---

## ☁️ GKE Cluster Requirements
- **GKE Version:** v1.28 or newer ([See supported versions](https://docs.tigera.io/calico-cloud/get-started/gke))
- **Nodes:** 4–6 × `n2-standard-4` (or equivalent)
- **Network Policy:** Enable *at cluster creation* ([Guide](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy))
- **Region:** Any (choose closest to you for lowest latency)

---

## 🖥️ Local Machine Requirements
- `kubectl` v1.28+ ([Install](https://kubernetes.io/docs/tasks/tools/install-kubectl/))
- `helm` v3+ ([Install](https://helm.sh/docs/intro/install/))
- GCP IAM with cluster-admin privileges
- 🖥️ Modern web browser (Chrome/Edge recommended for Calico Cloud UI)

---

## 🔐 Permissions Needed
- GCP **Project Owner** (or equivalent)
- Rights to create GKE clusters & service accounts
- [Calico Cloud account](https://calicocloud.tigera.io) ([Sign up here](https://calicocloud.tigera.io))

---

## 💸 Estimated Cost
- Most demos cost **$5–$10** (with free credits)
- Extended: Up to **$30–$50** for 1–2 days (depends on region/nodes)
- > **Don’t forget to clean up!** Run the cleanup script at the end to avoid charges.

---

## 🔗 Useful Links
- [Calico Cloud GKE Quickstart](https://docs.tigera.io/calico-cloud/get-started/gke)
- [GKE Pricing Calculator](https://cloud.google.com/products/calculator)
- [Calico Cloud Documentation](https://docs.tigera.io/calico-cloud)
- [GKE Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy)

---

**✅ All set? [Go to the Quickstart Guide!](./docs/00-quickstart-guide.md)**

---

*If you hit a snag, [see Troubleshooting](./troubleshooting.md) or drop us a line!*