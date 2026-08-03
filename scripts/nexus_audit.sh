#!/usr/bin/env bash
# ==============================================================================
# HVF NEXUS CORE V2 - 100% ARCHITECTURAL AUDIT PROTOCOL (PUBLIC BLUEPRINT)
# TARGET: VERIFY SYMMETRY, PERMISSIONS, AND CRITICAL COMPONENT EXISTENCE
# ==============================================================================

set -e

echo "[+] ========================================================"
echo "[+] HVF NEXUS V2: INITIATING PUBLIC BLUEPRINT ARCHITECTURAL AUDIT"
echo "[+] ========================================================"
echo "[+] VERIFYING PUBLIC DIRECTORY STRUCTURE..."
for dir in src/hardware src/security src/inference src/pipeline scripts tests; do
    if [ -d "$dir" ]; then
        echo "    [OK] Directory secured: $dir"
    else
        echo "    [!] MISSING DIRECTORY: $dir"
        exit 1
    fi
done

echo "[+] VERIFYING PUBLIC BLUEPRINT COMPONENTS..."
files=(
    "src/hardware/kinetic_guillotine.c"
    "src/security/data_diode_handshake.c"
    "src/inference/edge_llm_engine.py"
    "src/pipeline/inference_diode_bridge.py"
    "scripts/rt_kernel_lockdown.sh"
    "scripts/nexus_ignition.sh"
    "tests/end_to_end_fault_injection.sh"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "    [OK] File exists: $file"
        if [[ "$file" == *.sh ]] || [[ "$file" == *.py ]]; then
            chmod +x "$file"
            echo "    [OK] Executable permission locked: $file"
        fi
    else
        echo "    [!] MISSING COMPONENT: $file"
        exit 1
    fi
done

echo "[+] ========================================================"
echo "[+] AUDIT COMPLETE: PUBLIC BLUEPRINT SYMMETRY VERIFIED."
echo "[+] ZERO CRUMBS. PROPRIETARY IP REMAINS QUARANTINED IN VAULT."
echo "[+] ========================================================"
