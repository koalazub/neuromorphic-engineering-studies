import matplotlib.pyplot as plt
import numpy as np
import os
from brian2 import *


def capacitance_tau():
    prefs.codegen.target = "numpy"
    defaultclock.dt = 0.01 * ms

    os.makedirs("lab_reports/images", exist_ok=True)

    eqs = """
    dv/dt = (I - g_L*(v-E_L))/C : volt
    I : amp
    C : farad
    g_L : siemens
    E_L : volt
    """

    num_neurons = 4
    membranes = NeuronGroup(num_neurons, eqs, method="euler")

    membranes.v = -70 * mV
    membranes.I = 0.5 * nA
    membranes.g_L = 25 * nS
    membranes.E_L = -70 * mV

    capacitance_values = [0.5 * nF, 1 * nF, 2 * nF, 4 * nF]
    for i, cap in enumerate(capacitance_values):
        membranes.C[i] = cap

    tau_values = [cap / membranes.g_L[0] for cap in capacitance_values]

    M = StateMonitor(membranes, "v", record=True)

    run(50 * ms)
    membranes.I = 0.5 * nA
    run(450 * ms)

    plt.figure(figsize=(12, 8))

    colors = ["b", "g", "r", "c"]

    for i in range(num_neurons):
        plt.plot(
            M.t / ms,
            M.v[i] / mV,
            color=colors[i],
            label=f"C = {capacitance_values[i] / nF} nF, τ = {tau_values[i] / ms:.1f} ms",
        )

    plt.xlabel("Time (ms)")
    plt.ylabel("Membrane potential (mV)")
    plt.title("Effect of Membrane Capacitance on Time Constant (τ) and Steady State")
    plt.grid(True)
    plt.legend()

    plt.annotate(
        "Same steady state level",
        xy=(450, M.v[0][-1] / mV),
        xytext=(350, M.v[0][-1] / mV - 5),
        arrowprops=dict(arrowstyle="->"),
    )

    plt.tight_layout()
    save_location = "lab_reports/images/capacitance_tau.png"
    plt.savefig(save_location, dpi=300)

    print("\nResults:")
    print("Capacitance (nF) | Tau (ms) | Steady State (mV)")
    for i in range(num_neurons):
        print(
            f"{capacitance_values[i] / nF:15.1f} | {tau_values[i] / ms:8.1f} | {M.v[i][-1] / mV:16.2f}"
        )


if __name__ == "__main__":
    try:
        capacitance_tau()
        print(
            "Simulation completed successfully. Plot saved to lab_reports/images/capacitance_tau_demo.png"
        )
    except Exception as e:
        print(f"An error occurred: {e}")
