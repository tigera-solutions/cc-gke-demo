# 🚀 Calico Cloud GKE PoC Quickstart

Welcome to the **Calico Cloud GKE Proof of Concept**!

This repo guides you (or your client!) through deploying [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) on GKE, integrating with Calico Cloud, and demoing real-world security features—**step by step, no guesswork**.

---

## 📝 Table of Contents

* [⚡ Prerequisites](./docs/01-prerequisites.md)
* [🚀 Quickstart](#-quickstart)
* [🔗 References](#-references)
* [🛠️ Troubleshooting](./docs/02-troubleshooting.md)
* [📊 Observability](./docs/03-observability.md)
* [🧪 Validation & Testing](./validation/)
* [🧹 Cleanup](#-cleanup)

---

## ⚡ Prerequisites

Before you begin, make sure you’ve completed the [Prerequisites](./docs/01-prerequisites.md).

---

## 🚀 Quickstart

Follow these steps in order!

---

### 1️⃣ Create Your GKE Cluster

Clone this repo (if you haven’t already):

```bash
git clone https://github.com/YOUR-ORG/calico-cloud-gke-poc.git
cd calico-cloud-gke-poc
```

Create the GKE cluster (edit variables as needed):

```bash
./scripts/01-setup.sh
```

---

### 2️⃣ Deploy Online Boutique App

Deploy the Online Boutique demo application:

```bash
kubectl apply -f manifests/01-online-boutique/
```

Need help? [Online Boutique Guide](https://github.com/GoogleCloudPlatform/microservices-demo#quickstart)

---

### 3️⃣ Connect GKE to Calico Cloud

Run the guided connect script (manual step required):

```bash
./scripts/02-connect-calico-cloud.sh
```

This script walks you through logging in to Calico Cloud and running the install command.

---

### 4️⃣ Apply Network Policies (Microsegmentation, Egress, FQDN, Ports, etc)

Apply all policies tier by tier (recommended order):

```bash
./scripts/02-apply-policies.sh
```

See [`manifests/02-calico-policies/`](./manifests/02-calico-policies/) for policy YAMLs.
[What are tiers?](https://docs.tigera.io/calico/latest/network-policy/tiered-policy)

---

### 5️⃣ Validate & Test Your Policies

Run automated tests or manual checks:

```bash
./validation/02-test-policies.sh
```

Or follow the manual walkthrough in [`validation/01-test-scenarios.md`](./validation/01-test-scenarios.md)
Use `kubectl get pods -A`, `kubectl describe networkpolicy -A`, etc. to inspect live status.

---

### 6️⃣ Explore Observability & Flowlogs

* View Flowlogs, service graphs, and more in the Calico Cloud UI!
* [Observability Quickstart](./docs/03-observability.md)
* Want a deep dive? [Calico Cloud Docs](https://docs.tigera.io/calico-cloud/observability)

---

### 7️⃣ Cleanup Resources

Tear down policies, app, and cluster to avoid costs:

```bash
./scripts/03-cleanup.sh
```

---

## 🔗 References

* [Calico Cloud GKE Quickstart](https://docs.tigera.io/calico-cloud/get-started/gke)
* [Network Policy Tiers](https://docs.tigera.io/calico/latest/network-policy/tiered-policy)
* [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo)
* [Calico Cloud Documentation](https://docs.tigera.io/calico-cloud)
* [GKE Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy)

---

## 💡 Questions?

* Check [Troubleshooting](./docs/02-troubleshooting.md)
* Or reach out to your Calico Cloud Solutions Architect! 😄
