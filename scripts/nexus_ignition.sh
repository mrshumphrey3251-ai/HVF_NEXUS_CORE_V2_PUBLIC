#!/usr/bin/env bash
# ==============================================================================
# HVF NEXUS CORE V2 - MASTER IGNITION SEQUENCE
# ARCHITECTURE: BARE-METAL NVIDIA JETSON
# TARGET: COLD-BOOT TO HARDWARE SOVEREIGNTY
# ==============================================================================

set -euo pipefail

echo "[+] ========================================================"
echo "[+] HVF NEXUS V2: INITIATING MASTER IGNITION SEQUENCE"
echo "[+] ========================================================"

# 1. Enforce Kernel Lockdown and Memory Pinning (Phase 12)
echo "[+] ENGAGING PHASE 12: REAL-TIME KERNEL LOCKDOWN..."
sudo bash ./scripts/rt_kernel_lockdown.sh

# 2. Execute Pre-Flight Hardware Fault Injection (Phase 15)
echo "[+] ENGAGING PHASE 15: PRE-FLIGHT FAULT INJECTION & GUILLOTINE TEST..."
bash ./tests/end_to_end_fault_injection.sh

# 3. Handover to Sovereign Inference Pipeline (Phase 13 & 14)
echo "[+] ========================================================"
echo "[+] HARDWARE DIAGNOSTICS PASSED. AIR-GAP CONFIRMED."
echo "[+] ENGAGING ZERO-CLOUD INFERENCE & ZERO-ACK DIODE PIPELINE."
echo "[+] ========================================================"

# Triggering initial healthy broadcast to seal the boot sequence
python3 ./src/pipeline/inference_diode_bridge.py "HVF_NODE_ONLINE_AND_SECURE"

echo "[+] ========================================================"
echo "[+] NEXUS CORE V2 IS ONLINE. SOVEREIGNTY ACHIEVED."
echo "[+] ========================================================"
