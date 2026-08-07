#!/usr/bin/env bash
# ===========================================================================
# [HVF EXECUTIVE DISCLAIMER]
# PROPERTY OF HUMPHREY VIRTUAL FARM.
# EACH FILE IS ENTIRELY OF MY OWN DESIGN, CREATED WITHOUT PREVIOUS KNOWLEDGE OF, OR DERIVATION FROM, ANY OTHER WORK.
# PUBLIC DISCLOSURE OF THIS ARCHITECTURAL BLUEPRINT IS FOR DEMONSTRATION ONLY.
# THIS DOES NOT GRANT USAGE, MODIFICATION, OR DISTRIBUTION RIGHTS.
# UNAUTHORIZED REPLICATION OR COMMERCIAL DEPLOYMENT IS STRICTLY PROHIBITED.
# ===========================================================================

# ==============================================================================
# HVF NEXUS CORE V2 - REAL-TIME (PREEMPT_RT) KERNEL TUNING & MEMORY LOCKDOWN
# ARCHITECTURE: BARE-METAL NVIDIA JETSON (ORIN / XAVIER)
# TARGET: ZERO-JITTER THREAD EXECUTION & HARDWARE MEMORY PINNING
# ==============================================================================

set -euo pipefail

echo "[+] INITIATING REAL-TIME KERNEL TUNING & MEMORY LOCKDOWN..."

# 1. Disable Swap (Prevent memory paging latency)
echo "[+] DISABLING KERNEL SWAP SPACE..."
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 2. Enforce Max Performance CPU Governor
echo "[+] LOCKING CPU GOVERNOR TO MAXIMUM BARE-METAL PERFORMANCE..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo "performance" | sudo tee $cpu > /dev/null 2>&1 || true
done

# 3. Configure Real-Time Priority Limits for Security Threads
echo "[+] ASSIGNING UNLIMITED MEMLOCK AND RT_PRIORITY TO HARDWARE THREADS..."
cat << 'LIMITS_EOF' | sudo tee /etc/security/limits.d/99-hvf-realtime.conf
# HVF Sovereign Iron RT Limits
* hard memlock unlimited
* soft memlock unlimited
* hard rtprio 99
* soft rtprio 99
LIMITS_EOF

echo "[+] MEMORY PINNING & RT KERNEL TUNING COMPLETE."
