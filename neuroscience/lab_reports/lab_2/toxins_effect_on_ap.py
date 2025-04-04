# answer q5
import os
import textwrap

import matplotlib.pyplot as plt
import numpy as np
from neuron import h

h.load_file("stdrun.hoc")

fig, ax = plt.subplots(figsize=(10, 6))

conditions = ["Control", "TTX", "Anesthetics"]
colors = ["green", "blue", "red"]

for condition, color in zip(conditions, colors):
    soma = h.Section(name="soma")
    soma.L = 30  # μm
    soma.diam = 30
    soma.insert("hh")

    if condition == "TTX":
        for seg in soma:
            seg.hh.gnabar = 0
    elif condition == "Anesthetics":
        # block both na+ and k+ channels
        for seg in soma:
            seg.hh.gnabar = 0
            seg.hh.gkbar = 0

    time = h.Vector().record(h._ref_t)
    voltage = h.Vector().record(soma(0.5)._ref_v)

    stim = h.IClamp(soma(0.5))
    # ms
    stim.delay = 2
    stim.dur = 0.1
    stim.amp = 0.9  # nA

    h.tstop = 20  # ms
    h.dt = 0.025  # ms
    h.run()

    ax.plot(np.array(time), np.array(voltage), label=f"{condition}", color=color, linewidth=2)

ax.set_title("effectiveness of ttx vs anesthetics in blocking action potentials")
ax.set_xlabel("Time (ms)")
ax.set_ylabel("Membrane Potential (mV)")
ax.legend()
ax.grid(True, linestyle="--", alpha=0.7)
annotation_text = textwrap.fill(
    "By selectively eliminating this essential component while preserving repolarisation mechanisms, TTX achieves action potential blockade with minimal collateral effects on membrane function, making it the more effective and specific blocking agent.",
    width=80,
)

ax.annotate(
    annotation_text,
    xy=(0.5, -0.45),
    xycoords="axes fraction",
    ha="center",
    fontsize=10,
    bbox=dict(boxstyle="round", fc="white", alpha=0.8),
)


plt.tight_layout(rect=[0, 0.1, 1, 0.95])
save_directory = "./lab_reports/lab_2/"
os.makedirs(save_directory, exist_ok=True)
plt.savefig(os.path.join(save_directory, "toxins_effect_on_ap.svg"))
plt.show()
