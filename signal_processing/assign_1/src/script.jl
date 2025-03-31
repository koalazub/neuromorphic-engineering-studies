# Edit your script.jl to use:
include("assign_1.jl")
using .Assign1  # Note the dot before Assign1

Assign1.run_demo()

result = Assign1.add_numbers(5, 7)
plot = Assign1.create_interactive_linear_graph()