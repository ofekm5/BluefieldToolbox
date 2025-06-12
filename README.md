# 🔧 BluefieldToolbox

A practical set of tools and automation scripts for managing and configuring NVIDIA BlueField DPUs in lab and test environments. Designed to streamline common workflows like flashing, DOCA installation, DPU mode setup, and remote SSH provisioning.

> 📁 Note: `bf-bundle` files are excluded from this repo. Please download the latest BFB package from [NVIDIA's official site](https://network.nvidia.com/support/firmware/doca/) before using the flashing scripts.

---

## 📌 Key Features

- 🧠 **Ansible playbooks** for:
  - Flashing BlueField firmware (`flash_bfb.yml`)
  - Installing DOCA packages (`install_doca_all.yml`)
- 🖥️ **Uninstall scripts** and environment cleanup helpers
- 🧰 **Mode switching**: Activate DPU mode with `dpu_mode_setup.md`
- 🔐 **SSH automation**: Guide to setting up VSCode Remote-SSH for streamlined remote development
- ✅ Designed with **lab operators** and **infrastructure engineers** in mind

---

## 📁 Repo Structure

```text
.
├── ansible/
│   ├── flash_bfb.yml
│   ├── install_doca_all.yml
│   ├── uninstall_doca.sh
│   ├── inventory.ini
│   └── roles/                # (optional) for modular Ansible roles
│
├── pipelines/
│   └── doca-deploy-pipeline.yml   # GitHub Actions CI template
│
├── docs/
│   ├── dpu_mode_setup.md
│   ├── remote-ssh-setup.md
│   └── README.md                  # or keep main one in root
│
├── bfb/
│   └── bf-bundle-3.0.0-135_25.04.bfb (in .gitignore)
│
├── LICENSE
├── .gitignore
└── README.md

---

## 🚀 Usage Overview

### 1. 📦 Download BlueField BFB Firmware

> The `.bfb` file is not included in this repository.  
> Please download it from [NVIDIA DOCA Downloads](https://network.nvidia.com/support/firmware/doca/) and place it under `bfb-setup/`.

---

### 2. 💾 Flash the BlueField DPU

```bash
ansible-playbook bfb-setup/flash_bfb.yml -i inventory.ini

---

### 3. 🧠 Switch the DPU to DPU Mode

Follow the instructions in dpu_mode_setup.md.

---

### 4. 📥 Install DOCA SDK

```bash
ansible-playbook doca/install_doca_all.yml -i inventory.ini

---

### 5. 🔐 (Optional) Remote Development via VSCode
See remote-ssh-setup.md for connecting and coding directly on your VM or DPU.

---

### 6. 🔐 (Optional) Automated Build & Deployment (GitHub Actions)
Copy and Use doca-deploy-pipeline.yml for ease of use deployment with seamless compile and test procedures with an option for CI/CD setup.