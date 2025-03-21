import numpy as np
import matplotlib.pyplot as plt
from brian2 import *

# Set up logging
import logging

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)


def run_simulation():
    logger.info("Starting Brian2 neural simulation")

    # Set Brian2 preferences
    prefs.codegen.target = "numpy"  # Use numpy for code generation
    defaultclock.dt = 0.01 * ms  # Set the simulation clock resolution

    # Print Brian2 information
    import brian2

    logger.info(f"Using Brian2 version: {brian2.__version__}")

    # Define the neuron model
    logger.info("Creating neuron model...")
    eqs = """
    dv/dt = (I-v)/tau : volt
    I : volt
    tau : second
    """

    # Create a group of neurons
    G = NeuronGroup(100, eqs, threshold="v>-50*mV", reset="v=-60*mV", method="exact")
    G.v = -60 * mV  # Initialize membrane potential
    G.I = 70 * mV  # Input current
    G.tau = 10 * ms  # Membrane time constant

    # Create a monitor to record membrane potentials
    M = StateMonitor(G, "v", record=True)

    # Create a spike monitor
    S = SpikeMonitor(G)

    # Run the simulation
    logger.info("Running simulation...")
    run(100 * ms)
    logger.info("Simulation completed")

    return M, S


def create_plots(M, S):
    logger.info("Creating plots...")

    # Create output directory if it doesn't exist
    import os

    os.makedirs("output", exist_ok=True)

    # Plot the results
    plt.figure(figsize=(12, 8))

    # Plot membrane potentials
    plt.subplot(211)
    for i in range(5):  # Plot first 5 neurons
        plt.plot(M.t / ms, M.v[i] / mV, label=f"Neuron {i}")
    plt.xlabel("Time (ms)")
    plt.ylabel("Membrane potential (mV)")
    plt.title("Neuron Membrane Potentials")
    plt.legend()

    # Plot spike raster
    plt.subplot(212)
    plt.plot(S.t / ms, S.i, ".k", markersize=2)
    plt.xlabel("Time (ms)")
    plt.ylabel("Neuron index")
    plt.title("Spike Raster Plot")

    plt.tight_layout()
    save_location = "lab_reports/images/membrane_sim.png"
    plt.savefig(save_location, dpi=300)
    logger.info("Plot saved as: ", save_location)

    # Display some statistics
    logger.info(f"Number of spikes: {len(S.i)}")
    if len(S.i) > 0:
        logger.info(f"Average firing rate: {len(S.i) / (100 * 0.1)} Hz")
    else:
        logger.info("No spikes detected")


def main():
    try:
        M, S = run_simulation()
        create_plots(M, S)
        logger.info("Simulation and plotting completed successfully")
    except Exception as e:
        logger.error(f"Error occurred: {str(e)}", exc_info=True)


if __name__ == "__main__":
    main()
