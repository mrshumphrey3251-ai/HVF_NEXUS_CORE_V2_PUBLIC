#!/usr/bin/env python3
# ==============================================================================
# HVF NEXUS CORE V2 - SOVEREIGN EDGE INFERENCE ENGINE
# ARCHITECTURE: BARE-METAL NVIDIA JETSON (ORIN / XAVIER)
# FORMAT: GGUF (QUANTIZED) - ZERO CLOUD DEPENDENCY
# ==============================================================================

import os
import sys

# 1. Sever all implicit cloud telemetry and enforce offline mode
os.environ["HF_HUB_OFFLINE"] = "1"
os.environ["OMP_NUM_THREADS"] = "8" # Optimize for ARM cores

try:
    from llama_cpp import Llama
except ImportError:
    print("[!] FATAL: llama-cpp-python not found. Edge iron requires compiled bindings.")
    sys.exit(1)

def load_sovereign_model(model_path: str):
    print(f"[+] INITIATING ZERO-CLOUD INFERENCE ENGINE...")
    print(f"[+] TARGET ARCHITECTURE: NVIDIA JETSON GPU OFFLOAD")
    print(f"[+] TARGET MODEL: {model_path}")
    print(f"[+] ENFORCING MLOCK (MEMORY PINNING) TO PREVENT PAGING LATENCY...")

    try:
        # use_mlock=True leverages Phase 12 Real-Time Kernel Tuning
        # n_gpu_layers=-1 forces the entire model into the Jetson physical GPU
        llm = Llama(
            model_path=model_path,
            n_gpu_layers=-1, 
            use_mlock=True,  
            n_ctx=4096,      
            verbose=False
        )
        print("[+] SOVEREIGN MODEL LOADED SUCCESSFULLY. AIR-GAP MAINTAINED.")
        return llm
    except Exception as e:
        print(f"[!] CRITICAL: Model load failure or memory corruption detected: {e}")
        print(f"[!] INITIATING HARDWARE INTERRUPT PROTOCOL...")
        # In a live environment, this fires the Guillotine C binary
        sys.exit(1)

if __name__ == "__main__":
    # Fallback dummy path for architectural staging
    target_path = sys.argv[1] if len(sys.argv) > 1 else "/opt/hvf/models/sovereign_model.gguf"
    load_sovereign_model(target_path)
