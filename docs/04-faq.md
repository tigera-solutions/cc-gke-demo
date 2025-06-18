# 💡 Calico Cloud GKE Demo: FAQ & Knowledge Hub

A friendly FAQ and resource hub for your demo adventure. Stuck? Confused? Start here!

---

## 🏢 GCP & GKE

<details>
<summary><b>How do I check my GCP Project ID?</b></summary>

> Your GCP Project ID is the unique identifier for your Google Cloud resources. It usually looks like <code>my-project-1234</code>.
> [How to find your Project ID (GCP Docs)](https://cloud.google.com/resource-manager/docs/creating-managing-projects#identifying_projects)

</details>

<details>
<summary><b>How do I enable GKE and create a cluster?</b></summary>

> You must enable the Kubernetes Engine API and have project permissions. You can create clusters via Cloud Console or Cloud Shell.
> [GKE Quickstart](https://cloud.google.com/kubernetes-engine/docs/quickstart)

</details>

<details>
<summary><b>What region/zone should I use?</b></summary>

> Use the region closest to you or your end users. See [GCP regions list](https://cloud.google.com/compute/docs/regions-zones) for details.

</details>

<details>
<summary><b>Why am I seeing “permission denied” or quota errors?</b></summary>

> You may need additional permissions, a billing account, or higher quotas. Try [checking IAM roles](https://cloud.google.com/iam/docs/understanding-roles) and your [resource quotas](https://cloud.google.com/compute/quotas).

</details>

---

## 🦈 Calico Cloud

<details>
<summary><b>What is Calico Cloud?</b></summary>

> Calico Cloud delivers cloud-native networking and security for Kubernetes and beyond. It’s built on open source Calico, but adds security, compliance, and visibility features.
> [What is Calico Cloud? (Official Docs)](https://docs.tigera.io/calico-cloud)

</details>

<details>
<summary><b>How do I connect my GKE cluster to Calico Cloud?</b></summary>

> After creating your cluster, follow the connect wizard in the Calico Cloud UI, or run the provided install command.
> [Connecting GKE to Calico Cloud](https://docs.tigera.io/calico-cloud/get-started/gke)

</details>

<details>
<summary><b>Is Calico Cloud free? What are the licensing details?</b></summary>

> Calico Cloud has a Free Tier for new signups, with full-featured trials.
> [Calico Cloud Pricing](https://www.calicocloud.io/pricing)

</details>

<details>
<summary><b>Where do I log in to the Calico Cloud UI?</b></summary>

> [Calico Cloud Login Portal](https://portal.calicocloud.io/)

</details>

---

## ☸️ Kubernetes Basics

<details>
<summary><b>What is a namespace?</b></summary>

> Namespaces are like folders for your Kubernetes resources. They help organize, isolate, and secure workloads.
> [Namespaces Explained](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

</details>

<details>
<summary><b>How do I switch my kubectl context?</b></summary>

> See your current context with <code>kubectl config current-context</code>, or change with <code>kubectl config use-context CONTEXT\_NAME</code>.
> [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

</details>

<details>
<summary><b>What if I don’t have kubectl or helm?</b></summary>

> Follow the install guides for [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) and [helm](https://helm.sh/docs/intro/install/). You may also use Google Cloud Shell, which has both pre-installed.

</details>

<details>
<summary><b>What is a pod?</b></summary>

> A pod is the smallest unit in Kubernetes—usually a single app container. Learn more about [Kubernetes pods](https://kubernetes.io/docs/concepts/workloads/pods/).

</details>

---

## 🧑‍💻 Demo Workflow & Troubleshooting

<details>
<summary><b>I get “permission denied” running a script. What should I do?</b></summary>

> Make sure the script is executable: <code>chmod +x scripts/my-script.sh</code>. Then re-run it.

</details>

<details>
<summary><b>How do I know if the Online Boutique frontend is accessible?</b></summary>

> Run <code>kubectl get svc frontend-external</code> and look for an <code>EXTERNAL-IP</code>. Paste that in your browser to access the app.
> [Online Boutique Troubleshooting](https://github.com/GoogleCloudPlatform/microservices-demo#troubleshooting)

</details>

<details>
<summary><b>What is the TestPod? Why do I need it?</b></summary>

> TestPod is a "jumpbox" in its own namespace. It lets you safely test connectivity (ping, curl, dig) and validate network policies *without* impacting the actual application. Great for learning or troubleshooting!

</details>

<details>
<summary><b>How do I clean up everything when I’m done?</b></summary>

> Run the cleanup script from the root of the repo: <code>./scripts/99-cleanup-all.sh</code>. You’ll be prompted before each destructive step!

</details>

---

## 🔗 References & Knowledge Base

See our [References page](../docs/references.md) for more deep dives:

* All Calico Cloud concepts touched in this demo
* GKE networking, permissions, pricing
* Kubernetes network policy, troubleshooting, and best practices

**Still stuck? [Open an issue](https://github.com/tigera-solutions/cc-demo-gke/issues) or ping your Solutions Architect for help!**

---

## 💬 More Questions?

* Want to see more tips? [Submit a FAQ question](https://github.com/tigera-solutions/cc-demo-gke/issues/new)
* Find a bug? Open a [GitHub Issue](https://github.com/tigera-solutions/cc-demo-gke/issues/new)
* Join the [Tigera Slack Community](https://join.slack.com/t/tigera/shared_invite/zt-1vnmky6cz-7FgIj2J4bAhiMhfnhDyE6A) for live chat!

---

# 🙌 Good luck, and have fun learning Calico Cloud! 🚀
