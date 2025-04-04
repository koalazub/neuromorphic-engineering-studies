# run this via python first - don't forget to convert to mojo later
import matplotlib.pyplot as plt
import matplotlib.font_manager
import matplotlib
import numpy as np
from neuron import h
import os

h.load_file("stdrun.hoc")  # needed via library to process neuron

matplotlib.rcParams["font.family"] = ["Jetbrains Mono"]

soma = h.Section(name="soma")
soma.L = 30  # μm - micrometres(don't forget μ == micro not nano)
soma.diam = 30  # μm
soma.insert("hh")  # Hodgkin-Huxley insertion

# Recording setup
t = h.Vector().record(h._ref_t)
v = h.Vector().record(soma(0.5)._ref_v)
ina = h.Vector().record(soma(0.5)._ref_ina)

stim = h.IClamp(soma(0.5))
# in milliseconds(ms)
stim.delay = 2
stim.dur = 0.1

stim.amp = 0.9  # in nA(nanoamps)

# params in milliseconds
h.tstop = 10
h.dt = 0.001

h.run()

times = np.array(t)
voltage = np.array(v)
na_current = np.array(ina)

plt.figure(figsize=(12, 8))

# Membrane potential plot to help visual how thresholds work and when the depolarisation kicks off
plt.subplot(2, 1, 1)
plt.plot(times, voltage, label="Membrane Potential", color="blue")
plt.axvline(x=stim.delay, color="red", linestyle="--", label="Stimulus Start")
plt.axvline(x=stim.delay + stim.dur, color="green", linestyle="--", label="Stimulus End")
plt.axhline(y=-55, color="orange", linestyle="--", label="Threshold Potential")
plt.title("Action Potential")
plt.ylabel("Membrane Potential (mV)")
plt.legend()

# Sodium plot
plt.subplot(2, 1, 2)
# triggering the stimulus when the first few NA channels create the feedback cycle
plt.plot(times, na_current, label="Sodium Current", color="purple") 
plt.axvline(x=stim.delay, color="red", linestyle="--", label="Stimulus Start")
plt.axvline(x=stim.delay + stim.dur, color="green", linestyle="--", label="Stimulus End")
plt.title("Sodium Current")
plt.xlabel("Time (ms)")
plt.ylabel("Current (nA)")
plt.legend()

# clean up, save etc.
save_directory = "./lab_reports/lab_2/"
os.makedirs(save_directory, exist_ok=True)
plt.tight_layout(rect=[0, 0.03, 1, 0.97])
plt.savefig(os.path.join(save_directory, "action_potential.svg"))
plt.show()

np.savetxt(
    os.path.join(save_directory, "action_potential.csv"), # may as well save the datapoints too
    np.column_stack((times, voltage, na_current)),
    delimiter=",",
    header="time(ms),voltage(mV),na_current(nA",
)
