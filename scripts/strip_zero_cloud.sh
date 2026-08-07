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
# HVF NEXUS CORE V2 - ZERO-CLOUD OS HARDENING & STRIPPING MODULE
# ARCHITECTURE: BARE-METAL NVIDIA JETSON (ORIN / XAVIER)
# COMPATIBILITY: MANDATORY PARALLEL EXECUTION MATRIX (FUTURE-PROOFED V2+)
# ==============================================================================

set -euo pipefail

echo "[+] INITIALIZING ZERO-CLOUD STRIPPING SEQUENCE..."

# 1. Purge Cloud Telemetry & Unattended Network Callers
DEBIAN_FRONTEND=noninteractive sudo apt-get purge -y \
    cloud-init \
    ubuntu-report \
    popularity-contest \
    snapd \
    avahi-daemon \
    modemmanager \
    whoopsie \
    unattended-upgrades || true

# 2. Disable Systemd Resolver & DNS Leak Points
echo "[+] HARDENING SYSTEMD NETWORK RESOLUTION..."
sudo systemctl disable --now systemd-resolved.service || true
sudo systemctl mask systemd-resolved.service || true

# 3. Lock Down Sysctl Kernel Telemetry Parameters
cat << 'SYSCTL_EOF' | sudo tee /etc/sysctl.d/99-hvf-sovereign.conf
# HVF Sovereign Iron - Hardened Kernel Parameters
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.accept_source_route = 0
net.ipv6.conf.all.disable_ipv6 = 1
kernel.sysrq = 0
SYSCTL_EOF

sudo sysctl --system

# 4. Enforce Terminal Multi-User Mode (No GUI Overhead / Minimal Footprint)
sudo systemctl set-default multi-user.target

echo "[+] ZERO-CLOUD HARDENING COMPLETE. SYSTEM PREPARED FOR HARDWARE DIODE BINDING."
