## Welcome to the Cilium Role!

### Introduction

------

With this role, we install the network plugin ([CNI](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/)) Cilium.

It is necessary to have the [Helm module](https://docs.ansible.com/ansible/latest/collections/kubernetes/core/helm_module.html) from Ansible installed.

### Tasks

------

In this role, several tasks are performed, the most important ones are:

- Installation of **pip** to install the **PyYAML module** in order to use the **Helm** module in **Ansible**.
- Installation of Cilium using Helm.

### Variables

------

The most important variables in this role are:

- **cilium_version**: the Helm chart version of Cilium.
- **cilium_operator_replicas**: replicas of the Cilium operator.
- **cilium_pod_cidr**: internal network used by Cilium for the pods.
- **cilium_python_pyaml_module**: the version of the PyYAML module for Python (global variable).
- **cilium_kube_cli_user**: user used by Helm to add repositories (we use the variable from the kube_cli role).
