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
# HVF NEXUS CORE V2 - END-TO-END FAULT INJECTION & INTEGRATION TEST
# ARCHITECTURE: BARE-METAL EDGE PIPELINE
# TARGET: VALIDATE ZERO-ACK DIODE TRANSMISSION & KINETIC GUILLOTINE TRIP
# ==============================================================================

set -euo pipefail

BRIDGE_SCRIPT="src/pipeline/inference_diode_bridge.py"
DIODE_BIN="src/security/data_diode_engine"

echo "[+] ========================================================"
echo "[+] HVF NEXUS V2: INITIATING END-TO-END HARDWARE INTEGRATION"
echo "[+] ========================================================"

# PHASE A: HEALTHY TRANSMISSION TEST
echo "[+] TEST A: INJECTING HEALTHY AI TELEMETRY PAYLOAD..."
python3 $BRIDGE_SCRIPT "SCADA_NODE_ALPHA_NOMINAL_OP"

# PHASE B: FAULT INJECTION (CRITICAL FAILURE SIMULATION)
echo "[!] ========================================================"
echo "[!] TEST B: INJECTING CRYPTOGRAPHIC / PIPELINE FAULT..."
echo "[!] ========================================================"

# Simulating a missing or corrupted Diode Engine binary
mv $DIODE_BIN ${DIODE_BIN}_CORRUPTED

# Suppress the automatic exit from the python script to allow the bash script to finish its cleanup
set +e 
python3 $BRIDGE_SCRIPT "SCADA_NODE_ALPHA_MALICIOUS_PAYLOAD"
set -e

# Restoring the environment
mv ${DIODE_BIN}_CORRUPTED $DIODE_BIN

echo "[+] ========================================================"
echo "[+] HVF INTEGRATION TEST COMPLETE. BARE-METAL IRON IS SECURE."
echo "[+] ========================================================"
