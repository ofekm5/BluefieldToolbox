## 🔧 Guide: Configuring BlueField-3 as a DPU (SoC Mode)

### 🧰 Requirements:
- You are connected via SSH to the **host system** (not to the BlueField Arm cores).
- `mstflint` tools are installed (`mst`, `mlxconfig`).
- The BlueField-3 card is properly recognized and bound.

---

### 1. ✅ Start the MST Service
This detects Mellanox devices and prepares them for configuration.

```bash
sudo mst start
```

You should see output like:
```
MST devices:
------------
/dev/mst/mt41692_pciconf0
```

---

### 2. 🛠️ Set Read/Write Permissions (Optional)

Make sure your user or automation tool can access the device node:
```bash
sudo chmod 666 /dev/mst/*
```

---

### 3. 🔄 Set SoC Mode Parameters

Enable the internal CPU (Arm cores) and configure it for SoC operation:
```bash
sudo mlxconfig -d /dev/mst/mt41692_pciconf0 set INTERNAL_CPU_MODEL=1
sudo mlxconfig -d /dev/mst/mt41692_pciconf0 set INTERNAL_CPU_OFFLOAD_ENGINE=0
sudo mlxconfig -d /dev/mst/mt41692_pciconf0 set INTERNAL_CPU_RSHIM=0
```

> 💡 If you're scripting: you can combine all into one `mlxconfig` command:
```bash
sudo mlxconfig -d /dev/mst/mt41692_pciconf0 set INTERNAL_CPU_MODEL=1 INTERNAL_CPU_OFFLOAD_ENGINE=0 INTERNAL_CPU_RSHIM=0
```

---

### 4. 🔍 Verify Settings

Run:
```bash
sudo mlxconfig -d /dev/mst/mt41692_pciconf0 q | grep INTERNAL_CPU
```

Expected output:
```
    INTERNAL_CPU_MODEL              EMBEDDED_CPU(1)
    INTERNAL_CPU_OFFLOAD_ENGINE    ENABLED(1)
    INTERNAL_CPU_RSHIM             ENABLED(1)
```

---

### 🧪 Optional Final Step: Reboot

Reboot the host machine to apply the changes cleanly:
```bash
sudo reboot
```
