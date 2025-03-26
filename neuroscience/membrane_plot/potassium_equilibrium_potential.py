import matplotlib.pyplot as plt
import numpy as np
import os


def potassium_equilibrium_plot():
    os.makedirs("lab_reports/images", exist_ok=True)

    R_gas_constant = 8.314
    F_faraday = 96485.3329
    z_valence = 1

    T_room = 293.15
    T_mammal = 310.15

    k_in = 5
    k_out_values = np.logspace(-1, 3, 1000)

    def nernst_equation(k_out, k_in, temp):
        return (
            ((R_gas_constant * temp) / (z_valence * F_faraday))
            * np.log(k_out / k_in)
            * 1000
        )

    E_room = nernst_equation(k_out_values, k_in, T_room)
    E_mammal = nernst_equation(k_out_values, k_in, T_mammal)

    coef_room = (R_gas_constant * T_room / (z_valence * F_faraday)) * np.log(10) * 1000
    coef_mammal = (
        (R_gas_constant * T_mammal / (z_valence * F_faraday)) * np.log(10) * 1000
    )

    k_in_equal = 140
    specific_k_out = [k_in_equal, 124, 124]
    specific_k_in = [k_in_equal, 5, 5]
    specific_temp = [T_room, T_room, T_mammal]
    specific_E = [
        nernst_equation(k_out, k_in, T)
        for k_out, k_in, T in zip(specific_k_out, specific_k_in, specific_temp)
    ]

    plt.figure(figsize=(12, 8))

    plt.semilogx(
        k_out_values, E_room, "b-", linewidth=2, label="Room temperature (20°C)"
    )
    plt.semilogx(
        k_out_values, E_mammal, "r-", linewidth=2, label="Mammalian temperature (37°C)"
    )

    plt.scatter(
        [specific_k_out[0]],
        [specific_E[0]],
        s=100,
        color="k",
        zorder=5,
        label="EK = 0 when [K+]o = [K+]i = 140 mM",
    )
    plt.scatter(
        [specific_k_out[1]],
        [specific_E[1]],
        s=100,
        color="b",
        zorder=5,
        label="EK (20°C) = 80.9 mV at [K+]o = 124 mM, [K+]i = 5 mM",
    )
    plt.scatter(
        [specific_k_out[2]],
        [specific_E[2]],
        s=100,
        color="r",
        zorder=5,
        label="EK (37°C) = 85.1 mV at [K+]o = 124 mM, [K+]i = 5 mM",
    )

    plt.axhline(y=0, color="gray", linestyle="--", alpha=0.7)
    plt.axvline(x=k_in_equal, color="gray", linestyle="--", alpha=0.7)

    plt.grid(True, which="both", alpha=0.3)
    plt.xlabel("Extracellular Potassium Concentration [K+]o (mM)")
    plt.ylabel("Potassium Equilibrium Potential EK (mV)")
    plt.title(
        "Potassium Equilibrium Potential vs Extracellular K+ using Standard Coefficients"
    )
    plt.legend()

    plt.text(
        0.7,
        0.15,
        f"Standard coefficient at 20°C: {coef_room:.0f} mV",
        transform=plt.gca().transAxes,
        bbox=dict(facecolor="white", alpha=0.7),
    )
    plt.text(
        0.7,
        0.1,
        f"Standard coefficient at 37°C: {coef_mammal:.0f} mV",
        transform=plt.gca().transAxes,
        bbox=dict(facecolor="white", alpha=0.7),
    )

    plt.tight_layout()
    plt.savefig("lab_reports/images/potassium_equilibrium.png", dpi=300)


if __name__ == "__main__":
    potassium_equilibrium_plot()
