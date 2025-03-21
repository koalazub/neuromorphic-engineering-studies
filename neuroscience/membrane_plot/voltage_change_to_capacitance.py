import matplotlib.pyplot as plt
import numpy as np
import os
from brian2 import *


def capacitance_variation_demo():
    prefs.codegen.target = "numpy"
    defaultclock.dt = 0.01 * ms

    os.makedirs("output", exist_ok=True)

    eqs = """
    dv/dt = I/C : volt
    I : amp
    C : farad
    """

    num_capacitances = 4
    membranes = NeuronGroup(num_capacitances, eqs, method="euler")

    membranes.v = 0 * mV
    membranes.I = 2 * nA

    capacitance_values = [0.5 * uF, 1 * uF, 2 * uF, 4 * uF]
    for i, cap in enumerate(capacitance_values):
        membranes.C[i] = cap

    M = StateMonitor(membranes, "v", record=True)

    run(50 * ms)

    plt.figure(figsize=(12, 8))

    # Calculate slopes without plotting the top graph
    slopes = []
    for i in range(num_capacitances):
        time_data = M.t / ms
        voltage_data = M.v[i] / mV
        slope, _ = np.polyfit(time_data, voltage_data, 1)
        slopes.append(slope)

    # Plot only the capacitance vs slope graph
    plt.subplot(111)  # Use the entire figure for one plot
    plt.plot([cap / uF for cap in capacitance_values], slopes, "o-")
    plt.xlabel("Capacitance (uF)")
    plt.ylabel("Voltage Slope (mV/ms)")
    plt.title("Slope of Voltage Change vs Capacitance")
    plt.grid(True)

    x_theory = np.linspace(0.4, 4.5, 100)
    scale_factor = slopes[0] * capacitance_values[0] / uF
    y_theory = scale_factor / x_theory
    plt.plot(x_theory, y_theory, "k--", label="1/C relationship")
    plt.legend()

    plt.tight_layout()
    save_location = "lab_reports/images/capacitance_variation.png"
    plt.savefig(save_location, dpi=300)

    print("\nResults:")
    print("Capacitance (uF) | Slope (mV/ms)")
    for i in range(num_capacitances):
        print(f"{capacitance_values[i] / uF:15.1f} | {slopes[i]:13.2f}")


if __name__ == "__main__":
    try:
        capacitance_variation_demo()
        print(
            "Simulation completed successfully. Plot saved to lab_reports/images/capacitance_variation.png"
        )
    except Exception as e:
        print(f"An error occurred: {e}")
