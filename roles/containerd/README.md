Docker
=========

Install **Containerd** in Ubuntu.

Requirements
------------

Prerequisites:

- Ubuntu

Variables
--------------

| containerd_version | Version of Containerd |
| -------------- | ----------------------------------------- |

Example Playbook
----------------

```yaml
---
- name: Install Containerd
  hosts: all
  become: true
  become_user: root
  roles:
    - containerd
```

License
-------

Apache-2.0
