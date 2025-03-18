Let's learn SystemVerilog step-by-step from scratch, quiz-style, reinforcing each concept clearly and simply.

---

## Step 1: **Modules and Ports**

**What is a module in SystemVerilog?**

A module is a basic building block used to describe hardware components. Think of it as a "black box" with inputs and outputs, similar to an electronic component.

**Example Syntax:**
```systemverilog
module my_module (
    input logic clk,
    input logic reset,
    output logic [3:0] counter
);
    // functionality goes here
endmodule
```

**Quiz Question:**  
Write a simple module named `adder` that takes two 4-bit inputs (`a`, `b`) and outputs their 4-bit sum (`sum`).

**Answer:**
```systemverilog
module adder (
    input logic [3:0] a,
    input logic [3:0] b,
    output logic [3:0] sum
);
    assign sum = a + b;
endmodule
```

---

## Step 2: **Data Types**

SystemVerilog has several important data types:

- **logic**: General-purpose type used for signals (can replace Verilog's wire/reg).
- **wire**: Represents connections between hardware elements; doesn't store values.
- **reg**: Can store values; used in procedural blocks.

| Type  | Stores Value? | Usage                         |
|-------|---------------|-------------------------------|
| wire  | No            | Continuous assignments        |
| reg   | Yes           | Procedural assignments        |
| logic | Yes           | Procedural or continuous      |[3]

**Quiz Question:**  
Which data type would you use for signals that must store values between clock cycles?

**Answer:**  
Use `logic` or `reg`.

---

## Step 3: **Procedural Blocks (initial vs always)**

Procedural blocks describe behavior executed sequentially.

- **initial block:** Runs once at simulation start, typically for initialization. Not synthesizable for ASIC but synthesizable for FPGA.
- **always block:** Runs continuously based on sensitivity list (e.g., clock edges). Synthesizable for sequential logic.[4]

**Example:**
```systemverilog
initial begin
    counter = 0; // runs once at simulation start
end

always @(posedge clk) begin
    counter <= counter + 1; // runs every clock cycle
end
```

**Quiz Question:**  
Which procedural block would you use to increment a counter every clock cycle?

**Answer:**  
Use an `always` block triggered by the clock edge.

---

## Step 4: **Module Instantiation**

To reuse modules, we instantiate them within other modules.

```systemverilog
// Example instantiation of 'adder' module from above:
module top_module(
    input logic [3:0] x,
    input logic [3:0] y,
    output logic [3:0] result
);

adder my_adder (
    .a(x),
    .b(y),
    .sum(result)
);

endmodule
```


**Quiz Question:**  
Instantiate the previously defined `adder` module in a new module called `calc`, connecting inputs `num1`, `num2`, and output `total`.

**Answer:**  
```systemverilog
module calc(
    input logic [3:0] num1,
    input logic [3:0] num2,
    output logic [3:0] total
);

adder add_instance (
    .a(num1),
    .b(num2),
    .sum(total)
);

endmodule
```

---

## Step 5: **Writing a Testbench**

Testbenches simulate your design to verify correctness. They are not synthesized into hardware.

Typical testbench structure:

- Instantiate your Design Under Test (DUT)
- Generate stimulus (inputs)
- Monitor outputs[5]

**Simple Testbench Example (for the adder):**
```systemverilog
module adder_tb;
logic [3:0] a, b;
logic [3:0] sum;

// Instantiate DUT (Device Under Test)
adder dut (.a(a), .b(b), .sum(sum));

initial begin
  $monitor("Time=%t | a=%b b=%b sum=%b", $time, a, b, sum);
  
  // Stimulus sequence:
  a = 4'b0001; b = 4'b0010; #10;
  a = 4'b0101; b = 4'b0011; #10;
  a = 4'b1111; b = 4'b0001; #10;
  
  $finish;
end

endmodule
```

**Quiz Question:**  
In the above testbench, what does the statement `$monitor(...)` do?

**Answer:**  
It prints signal values whenever any monitored signal changes during simulation.

---

## Step 6: **Edge Detection (Advanced Concept)**

Detecting rising edges of signals is common in digital design:

```systemverilog
logic current_state, prev_state;

always @(posedge clk) begin
   prev_state <= current_state;
   if (current_state && !prev_state) begin
       // Rising edge detected!
   end
end
```

This stores previous state and compares it with current state to detect transitions.

---

## Quick Recap Quiz:

1. What keyword starts and ends every SystemVerilog module?
   - Answer: `module` and `endmodule`.

2. Which data type can replace both wire and reg in modern SystemVerilog code?
   - Answer: `logic`.

3. What procedural block runs continuously based on its sensitivity list?
   - Answer: `always`.

4. How do you reuse existing modules in your design?
   - Answer: By instantiating them inside other modules.

5. What's the purpose of writing a testbench?
   - Answer: To verify your design by simulating inputs and observing outputs.
