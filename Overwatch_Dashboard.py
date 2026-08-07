# [HVF PUBLIC DISCLOSURE] REDACTED EXECUTIVE BLUEPRINT - PROPRIETARY LOGIC SECURED
#!/usr/bin/env python3
import json
import os

def display_dashboard():
    file_path = "biogas_telemetry.json"
    print("\n======================================================")
    print(" HVF OVERWATCH: EXECUTIVE TELEMETRY DASHBOARD")
    print("======================================================")
    
    if not os.path.exists(file_path):
        print("[!] ERROR: Telemetry bridge severed. JSON file missing.")
        return

    with open(file_path, 'r') as f:
        data = json.load(f)

    print(f" [SYSTEM STATUS]     : {data.get('system_status', 'UNKNOWN')}")
    print(f" [POWER OUTPUT]      : {data.get('power_output_kw', 0)} kW (Sovereign)")
    print(f" [DIGESTER THERMAL]  : {data.get('digester_temp_c', 0)} C")
    print(f" [DOME PRESSURE]     : {data.get('dome_pressure_psi', 0)} PSI")
    print(f" [H2S TOXICITY]      : {data.get('h2s_ppm', 0)} PPM")
    print(f" [VFD AGITATOR RPM]  : {data.get('vfd_rpm_percent', 0)} %")
    print("======================================================\n")

if __name__ == "__main__":
    display_dashboard()
