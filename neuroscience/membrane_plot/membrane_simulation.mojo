from python import Python


fn main() raises:
    var np = Python.import_module("numpy")
    var brian2 = Python.import_module("brian2")
    var plt = Python.import_module("matplotlib.pyplot")

    brian2.prefs.get_preference("core.default_float_dtype").set_value("float64")
    print("Creating neuron model...")
    var eqs = """
    dv/dt = (I-v)/tau : volt
    I : volt
    tau : second
    """

    var G = brian2.NeuronGroup(
        100, eqs, threshold="v>-50*mV", reset="v=-60*mV", method="exact"
    )
    G.v = "-60*mV"
    G.I = "70*mV"  # Note: changed from G.i to G.I to match equation
    G.tau = "10*ms"  # Note: changed from G.v to G.tau

    # creating neuron group
    var M = brian2.StateMonitor(G, "v", record=True)

    print("Running simulation...")
    var net = brian2.Network(G, M)
    net.run("100*ms")

    print("Plot Results:")
    plt.figure(figsize=(10, 6))
    plt.plot(M.t / brian2.ms, M.v[0] / brian2.mV)
    plt.xlabel("Time(ms)")
    plt.ylabel("Membrane potential (mV)")
    plt.title("Neuron Membrane Potential")

    plt.savefig("membrane_sim.png")
    print("Plot saved as: membrane_sim.png")
