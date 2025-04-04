import matplotlib.pyplot as plt
import numpy as np
from neuron import h
import textwrap

import os

h.load_file("stdrun.hoc")

fig = plt.figure(figsize=(15, 12))
q1 = fig.add_subplot(2, 2, 1)
q2 = fig.add_subplot(2, 2, 2)
q3 = fig.add_subplot(2, 2, 3)
q4 = fig.add_subplot(2, 2, 4)

diameters = [10, 30, 60]
lengths = [30, 30, 30]
colors = ["#1f77b4", "#ff7f0e", "#2ca02c"]

for i, (diam, length) in enumerate(zip(diameters, lengths)):
    soma = h.Section(name="soma")
    soma.L = length
    soma.diam = diam
    soma.insert("hh")
    t = h.Vector().record(h._ref_t)
    v = h.Vector().record(soma(0.5)._ref_v)
    stim = h.IClamp(soma(0.5))
    stim.delay, stim.dur, stim.amp = 2, 0.1, 0.9
    h.tstop, h.dt = 10, 0.001
    h.run()
    q1.plot(np.array(t), np.array(v), label=f"Diameter = {diam} μm", color=colors[i], linewidth=2)

q1.set_title("Cable Theory: Diameter Effects on Action Potential Timing")
q1.legend()

annotation_text = (
    r"increased diameter (→ larger $\lambda$) delays AP initiation but preserves HH dynamics."
    "\n"
    r"timing changes reflect capacitive loading ($\tau_m = r_m \cdot c_m$) without altering the mechanism."
) 

# shit like this is why I prefer rust
wrapped_text = textwrap.fill(annotation_text, width=80)

q1.annotate(
    wrapped_text,
    xy=(0.5, -0.25),
    xycoords="axes fraction",
    ha="center",
    fontsize=9,
    bbox=dict(boxstyle="round", fc="white", alpha=0.5),
)


diameters = [30, 30, 30]
lengths = [10, 30, 60]
for i, (diam, length) in enumerate(zip(diameters, lengths)):
    soma = h.Section(name="soma")
    soma.L = length
    soma.diam = diam
    soma.insert("hh")
    t = h.Vector().record(h._ref_t)
    v = h.Vector().record(soma(0.5)._ref_v)
    stim = h.IClamp(soma(0.5))
    stim.delay, stim.dur, stim.amp = 2, 0.1, 0.9
    h.tstop, h.dt = 10, 0.001
    h.run()
    q2.plot(np.array(t), np.array(v), label=f"Length = {length} μm", color=colors[i], linewidth=2)

q2.set_title("Membrane Area Effects on Action Potential Initiation")
q2.legend()
q2.annotate(
    "longer sections require more charge to reach threshold due to increased capacitance.\n"
    "action potential waveform remains invariant with only timing affected.",
    xy=(0.5, -0.25),
    xycoords="axes fraction",
    ha="center",
    fontsize=9,
    bbox=dict(boxstyle="round", fc="white", alpha=0.5),
)

diameters = [10, 30, 60]
lengths = [30, 30, 30]
for i, (diam, length) in enumerate(zip(diameters, lengths)):
    soma = h.Section(name="soma")
    soma.L = length
    soma.diam = diam
    soma.insert("hh")
    t = h.Vector().record(h._ref_t)
    ina = h.Vector().record(soma(0.5)._ref_ina)
    stim = h.IClamp(soma(0.5))
    stim.delay, stim.dur, stim.amp = 2, 0.1, 0.9
    h.tstop, h.dt = 10, 0.001
    h.run()
    q3.plot(np.array(t), np.array(ina), label=f"Diameter = {diam} μm", color=colors[i], linewidth=2)

q3.set_title("Patch Clamp Current Scaling with Diameter")
q3.legend()
q3.annotate(
    "current magnitude scales with membrane area, producing higher peak currents\n"
    "with larger diameters while preserving activation/inactivation.",
    xy=(0.5, -0.25),
    xycoords="axes fraction",
    ha="center",
    fontsize=9,
    bbox=dict(boxstyle="round", fc="white", alpha=0.5),
)

diameters = [30, 30, 30]
lengths = [10, 30, 60]
for i, (diam, length) in enumerate(zip(diameters, lengths)):
    soma = h.Section(name="soma")
    soma.L = length
    soma.diam = diam
    soma.insert("hh")
    t = h.Vector().record(h._ref_t)
    ina = h.Vector().record(soma(0.5)._ref_ina)
    stim = h.IClamp(soma(0.5))
    stim.delay, stim.dur, stim.amp = 2, 0.1, 0.9
    h.tstop, h.dt = 10, 0.001
    h.run()
    q4.plot(np.array(t), np.array(ina), label=f"Length = {length} μm", color=colors[i], linewidth=2)

q4.set_title("Length Effects on Current")
q4.legend()
q4.annotate(
    "increasing length affects axial resistance,\n"
    "with current spread altered without changes in activation thresholds.",
    xy=(0.5, -0.25),
    xycoords="axes fraction",
    ha="center",
    fontsize=9,
    bbox=dict(boxstyle="round", fc="white", alpha=0.5),
)

fig.suptitle(
    "Validating Cable Theory Predictions with Hodgkin-Huxley Model Simulations", fontsize=14
)
plt.tight_layout(rect=[0, 0.03, 1, 0.95])
save_directory = "./lab_reports/lab_2/"
os.makedirs(save_directory, exist_ok=True)
plt.savefig(os.path.join(save_directory, "theory_validation.svg"))
plt.show()
