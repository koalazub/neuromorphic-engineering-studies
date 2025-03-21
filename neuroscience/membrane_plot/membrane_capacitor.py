import matplotlib.pyplot as plt
import numpy as np
from brian2 import *


def membrane_capacitor_demo():
    prefs.codegen.target = "numpy"
    defaultclock.dt = 0.01 * ms

    # Mentioned in lecture 1 pg. 64
    # I = Amp
    # volt in V(or v)
    # C is capacitance which is measure in Farads(F)
    # and finally Time in t
    eqs = """
    dv/dt = I/C : volt
    I : amp
    C : farad
    """

    num_currents = 4
    membranes = NeuronGroup(num_currents, eqs, method="euler")

    membranes.v = 0 * mV
    membranes.C = 1 * uF

    current_amplitudes = [1 * nA, 2 * nA, 3 * nA, 4 * nA]
    for i, amp in enumerate(current_amplitudes):
        membranes.I[i] = amp

    M = StateMonitor(membranes, "v", record=True)

    run(50 * ms)

    plt.figure(figsize=(12, 8))

    plt.subplot(211)
    colors = ["b", "g", "r", "c"]
    slopes = []

    for i in range(num_currents):
        plt.plot(
            M.t / ms,
            M.v[i] / mV,
            color=colors[i],
            label=f"Current = {current_amplitudes[i] / nA} nA",
        )

        time_data = M.t / ms
        voltage_data = M.v[i] / mV
        slope, _ = np.polyfit(time_data, voltage_data, 1)
        slopes.append(slope)

    plt.xlabel("Time (ms)")
    plt.ylabel("Membrane potential (mV)")
    plt.title("Membrane Potential Changes for Different Current Amplitudes")
    plt.legend()

    plt.subplot(212)
    plt.plot([amp / nA for amp in current_amplitudes], slopes, "o-")
    plt.xlabel("Current Amplitude (nA)")
    plt.ylabel("Voltage Slope (mV/ms)")
    plt.title("Slope of Voltage Change vs Current Amplitude")
    plt.grid(True)

    plt.tight_layout()
    plt.savefig("./lab_reports/images/membrane_capacitance_demo.png", dpi=300)
    print("file saved at:", "./lab_reports/images/membrane_capacitance_demo.png")

    print("\nResults:")
    print("Current (nA) | Slope (mV/ms)")
    for i in range(num_currents):
        print(f"{current_amplitudes[i] / nA:11.1f} | {slopes[i]:13.2f}")


if __name__ == "__main__":
    membrane_capacitor_demo()
