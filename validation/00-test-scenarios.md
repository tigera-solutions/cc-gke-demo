# 🧪 Policy Validation Test Scenarios

Welcome to your Calico Cloud GKE **Policy Test Suite!**

These test scenarios map directly to the `02-test-policies.sh` script and are designed to help you understand what’s being validated, why it matters, and what each result means for your environment.

---

## 🏁 How to Run These Tests

1. Deploy the TestPod (`netshoot` or `busybox`) using the provided script.
2. Get a shell inside the pod using `kubectl exec` (or run from your own machine if desired).
3. Run the `02-test-policies.sh` validation script.
4. Watch for ✅ (PASS) or ⛔ (FAIL) for each check.

---

## 🔍 Test Scenarios Explained

| Test # | Scenario                             | Command                                                                               | Expected Result                 | What It Proves                            |
| ------ | ------------------------------------ | ------------------------------------------------------------------------------------- | ------------------------------- | ----------------------------------------- |
| 1      | DNS Lookup (FQDN/egress DNS policy)  | `dig +short google.com`                                                               | PASS if DNS egress allowed      | Platform/Network DNS policy works         |
| 2      | HTTP Egress to Internet              | `curl -s --max-time 5 https://google.com`                                             | PASS if internet egress allowed | Egress policy working                     |
| 3      | ICMP Ping                            | `ping -c 1 -W 1 8.8.8.8`                                                              | FAIL unless ICMP is allowed     | ICMP/egress policy scope                  |
| 4      | LoadGen → Frontend                   | `curl -s --max-time 2 http://frontend:8080/`                                          | PASS if app policy allows       | Service-to-service microseg               |
| 5      | Frontend → ProductCatalogService     | `curl -s --max-time 2 http://productcatalogservice:3550/products`                     | PASS if app policy allows       | App-to-app microseg allowed               |
| 6      | TestPod → Online Boutique Frontend   | `curl -s --max-time 2 http://frontend.online-boutique.svc.cluster.local:8080/`        | FAIL if microseg working        | Namespace/label-based segmentation        |
| 7      | FQDN Egress (GitHub)                 | `curl -s --max-time 5 https://www.github.com`                                         | PASS/FAIL based on FQDN policy  | FQDN policy enforcement                   |
| 8      | Port-based Deny Test (to Google:443) | `curl -s --max-time 5 https://google.com:443`                                         | PASS/FAIL per port policy       | Port-based policy test                    |
| 9      | TestPod → PaymentService             | `curl -s --max-time 2 http://paymentservice.online-boutique.svc.cluster.local:50051/` | FAIL if default deny            | Deny by default—unintended access blocked |

---

## 💡 Tips & Best Practices

* **Run these tests before and after you apply your policies** to see real-time enforcement!
* Use `kubectl get networkpolicy -A` to list active policies across namespaces.
* You can test from any app pod (try from different namespaces for microsegmentation validation).
* Update or add tests based on your unique application flows or compliance requirements.

---

## 🧑‍💻 Next Steps

* If you see unexpected FAILs or PASSes, check the matching policy YAMLs in `manifests/02-calico-policies/`.
* [Calico Policy Docs](https://docs.tigera.io/calico/latest/network-policy/)
* Reach out in your team chat or to a Solutions Architect for help!

---

Enjoy exploring the power of Calico Cloud network policies! 🚀
