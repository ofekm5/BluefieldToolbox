# 🔧 VSCode Remote SSH Setup & Build Automation for DOCA App

This guide explains how to set up Visual Studio Code to connect to a remote Linux server for developing and compiling a DOCA application.

---

## ✅ Step 1: Install Required Extensions

1. Open VSCode
2. Go to **Extensions** (Ctrl+Shift+X)
3. Install:
   - **Remote - SSH** (by Microsoft)
   - (Optional) **C/C++** (for IntelliSense)
   - (Optional) **Docker** (for container integration)

---

## ✅ Step 2: Configure SSH Access

1. Ensure your local system can SSH to your remote host:
  ```bash
  ssh username@remote-vm-ip
  ```

2. In VSCode:

   * Open **Command Palette** (Ctrl+Shift+P)

   * Select `Remote-SSH: Add New SSH Host`

   * Paste:

     ```bash
     ssh username@remote-vm-ip
     ```

   * Save to `~/.ssh/config` when prompted (recommended)

---

## ✅ Step 3: Connect via Remote SSH

1. Open **Command Palette**
2. Select `Remote-SSH: Connect to Host`
3. Choose your added VM
4. VSCode will open a remote session

---

## ✅ Step 4: Project Folder and Workspace

* Clone your DOCA app repo with setup_git_and_clone.sh
* Open the folder from VSCode remote

---

## ✅ Step 5: Add `tasks.json` for Build Automation

Create a `.vscode/tasks.json` file inside your project:

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build DOCA App (Meson + Ninja)",
      "type": "shell",
      "command": "docker run --rm -v ${workspaceFolder}:/doca_devel -v /dev/hugepages:/dev/hugepages --privileged --net=host nvcr.io/nvidia/doca/doca:2.6.0-devel sh -c 'cd /doca_devel && meson /tmp/build -Denable_all_applications=false -Denable_simple_fwd_vnf=true && ninja -C /tmp/build'",
      "problemMatcher": [],
      "group": {
        "kind": "build",
        "isDefault": true
      }
    }
  ]
}
```

Then run it via:

* `Ctrl+Shift+P` → `Tasks: Run Task` → Select `"Build DOCA App (Meson + Ninja)"`

---