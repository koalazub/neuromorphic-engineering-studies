# how temperature affects action potentials
import matplotlib.pyplot as plt
import numpy as np
import os

from neuron import h

h.load_file("stdrun.hoc")

fig, ax = plt.subplots(figsize=(10, 6))

temperatures = [10, 20, 30, 40]
colors = ["blue", "green", "orange", "red"]

for i, (temp, color) in enumerate(zip(temperatures, colors)):
    soma = h.Section(name="soma")
    soma.L = 30  # μm
    soma.diam = 30
    soma.insert("hh")

    h.celsius = temp

    time = h.Vector().record(h._ref_t)
    voltage = h.Vector().record(soma(0.5)._ref_v)

    stim = h.IClamp(soma(0.5))
    # ms
    stim.delay = 2
    stim.dur = 0.1

    stim.amp = 0.9  # nA

    # ms
    h.tstop = 20
    h.dt = 0.025
    h.run()

    ax.plot(np.array(time), np.array(voltage), label=f"Temp = {temp}°C", color=color, linewidth=2)

ax.set_title("Effect of Temperature on Action Potential Duration")
ax.set_xlabel("Time (ms)")
ax.set_ylabel("Membrane Potential (mV)")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.7)


ax.annotate(
    "Higher temperatures → faster ion channel kinetics → shorter action potentials\n"
    "Lower temperatures → slower channel kinetics → longer action potentials",
    xy=(0.5, -0.2),
    xycoords="axes fraction",
    ha="center",
    fontsize=10,
    bbox=dict(boxstyle="round", fc="white", alpha=0.8),
)

plt.tight_layout()
save_directory = "./lab_reports/lab_2/"
os.makedirs(save_directory, exist_ok=True)
plt.savefig(os.path.join(save_directory, "temperature_affects_ap.svg"))
plt.show()
