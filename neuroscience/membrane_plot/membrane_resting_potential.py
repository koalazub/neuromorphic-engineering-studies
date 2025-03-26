import matplotlib.pyplot as plt
import numpy as np
import os
from brian2 import *


def resting_potential_demo():
    prefs.codegen.target = "numpy"
    defaultclock.dt = 0.01 * ms

    os.makedirs("lab_reports/images", exist_ok=True)

    eqs = """
    dv/dt = I/C : volt
    I : amp
    C : farad
    """

    num_neurons = 3
    membranes = NeuronGroup(num_neurons, eqs, method="euler")

    resting_potentials = [-70 * mV, -50 * mV, -30 * mV]
    for i, v_rest in enumerate(resting_potentials):
        membranes.v[i] = v_rest

    membranes.C = 1 * uF
    membranes.I = 2 * nA

    M = StateMonitor(membranes, "v", record=True)

    run(50 * ms)

    plt.figure(figsize=(10, 6))

    colors = ["b", "g", "r"]
    slopes = []

    for i in range(num_neurons):
        time_data = M.t / ms
        voltage_data = M.v[i] / mV

        slope, intercept = np.polyfit(time_data, voltage_data, 1)
        slopes.append(slope)

        plt.plot(
            time_data,
            voltage_data,
            color=colors[i],
            label=f"Resting potential = {resting_potentials[i] / mV} mV (slope = {slope:.2f} mV/ms)",
        )

    plt.xlabel("Time (ms)")
    plt.ylabel("Membrane potential (mV)")
    plt.title("Effect of Resting Potential on Voltage Ramp")
    plt.grid(True)
    plt.legend()

    plt.tight_layout()
    save_location = "lab_reports/images/resting_potential.png"
    plt.savefig(save_location, dpi=300)

    print("\nResults:")
    print("Resting Potential (mV) | Slope (mV/ms)")
    for i in range(num_neurons):
        print(f"{resting_potentials[i] / mV:20.1f} | {slopes[i]:13.2f}")

    slope_differences = [abs(slopes[0] - slope) for slope in slopes[1:]]
    if all(diff < 1e-10 for diff in slope_differences):
        print("\nAll slopes are identical regardless of resting potential.")
    else:
        print("\nSlopes vary slightly due to numerical precision.")


if __name__ == "__main__":
    try:
        resting_potential_demo()
        print(
            "Simulation completed successfully. Plot saved to lab_reports/images/resting_potential_demo.png"
        )
    except Exception as e:
        print(f"An error occurred: {e}")
