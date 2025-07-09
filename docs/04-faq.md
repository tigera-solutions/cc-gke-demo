# 🦈 Calico Cloud EKS Demo: FAQ & Knowledge Hub

A friendly FAQ and resource hub for your demo adventure. Stuck? Confused? Start here! 🚦

---

## ☁️ AWS & EKS

<details>
<summary><b>🔎 How do I check my AWS Account ID or default region?</b></summary>

> Your AWS Account ID is a 12-digit number visible in the [AWS Console](https://console.aws.amazon.com/) under your account menu.
> To check your default region, run: <code>aws configure get region</code>

</details>

<details>
<summary><b>🚀 How do I create an EKS cluster?</b></summary>

> Use the automated scripts in this repo, or run: <code>eksctl create cluster --name my-demo --region us-west-2 --nodes 3 --node-type t3.large</code>
> See the [EKS Quickstart](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html) for details.

</details>

<details>
<summary><b>🌎 What region should I use?</b></summary>

> Use any AWS region close to you or your users. See [AWS region list](https://docs.aws.amazon.com/general/latest/gr/rande.html) for options.

</details>

<details>
<summary><b>🔒 Why am I seeing “permission denied” or AWS errors?</b></summary>

> Ensure your IAM user/role has permissions to create EKS clusters, VPCs, and node groups. Also, check that your AWS credentials are configured with <code>aws configure</code>.

</details>

---

## ☁️ Calico Cloud

<details>
<summary><b>🦈 What is Calico Cloud?</b></summary>

> Calico Cloud delivers cloud-native networking and security for Kubernetes and beyond. It’s built on open source Calico, but adds advanced security, compliance, and observability features.
> [What is Calico Cloud? (Docs)](https://docs.tigera.io/calico-cloud)

</details>

<details>
<summary><b>🔗 How do I connect my EKS cluster to Calico Cloud?</b></summary>

> After creating your EKS cluster, use the connect wizard in the Calico Cloud UI or run the provided install command.
> [Connecting EKS to Calico Cloud](https://docs.tigera.io/calico-cloud/get-started/eks)

</details>

<details>
<summary><b>💸 Is Calico Cloud free? What are the licensing details?</b></summary>

> Calico Cloud has a free trial for new users with full-featured access.
> [Calico Cloud Pricing](https://www.calicocloud.io/pricing)

</details>

<details>
<summary><b>🔑 Where do I log in to the Calico Cloud UI?</b></summary>

> [Calico Cloud Login Portal](https://portal.calicocloud.io/)

</details>

---

## ☸️ Kubernetes Basics

<details>
<summary><b>📂 What is a namespace?</b></summary>

> Namespaces are like folders for your Kubernetes resources. They help organize, isolate, and secure workloads.
> [Namespaces Explained](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)

</details>

<details>
<summary><b>🔄 How do I switch my kubectl context?</b></summary>

> See your current context with <code>kubectl config current-context</code>, or change with <code>kubectl config use-context CONTEXT\_NAME</code>.
> [kubectl Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

</details>

<details>
<summary><b>⚙️ What if I don’t have kubectl, eksctl, or helm?</b></summary>

> Just run the provided <code>scripts/01\_prereqs.sh</code> from this repo! It checks and installs everything needed.

</details>

<details>
<summary><b>🧩 What is a pod?</b></summary>

> A pod is the smallest unit in Kubernetes—usually a single app container. Learn more about [Kubernetes pods](https://kubernetes.io/docs/concepts/workloads/pods/).

</details>

---

## 🧑‍💻 Demo Workflow & Troubleshooting

<details>
<summary><b>⛔ I get “permission denied” running a script. What should I do?</b></summary>

> Make sure the script is executable: <code>chmod +x scripts/my-script.sh</code>. Then re-run it.

</details>

<details>
<summary><b>🌐 How do I know if the Online Boutique frontend is accessible?</b></summary>

> Run <code>kubectl get svc frontend-external -n online-boutique</code> and look for an <code>EXTERNAL-IP</code>. Paste that in your browser to access the app.

</details>

<details>
<summary><b>🛠️ What is the TestPod? Why do I need it?</b></summary>

> TestPod is a "jumpbox" in its own namespace. It lets you safely test connectivity (ping, curl, dig) and validate network policies without impacting the actual application. Great for troubleshooting!

</details>

<details>
<summary><b>🧹 How do I clean up everything when I’m done?</b></summary>

> Run the cleanup script from the root of the repo: <code>bash scripts/99\_cleanup.sh</code>. You’ll be prompted before any destructive step.

</details>

---

## 📚 References & Knowledge Base

See our [References page](../references.md) for more deep dives:

* All Calico Cloud concepts touched in this demo
* EKS networking, IAM, permissions, and pricing
* Kubernetes network policy, troubleshooting, and best practices

Still stuck? [Open an issue](https://github.com/tigera-solutions/cc-eks-demo/issues) or ping your Solutions Architect for help!

---

## 💬 More Questions?

* Want more tips? [Submit a FAQ question](https://github.com/tigera-solutions/cc-eks-demo/issues/new)
* Find a bug? Open a [GitHub Issue](https://github.com/tigera-solutions/cc-eks-demo/issues/new)
* Join the [Calico Slack Community](https://calicousers.slack.com/join/shared_invite/zt-37ubh3jjr-VPzDmJD50esVklfNR9pGeQ#/shared-invite/email) for live chat!

---

🎉 Good luck, and enjoy learning Calico Cloud with EKS! 🚀
