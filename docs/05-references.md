# 📚 Reference Hub: Calico Cloud GKE PoC

> **Explore. Learn. Master.**  
> Everything you need to understand the *why*, *what*, and *how*—organized by topic.  
> New to Kubernetes, GKE, or Calico Cloud? These hand-picked links will make you a pro!

---

## 🏗️ Table of Contents

- [Calico Cloud Security](#calico-cloud-security)
- [Google Kubernetes Engine (GKE)](#google-kubernetes-engine-gke)
- [Kubernetes Basics](#kubernetes-basics)
- [DevOps & Tooling](#devops--tooling)
- [Extra Resources](#extra-resources)

---

## 🛡️ Calico Cloud Security

<details>
<summary><b>▶️ Click to Expand: Calico Cloud Concepts</b></summary>

| Concept           | Description                                 | Official Docs / Links |
|-------------------|---------------------------------------------|----------------------|
| **Network Policies**   | Control traffic to/from pods, services, namespaces.  | [Calico Policy Overview](https://docs.tigera.io/calico/latest/network-policy/) |
| **Tiered Policies**    | Layer security: Platform, Application, Security tiers | [Policy Tiers](https://docs.tigera.io/calico/latest/network-policy/tiered-policy) |
| **FQDN Policies**      | Control egress by FQDN (e.g., `github.com`) | [FQDN Egress Docs](https://docs.tigera.io/calico/latest/network-policy/host-endpoints#fqdn) |
| **Egress Controls**    | Limit/allow external connections        | [Egress Control](https://docs.tigera.io/calico/latest/network-policy/egress) |
| **Microsegmentation**  | Fine-grained service isolation          | [Microsegmentation Guide](https://docs.tigera.io/calico-cloud/use-cases/microsegmentation) |
| **Flow Logs & Observability** | Visualize and debug traffic flows | [Observability](https://docs.tigera.io/calico-cloud/observability) |
| **Calico Cloud UI**    | Your single pane for security & visibility | [Getting Started](https://docs.tigera.io/calico-cloud/get-started/cloud-ui) |

</details>

---

## ☁️ Google Kubernetes Engine (GKE)

<details>
<summary><b>▶️ Click to Expand: GKE Topics</b></summary>

| Concept                | Description                                | Official Docs / Links |
|------------------------|--------------------------------------------|----------------------|
| **GKE Quickstart**     | Create & manage clusters                   | [GKE Quickstart](https://cloud.google.com/kubernetes-engine/docs/quickstart) |
| **Network Policy in GKE** | Enable traffic controls                  | [Enable Network Policy](https://cloud.google.com/kubernetes-engine/docs/how-to/network-policy) |
| **GKE Pricing**        | Estimate your cost                         | [Pricing Calculator](https://cloud.google.com/products/calculator) |
| **Cluster Upgrades**   | Stay compatible with Calico Cloud          | [GKE Upgrades](https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-upgrades) |
| **Service Accounts & IAM** | Permissions to create/manage clusters  | [IAM Docs](https://cloud.google.com/iam/docs) |
| **Intra-Node Visibility** | Required for advanced observability      | [Enable Intra-Node Visibility](https://cloud.google.com/kubernetes-engine/docs/how-to/intra-node-visibility) |

</details>

---

## ☸️ Kubernetes Basics

<details>
<summary><b>▶️ Click to Expand: Kubernetes 101</b></summary>

| Concept         | Description                           | Official Docs / Links  |
|-----------------|---------------------------------------|------------------------|
| **Pods & Services**   | Core building blocks of every app | [Pods](https://kubernetes.io/docs/concepts/workloads/pods/), [Services](https://kubernetes.io/docs/concepts/services-networking/service/) |
| **Namespaces**        | Logical separation in clusters   | [Namespaces](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/) |
| **RBAC**              | Role-based access controls       | [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) |
| **kubectl CLI**       | Your command-line superpower     | [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/) |
| **Network Policies**  | Limit pod-to-pod traffic         | [K8s NetPol](https://kubernetes.io/docs/concepts/services-networking/network-policies/) |

</details>

---

## 🔧 DevOps & Tooling

<details>
<summary><b>▶️ Click to Expand: DevOps Tools</b></summary>

| Tool           | Description                           | Official Docs / Links  |
|----------------|---------------------------------------|------------------------|
| **kubectl**    | The Kubernetes command-line tool      | [Install kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) |
| **helm**       | Kubernetes package manager            | [Install Helm](https://helm.sh/docs/intro/install/) |
| **jq**         | JSON command-line processor           | [jq](https://stedolan.github.io/jq/) |
| **netshoot**   | Troubleshooting container/networking  | [netshoot on GitHub](https://github.com/nicolaka/netshoot) |
| **busybox**    | Minimal Linux for scripting/testing   | [busybox](https://busybox.net/) |

</details>

---

## 🌟 Extra Resources

<details>
<summary><b>▶️ Click to Expand: Blogs, Deep Dives & Videos</b></summary>

| Topic                 | Description                            | Link  |
|-----------------------|----------------------------------------|-------|
| **Calico Cloud Use Cases** | Customer stories, architectures    | [Use Cases](https://www.tigera.io/use-cases/) |
| **Tigera YouTube**         | Demos, deep dives, webinars         | [YouTube](https://www.youtube.com/c/TigeraInc) |
| **Calico Blog**            | News, tutorials, best practices     | [Blog](https://www.tigera.io/blog/) |
| **Kubernetes Official Docs** | The full story!                  | [K8s Docs](https://kubernetes.io/docs/home/) |

</details>

---

> 🦸 **Got stuck, want to suggest a link, or need a human touch?**  
> [Open an issue](https://github.com/tigera-solutions/cc-demo-gke/issues) or ping your Solutions Architect!

---

*Stay curious. Stay secure. Enjoy your Calico Cloud journey!* 🚀