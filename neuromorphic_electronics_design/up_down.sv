module up_down (
    input wire clk,
    input wire state,
    output reg [1:0] toggle
);

    // Initialize toggle to 0
    initial begin
        toggle = 2'b00;
    end

    reg prev_state;
    
    always @(posedge clk) begin
        prev_state <= state;
        
        // Toggle on rising edge of state
        if (state && !prev_state) begin
            toggle <= toggle + 1'b1;
        end
    end

endmodule
