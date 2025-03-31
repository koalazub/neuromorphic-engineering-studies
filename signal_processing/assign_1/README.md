# Interactive Julia Plotting Demo

This interactive data visualisation demo showcases multiple plotting capabilities in Julia, including linear graphs, matrix visualisations, and parametric curves. All visualisations are fully interactive, allowing you to zoom, pan, and hover for values.

## Quick Start

1. **Run the demo with a single command:**
```shell script
julia --project=. script.jl
```

   This will display several interactive visualisations that demonstrate different plotting capabilities.

1. **Interact with the plots:**
   - **Zoom**: Use your mouse wheel or trackpad
   - **Pan**: Click and drag on the plot area
   - **View data points**: Hover your cursor over any point to see its values
   - **Reset view**: Double-click anywhere on the plot

## What You'll See

When you run the script, you'll experience:

1. **Matrix Visualisations**: Heat maps showing a 3×3 matrix and its square, displayed side by side for easy comparison.

2. **Interactive Linear Graph**: A visualisation of `y = 2x + 1` with points you can examine by hovering your mouse over them.

3. **Parametric Heart Curve**: A beautiful heart-shaped curve that demonstrates more complex plotting capabilities.

## Troubleshooting

If you encounter any dramas:

- **Missing packages?** The script will attempt to install required packages automatically.

- **"Module not found" error?** Make sure both `assign_1.jl` and `script.jl` are in the same directory.

- **Plots not showing up?** Check that you have `PlotlyBase` installed. The script should install it automatically, but if not:
```julia
import Pkg; Pkg.add("PlotlyBase")
```

## Extending the Demo

Have a crack at these modifications to explore further:

1. Change the linear equation in `create_interactive_linear_graph()` from `y = 2x + 1` to something else
2. Modify the matrix in `matrix_operations()` to see how different input matrices affect the output
3. Experiment with different parametric equations in `plot_parametric_curve()`

## How It Works

Behind the scenes, the demo:
1. Loads necessary Julia packages for mathematical operations and plotting
2. Switches to the Plotly backend to enable interactive features
3. Uses a modular approach with separate functions for each visualisation type
4. Combines these visualisations in a comprehensive demo

The code is organised as a Julia module (`Assign1`) that's imported into the main script, demonstrating good code organisation practices while keeping everything accessible.

---

**Note**: This demo requires Julia 1.6 or later. The plots work best in a graphical environment or Jupyter notebook setting but can work via browser and PyCharm provided you have the Julia plugin installed(it's a `pita` just so you know).