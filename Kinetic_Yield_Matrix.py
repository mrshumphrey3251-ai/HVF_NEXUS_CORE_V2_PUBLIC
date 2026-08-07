# [HVF PUBLIC DISCLOSURE] REDACTED EXECUTIVE BLUEPRINT - PROPRIETARY LOGIC SECURED
#!/usr/bin/env python3
import json
import os

def calculate_yield():
    print("\n======================================================")
    print(" HVF KINETIC YIELD MATRIX: EDGE COMPUTE REVENUE")
    print("======================================================")
    
    file_path = "biogas_telemetry.json"
    power_kw = 0.0
    
    if os.path.exists(file_path):
        with open(file_path, 'r') as f:
            data = json.load(f)
            power_kw = data.get("power_output_kw", 0.0)
    else:
        print("[!] ERROR: Telemetry bridge offline. Cannot calculate yield.")
        return

    # FINANCIAL MATRICES
    # 1 kW sustained for 24 hours = 24 kWh
    # Conservative Edge Compute Value: $0.18 per kWh
    
    kwh_per_day = power_kw * 24
    daily_revenue = kwh_per_day * 0.18
    annual_revenue = daily_revenue * 365
    
    print(f" [ACTIVE SOVEREIGN POWER] : {power_kw} kW")
    print(f" [24-HOUR CAPTURE]        : {kwh_per_day} kWh")
    print(f" [COMPUTE YIELD RATE]     : $0.18 / kWh")
    print("------------------------------------------------------")
    print(f" [GROSS DAILY YIELD]      : ${daily_revenue:.2f} USD")
    print(f" [PROJECTED ANNUAL YIELD] : ${annual_revenue:.2f} USD")
    print("======================================================\n")

if __name__ == "__main__":
    calculate_yield()
