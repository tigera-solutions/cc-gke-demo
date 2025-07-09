# 🚦 Calico Cloud + GKE Demo Cheat Sheet

Your quick reference for cluster basics, Calico, app validation, and troubleshooting—no guesswork, just results!

---

## 🏗️ Cluster & Node Info

List all nodes in your cluster:

```
kubectl get nodes
```

List all namespaces:

```
kubectl get ns
```

View available kubeconfig contexts:

```
kubectl config get-contexts
```

Show your current kubeconfig context:

```
kubectl config current-context
```

Basic cluster info (API endpoints, DNS, etc):

```
kubectl cluster-info
```

---

## 📦 Pods, Services, Deployments

Show all pods in all namespaces:

```
kubectl get pods -A
```

List all pods in the Online Boutique namespace:

```
kubectl get pods -n online-boutique
```

See all services in Online Boutique:

```
kubectl get svc -n online-boutique
```

Show details about a specific pod:

```
kubectl describe pod <pod> -n online-boutique
```

View logs from a pod (replace <pod> with name):

```
kubectl logs <pod> -n online-boutique
```

---

## 🛡️ Calico Policies (GlobalNetworkPolicy)

List all Calico GlobalNetworkPolicies:

```
kubectl get globalnetworkpolicy
```

Show details about a specific policy:

```
kubectl describe globalnetworkpolicy <policy-name>
```

See all Calico policy tiers:

```
kubectl get tier
```

Show all Calico policies as YAML:

```
kubectl get globalnetworkpolicy -o yaml
```

---

## 🛒 Online Boutique Namespace

See all resources (pods, services, deployments) in the app namespace:

```
kubectl get all -n online-boutique
```

---

## 🧪 Validation & Pod Exec Examples

DNS lookup from the frontend pod:

```
kubectl exec -n online-boutique deploy/frontend -- nslookup google.com
```

Test connectivity from loadgenerator to frontend:

```
kubectl exec -n online-boutique deploy/loadgenerator -- curl -s http://frontend:8080/
```

Frontend calls ProductCatalogService:

```
kubectl exec -n online-boutique deploy/frontend -- curl -s http://productcatalogservice:3550/products
```

PaymentService to GitHub egress test:

```
kubectl exec -n online-boutique deploy/paymentservice -- curl -s https://github.com
```

---

## 🛠️ Common Troubleshooting

See all Kubernetes events for issues:

```
kubectl get events -A
```

Describe a node for deeper diagnostics:

```
kubectl describe node <node>
```

Get pod status, node placement, and pod IPs:

```
kubectl get pods -A -o wide
```

See full YAML for a pod:

```
kubectl get pod <pod> -n online-boutique -o yaml
```

---

## 🧹 Cleanup

Nuke your cluster, app, policies, and optionally this folder:

```
./scripts/99-cleanup-all.sh
```

---

## 💡 Handy Tips

* Use tab completion! Type `kubectl get` + <tab><tab> to see all resources.
* Try `kubectl explain <resource>` for more info (e.g. `kubectl explain pod`)
* Policy didn’t work? Try `kubectl describe globalnetworkpolicy <name>`

---

## 📝 More Resources

* [Calico Policy Docs](https://docs.tigera.io/calico/latest/network-policy/)
* [Kubernetes CLI Docs](https://kubernetes.io/docs/reference/kubectl/)
