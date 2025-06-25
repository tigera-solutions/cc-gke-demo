# 🧪 Policy Validation Test Scenarios

Welcome to your Calico Cloud GKE **Policy Test Suite!**

These scenarios directly map to your `01-validation.sh` script.  
**Run them before and after applying your Calico policies** to experience the “wow!” effect of Kubernetes-native segmentation, egress control, and application security.

---

## 🏁 How to Run These Tests

1. Open your terminal (Cloud Shell or local with `kubectl` access).
2. Ensure your Online Boutique app is running in the `online-boutique` namespace.
3. Copy and run the `validation/01-validation.sh` script from your project root.
4. Watch for ✅ (PASS) or ⛔ (FAIL) for each check.

---

## 🔍 Test Scenarios Explained

| Test # | Scenario                                       | Command                                                                                                         | Expected Result                    | What It Proves                                 |
|--------|------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|-------------------------------------|------------------------------------------------|
| 1      | DNS Lookup from LoadGenerator                  | `kubectl exec -n online-boutique deploy/loadgenerator -- nslookup google.com`                                   | PASS if DNS egress allowed         | Platform/Network DNS policy enforcement         |
| 2      | LoadGen → Frontend (service-to-service)        | `kubectl exec -n online-boutique deploy/loadgenerator -- curl -s --max-time 2 http://frontend:8080/`            | PASS if app policy allows           | Microsegmentation—service-to-service allowed    |
| 3      | Frontend → ProductCatalogService               | `kubectl exec -n online-boutique deploy/frontend -- curl -s --max-time 2 http://productcatalogservice:3550/products` | PASS if app policy allows      | App-to-app microsegmentation                    |
| 4      | PaymentService → Redis (should be blocked)     | `kubectl exec -n online-boutique deploy/paymentservice -- curl -s --max-time 2 redis-cart:6379`                 | FAIL if policy is enforced          | Zero Trust: default-deny/block between services |
| 5      | PaymentService egress to GitHub (FQDN)         | `kubectl exec -n online-boutique deploy/paymentservice -- curl -s --max-time 5 https://github.com`               | PASS if FQDN egress allowed         | Egress control—allow to specific external FQDN  |

---

## 💡 Tips & Best Practices

- **Run these tests _before and after_ you apply your policies**—you’ll see the difference immediately!
- Use `kubectl get networkpolicy,globalnetworkpolicy -A` to see active policies.
- Each test ties directly to a policy YAML in `manifests/01-calico-policies/`.
- Want to expand your validation? Add your own service-to-service or egress checks using `kubectl exec`.

---

## 🧑‍💻 Next Steps

- Unexpected results? Double-check the matching policy YAMLs and pod names.
- Read more: [Calico Network Policy Docs](https://docs.tigera.io/calico/latest/network-policy/)
- Need a hand? Ping your Solutions Architect or team Slack channel.

---

Enjoy discovering real security with Calico Cloud—**in minutes, not hours!** 🚀