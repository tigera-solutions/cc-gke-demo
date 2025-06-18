<h1 align="center" style="font-size:2.5em">🚀 Calico Cloud GKE PoC Quickstart Guide</h1>

<p align="center">
  <img src="https://github.com/user-attachments/assets/a994de07-0a3b-479d-b7be-9fd393252a74" alt="Calico_Cloud_logo" width="350"/>
</p>

<p align="center"><b>🚀 Calico Cloud: Unify, Simplify, and Secure—now in under an hour!</b></p>


> 🏆 **Ready to Learn Unified Network Security in Under an Hour?** <br>
> This interactive demo kit guides you (or your customer!) through deploying Online Boutique on GKE, connecting to Calico Cloud, and experiencing microsegmentation, egress controls, FQDN, and observability—**step by step, with zero guesswork**.

---

## 📝 Table of Contents

* [Prerequisites](#prerequisites)
* [Create Your GKE Cluster](#create-your-gke-cluster)
* [Deploy Online Boutique](#deploy-online-boutique)
* [Connect GKE to Calico Cloud](#connect-gke-to-calico-cloud)
* [Validate Connectivity BEFORE Policies](#validate-connectivity-before-policies)
* [Apply Network Policies](#apply-network-policies)
* [Validate Connectivity AFTER Policies](#validate-connectivity-after-policies)
* [Deploy Your TestPod (Jumpbox)](#deploy-your-testpod-jumpbox)
* [Explore Observability & Flowlogs](#explore-observability--flowlogs)
* [Cleanup Resources](#cleanup-resources)
* [References](#references)
* [FAQ & Support](#faq--support)

---

## ⚡ Prerequisites

* A Google Cloud account with GKE enabled ([Free Tier works](https://cloud.google.com/free/))
* A Calico Cloud Account ([Free Tier works](https://www.calicocloud.io/home))
* 45–60 minutes of focus!
* Basic comfort with the command line (no prior GKE/Calico experience needed!)
* \~\$5–\$10 Google Cloud budget (Free credits work!)

> ℹ️ **Tip:** Never used GKE? [Google's Quickstart](https://cloud.google.com/kubernetes-engine/docs/quickstart) has your back!

---
> 📋 **Full Prerequisites & Checklist:**  
> Don’t miss the [detailed guide here.](./docs/01-prerequisites.md)
---

## 🏗️ Create Your GKE Cluster

> ⚠️ **Important:**
> For Calico Cloud compatibility, this PoC requires your GKE cluster to be created with **Kubernetes version 1.31**.
> The setup script will automatically use version `1.31`.
> Do **not** upgrade your cluster to a higher version unless [Calico documentation](https://docs.tigera.io/calico-cloud/get-started/gke) confirms compatibility.

**Clone the repo:**

```bash
git clone https://github.com/tigera-solutions/cc-demo-gke.git
cd cc-demo-gke
```

**Make demo scripts executable:**

```bash
chmod +x scripts/*.sh
```

> 💡 *Run this once after cloning so you avoid permission errors!*

**Create the GKE cluster:**

```bash
./scripts/01-setup-cluster.sh
```

---

## 🛒 Deploy Online Boutique

```bash
./scripts/02-deploy-online-boutique.sh
```

> Need help? [Online Boutique Guide](https://github.com/GoogleCloudPlatform/microservices-demo#quickstart)

---

## ☁️ Connect GKE to Calico Cloud

```bash
./scripts/03-connect-calico-cloud.sh
```

> This script walks you through logging in to Calico Cloud and running the install command.

---

## 🧪 Validate Connectivity BEFORE Policies

> 🟠 **Run this before you apply network policies!**

```bash
./validation/01-test-policies.sh
```

*This will show you open/allowed traffic between all pods/services by default.*

> ℹ️  **Want to learn more?**  
> See [Full Test Scenarios Explained](./validation/00-test-scenarios.md) for details on each validation step.
---

## 🛡️ Apply Network Policies (Microsegmentation, Egress, FQDN, etc)

```bash
./scripts/05-apply-policies.sh
```

* Policies are organized by tier (security, platform, application, etc.) for real-world clarity.
* See [`manifests/02-calico-policies/`](./manifests/01-calico-policies/) for all policy YAMLs.
* [What are tiers?](https://docs.tigera.io/calico/latest/network-policy/tiered-policy)

---

## 🧪 Validate Connectivity AFTER Policies

> 🟢 **Run the validation again!**

```bash
./validation/01-test-policies.sh
```

*Notice how segmentation, blocking, or FQDN rules now take effect!*

> ℹ️  **Want to learn more?**  
> See [Full Test Scenarios Explained](./validation/00-test-scenarios.md) for details on each validation step.
---

## 🔬 Deploy Your TestPod (Jumpbox)

<details>
<summary><b>What’s the TestPod?</b></summary>
<p>
A "jumpbox" pod in its own namespace to let you safely run <code>dig</code>, <code>curl</code>, or <code>ping</code> without affecting app workloads. Perfect for validating policy enforcement hands-on.
</p>
</details>

```bash
./scripts/06-create-testpod.sh
```

> 💡 Tip: Use <code>kubectl exec -it testpod -n testpod -- bash</code> to open a shell and play around.

---

## 👀 Explore Observability & Flowlogs

* View Flowlogs, service graphs, and more in the Calico Cloud UI!
* [Observability Quickstart](./03-observability.md)
* Want a deep dive? [Calico Cloud Docs](https://docs.tigera.io/calico-cloud/observability)

---

## 🧹 Cleanup Resources

```bash
./scripts/99-cleanup-all.sh
```

*Interactive prompts let you delete policies, testpod, Online Boutique, and finally your GKE cluster—step by step!*

---

## 🔗 References

* [Calico Cloud GKE Quickstart](https://docs.tigera.io/calico-cloud/get-started/gke)
* [Network Policy Tiers](https://docs.tigera.io/calico/latest/network-policy/tiered-policy)
* [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo)
* [Calico Cloud Documentation](https://docs.tigera.io/calico-cloud)
* [GKE Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy)

---

## 💡 FAQ & Support

> **Need help or stuck anywhere?**
>
> * [Troubleshooting Guide](./02-troubleshooting.md)
> * [FAQ](./04-faq.md)
> * Or ping your friendly Calico Cloud Solutions Architect!

---
