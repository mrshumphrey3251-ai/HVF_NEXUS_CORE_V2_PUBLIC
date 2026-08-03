#!/usr/bin/env python3
# ==============================================================================
# HVF NEXUS CORE V2 - INFERENCE TO DIODE PIPELINE BRIDGE
# ARCHITECTURE: BARE-METAL EDGE PIPELINE (NVIDIA JETSON)
# SECURITY: AUTOMATIC HARDWARE GUILLOTINE TRIP ON PIPELINE CORRUPTION
# ==============================================================================

import os
import sys
import subprocess

DIODE_ENGINE_PATH = os.path.expanduser("~/HVF_NEXUS_CORE_V2_PUBLIC/src/security/data_diode_engine")
GUILLOTINE_DRIVER_PATH = os.path.expanduser("~/HVF_NEXUS_CORE_V2_PUBLIC/src/hardware/kinetic_guillotine_driver")

def stream_to_diode(payload_text: str):
    """
    Pipes sovereign AI model outputs directly to the bare-metal C data diode engine.
    If transmission or execution fails, triggers sub-millisecond hardware circuit severing.
    """
    print(f"[+] PIPELINE BRIDGE: RECEIVING MODEL OUTPUT ({len(payload_text)} bytes)")
    
    if not os.path.exists(DIODE_ENGINE_PATH):
        print(f"[!] CRITICAL: Data Diode binary not found at {DIODE_ENGINE_PATH}")
        trigger_hardware_guillotine()
        return False

    try:
        # Execute C binary with payload via zero-ack diode transmitter
        result = subprocess.run(
            [DIODE_ENGINE_PATH, payload_text],
            capture_output=True,
            text=True,
            timeout=2.0
        )
        if result.returncode == 0:
            print("[+] DATA DIODE TRANSMISSION SUCCESSFUL:")
            print(result.stdout.strip())
            return True
        else:
            print(f"[!] DATA DIODE ENGINE RETURNED ERROR: {result.stderr}")
            trigger_hardware_guillotine()
            return False
            
    except Exception as e:
        print(f"[!] PIPELINE FAILURE DETECTED: {e}")
        trigger_hardware_guillotine()
        return False

def trigger_hardware_guillotine():
    print("[!] INITIATING SUB-MILLISECOND HARDWARE GUILLOTINE TRIP...")
    if os.path.exists(GUILLOTINE_DRIVER_PATH):
        subprocess.run([GUILLOTINE_DRIVER_PATH, "--TRIP"])
    else:
        print(f"[!] FATAL: Guillotine driver binary missing at {GUILLOTINE_DRIVER_PATH}")
    sys.exit(1)

if __name__ == "__main__":
    sample_payload = sys.argv[1] if len(sys.argv) > 1 else "HVF_SOVEREIGN_NODE_01_STATUS_HEALTHY"
    stream_to_diode(sample_payload)
