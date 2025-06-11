# 🎉 Welcome to Kubernetes Vagrant! :wheel_of_dharma:

## 🚀 Introduction

This repository was created to help you easily test **Kubernetes** in a Vagrant environment. It's perfect for experimenting with Kubernetes clusters and learning about orchestration in a reproducible, isolated setup.

**Overview:**  
By default, this setup deploys:

- Kubernetes (latest stable version)
- All required dependencies for a minimal cluster

You can extend this environment to test your own manifests, Helm charts, or Kubernetes-based applications.

Provisioning is automated using Vagrant, ensuring that the deployment and configuration of Kubernetes is smooth and repeatable.

For more information about Kubernetes, check the [official Kubernetes website](https://kubernetes.io/).

## 🛠️ Compatibility

This repository uses the latest stable versions by default. You can change the version by modifying the provisioning scripts or `Vagrantfile`.

> **Note:** Kubernetes is configured with a default network. You can customize networking as needed.

## 🔐 Credentials

To access the virtual machine via SSH, use the default Vagrant credentials:

| User    | Password |
| ------- | -------- |
| vagrant | vagrant  |

## 🏁 Getting Started

### Prerequisites

Before you can get started, you'll need to install the following software:

- **Vagrant:** [Download here](https://www.vagrantup.com/downloads.html) 🛠️
- **VirtualBox:** [Download here](https://www.virtualbox.org/wiki/Downloads) 💻

### 💻 Up and SSH

#### Install Git

Depending on your operating system, follow these steps to install Git:

- **Linux 🐧**

  For Ubuntu/Debian:
  ```bash
  sudo apt -y install git
  ```

  For CentOS/RedHat:
  ```bash
  sudo yum -y install git
  ```

  Then, clone the repository:
  ```bash
  git clone https://github.com/rdrgporto/kubernetes-vagrant.git
  ```

- **Windows 🏁**

  Download and install [Git Bash](https://gitforwindows.org/), then run:
  ```bash
  git clone https://github.com/rdrgporto/kubernetes-vagrant.git
  ```

### 🚀 Running Vagrant

Vagrant is configured with both internal and public network options. You can use the public network to log in via any SSH client like [Putty](https://www.putty.org/), [MobaXterm](https://mobaxterm.mobatek.net/), or [Termius](https://www.termius.com/).

To start the virtual machine:

- **Linux/MacOS:**
  ```bash
  cd /path/to/your/kubernetes-vagrant/
  vagrant up
  ```

- **Windows:**  
  Open Git Bash or Command Prompt and navigate to the project folder:
  ```bash
  cd C:/path/to/your/kubernetes-vagrant/
  vagrant.exe up
  ```

Once it's up and running, you can log in via SSH:

- **Linux/MacOS:**
  ```bash
  vagrant ssh
  ```

- **Windows:**  
  Using Git Bash or Command Prompt:
  ```bash
  vagrant.exe ssh
  ```

## 🔄 Common Vagrant Commands

Here are some useful Vagrant commands to manage your virtual machine:

- **Linux/MacOS:**
  ```bash
  vagrant up        # Start the virtual machine
  vagrant destroy   # Remove/delete the virtual machine
  vagrant ssh       # Connect to the virtual machine via SSH
  vagrant halt      # Shutdown the virtual machine
  vagrant provision # Re-run provisioning scripts
  ```

- **Windows (using Git Bash or Command Prompt):**
  ```bash
  vagrant.exe up        # Start the virtual machine
  vagrant.exe destroy   # Remove/delete the virtual machine
  vagrant.exe ssh       # Connect to the virtual machine via SSH
  vagrant.exe halt      # Shutdown the virtual machine
  vagrant.exe provision # Re-run provisioning scripts
  ```

## 🤝 Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve this project. Let's make testing with Kubernetes easier together! 💡

## 📄 License

This project is licensed under the Apache License 2.0. See the LICENSE file for more details.
