# run this via python first - don't forget to convert to mojo later
import matplotlib.pyplot as plt
import numpy as np
from neuron import h
import os

h.load_file("stdrun.hoc")  # needed via library to process neuron

soma = h.Section(name="soma")
soma.L = 30  # μm - micrometres(don't forget μ == micro not nano)
soma.diam = 30  # μm
soma.insert("hh")  # Hodgkin-Huxley insertion

# Recording setup
t = h.Vector().record(h._ref_t)
v = h.Vector().record(soma(0.5)._ref_v)
ina = h.Vector().record(soma(0.5)._ref_ina)

# Stimulation
stim = h.IClamp(soma(0.5))
# in milliseconds(ms)
stim.delay = 2
stim.dur = 0.1

stim.amp = 0.9  # in nA(nano amps)

# params in milliseconds
h.tstop = 10
h.dt = 0.001

h.run()

times = np.array(t)
voltage = np.array(v)
na_current = np.array(ina)

plt.figure(figsize=(12, 6))

plt.subplot(2, 1, 1)
plt.plot(times, voltage)
plt.title("Action Potential")
plt.ylabel("Membrane Potential (mV)")

plt.subplot(2, 1, 2)
plt.plot(times, na_current)
plt.title("Sodium Current")
plt.xlabel("Time (ms)")
plt.ylabel("Current (nA)")
fig = plt.figure(figsize=(12, 6))

ax1 = plt.subplot(2, 1, 1)
ax1.plot(times, voltage)
ax1.set_title("Action Potential")
ax1.set_ylabel("Membrane Potential (mV)")

ax2 = plt.subplot(2, 1, 2)
ax2.plot(times, na_current)
ax2.set_title("Sodium Current")
ax2.set_xlabel("Time (ms)")
ax2.set_ylabel("Current (nA)")

footer_text = (
    "When voltage-gate Na⁺ channels open, this creates a rapid sodium ion influx. "
    "Causing the membrane potential to rise."
)  # footer to figure is better than plt.text() or whatever it's called

fig.text(
    0.5,  # x/y coords are normalised
    0.01,
    footer_text,
    ha="center",
    fontsize=10,
    wrap=True,
)

plt.tight_layout(rect=[0, 0.03, 1, 0.97])

save_directory = "./lab_reports/lab_2/"
os.makedirs(save_directory, exist_ok=True)
plt.savefig(os.path.join(save_directory, "action_potential.png"))
plt.show()

np.savetxt(
    os.path.join(save_directory, "q1_action_potential.csv"),
    np.column_stack((times, voltage, na_current)),
    delimiter=",",
    header="time(ms),voltage(mV),na_current(nA)",
)
