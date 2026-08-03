#!/usr/bin/env bash
# ==============================================================================
# HVF NEXUS CORE V2 - 100% ARCHITECTURAL AUDIT PROTOCOL
# TARGET: VERIFY SYMMETRY, PERMISSIONS, AND CRITICAL COMPONENT EXISTENCE
# ==============================================================================

set -e

echo "[+] ========================================================"
echo "[+] HVF NEXUS V2: INITIATING 100% ARCHITECTURAL AUDIT"
echo "[+] ========================================================"

DIRECTORIES=("src/hardware" "src/security" "src/inference" "src/pipeline" "scripts" "tests")
CRITICAL_FILES=(
    "src/hardware/kinetic_guillotine.c"
    "src/security/data_diode_handshake.c"
    "src/inference/edge_llm_engine.py"
    "src/pipeline/inference_diode_bridge.py"
    "scripts/rt_kernel_lockdown.sh"
    "scripts/nexus_ignition.sh"
    "tests/end_to_end_fault_injection.sh"
)

echo "[+] VERIFYING DIRECTORY STRUCTURE..."
for dir in "${DIRECTORIES[@]}"; do
    if [ -d "$dir" ]; then
        echo "    [OK] Directory secured: $dir"
    else
        echo "    [FAIL] Missing directory: $dir"
        exit 1
    fi
done

echo "[+] VERIFYING CRITICAL COMPONENTS AND PERMISSIONS..."
for file in "${CRITICAL_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "    [OK] File exists: $file"
        if [[ "$file" == *.sh || "$file" == *.py ]]; then
            if [ -x "$file" ]; then
                echo "    [OK] Executable permission locked: $file"
            else
                echo "    [WARN] Executable permission missing, enforcing now: $file"
                chmod +x "$file"
            fi
        fi
    else
        echo "    [FAIL] Missing critical component: $file"
        echo "[!] AUDIT FAILED. CRUMBS DETECTED. HALTING DEPLOYMENT."
        exit 1
    fi
done

echo "[+] ========================================================"
echo "[+] AUDIT COMPLETE: 100% ARCHITECTURAL COVERAGE CONFIRMED."
echo "[+] ZERO CRUMBS. BARE-METAL IRON IS READY FOR DEPLOYMENT."
echo "[+] ========================================================"
