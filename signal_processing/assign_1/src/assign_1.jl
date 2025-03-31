module Assign1

using LinearAlgebra
using Plots

# Switch to Plotly backend for interactive plots
plotly()

"""
    add_numbers(a::Number, b::Number)::Number

Add two numbers and return their sum.
"""
add_numbers(a::Number, b::Number)::Number = a + b

"""
    plot_interactive_graph(x_values, y_values; title="Interactive Linear Graph")

Create an interactive graph with the given x and y values.
Returns the plot object for further customization if needed.
"""
function plot_interactive_graph(x_values::AbstractVector{<: Real}, y_values::AbstractVector{<: Real};
                                title="Interactive Linear Graph")
    return plot(
        x_values,
        y_values,
        label = "Linear Function",
        xlabel = "X-axis",
        ylabel = "Y-axis",
        title = title,
        legend = :topleft,
        linewidth = 2,
        marker = :circle,
        markersize = 6,
        hover = true,  # Enable hover tooltips
        size = (800, 600)  # Larger size for better interactivity
    )
end

"""
    create_interactive_linear_graph()

Create an interactive linear graph showing y = 2x + 1.
"""
function create_interactive_linear_graph()
    x_vals = 1:0.5:10  # More points for smoother line
    y_vals = 2 .* x_vals .+ 1  # Linear equation y = 2x + 1
    p = plot_interactive_graph(x_vals, y_vals)

    # Add text annotation explaining interactivity
    annotate!(p, [(4, 15, text("Zoom, pan, and hover for values", 10, :black))])

    return p
end

"""
    matrix_operations()

Perform matrix operations for question 2 and return results.
"""
function matrix_operations()
    # Define the matrix R
    R = [7 -4 -4; -4 1 -8; -4 -8 1]  # Fixed matrix notation
    println("Matrix R:")
    display(R)

    # Part (i) - Calculate R²
    R_squared = R^2
    println("\nR² (R squared):")
    display(R_squared)

    # Create a heatmap visualization of the matrices
    p1 = heatmap(R,
        title = "Matrix R",
        xlabel = "Column",
        ylabel = "Row",
        xticks = (1:3, ["1", "2", "3"]),
        yticks = (1:3, ["1", "2", "3"]),
        color = :viridis,
        aspect_ratio = :equal,
        colorbar_title = "Value"
    )

    p2 = heatmap(R_squared,
        title = "Matrix R²",
        xlabel = "Column",
        ylabel = "Row",
        xticks = (1:3, ["1", "2", "3"]),
        yticks = (1:3, ["1", "2", "3"]),
        color = :viridis,
        aspect_ratio = :equal,
        colorbar_title = "Value"
    )

    # Display the matrix visualizations side by side
    matrix_viz = plot(p1, p2, layout = (1, 2), size = (900, 400))
    display(matrix_viz)

    return R, R_squared, matrix_viz
end

"""
    plot_parametric_curve()

Create an interactive parametric curve as an additional visualization example.
"""
function plot_parametric_curve()
    t = range(0, 2π, length = 100)
    x = 16 * sin.(t).^3
    y = 13 * cos.(t) - 5 * cos.(2*t) - 2 * cos.(3*t) - cos.(4*t)

    p = plot_interactive_graph(x, y, title="Interactive Parametric Curve")
    plot!(p, aspect_ratio=:equal, label="Heart Curve")

    return p
end

# Export functions for use outside the module
export add_numbers, plot_interactive_graph, create_interactive_linear_graph, matrix_operations, plot_parametric_curve

# Function to run all the demonstrations
function run_demo()
    # Execute matrix operations and store results
    println("Performing matrix operations...")
    R, R_squared, matrix_visualization = matrix_operations()

    # Create interactive linear graph
    println("\nCreating interactive linear graph...")
    interactive_plot = create_interactive_linear_graph()
    display(interactive_plot)

    # Create a bonus parametric curve plot to showcase more interactivity
    bonus_plot = plot_parametric_curve()
    display(bonus_plot)

    println("\nAll plots are interactive - you can zoom, pan, and hover over points.")
    println("The plots are stored in the following variables.")

    return interactive_plot
end

export run_demo

end # module