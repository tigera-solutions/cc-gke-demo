# 🗂️ Calico Cloud GKE Demo Script Index

Welcome to the Calico Cloud GKE PoC demo! Here’s a quick reference for **all the scripts** you’ll use, their purpose, and the recommended order to run them.

---

| Order | Script Name                    | What It Does                                                    |
| ----- | ------------------------------ | --------------------------------------------------------------- |
| 1     | `01-setup-cluster.sh`          | Creates your GKE cluster, sets up all the basics for your demo. |
| 2     | `02-deploy-online-boutique.sh` | Deploys the Online Boutique demo app to your new cluster.       |
| 3     | `03-connect-calico-cloud.sh`   | Connects your GKE cluster to Calico Cloud (interactive).        |
| 4     | `04-create-tiers.sh`           | Creates Calico policy tiers for real-world, layered controls.   |
| 5     | `05-apply-policies.sh`         | Applies all demo Calico Network Policies, organized by tier.    |
| 6     | `validation/01-validation.sh`  | Validates/test connectivity before/after policies applied.      |
| 7     | `99-cleanup-all.sh`            | Cleans up everything: policies, app, cluster (with prompts).    |

---

## ✨ Pro Tips

* **Run scripts in order for the smoothest experience!**
* Every script explains what it’s doing (watch for color-coded echos).
* Validation can be run *before and after* applying policies for maximum wow-factor.
* If you need a step-by-step walkthrough, see the [Quickstart Guide](../docs/00-quickstart-guide.md).

---

**Happy Demoing!**
