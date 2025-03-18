module counter (
    input wire clk,
    input wire reset,
    output reg [3:0] count  // 4-bit counter
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 4'b0000; // reset to zero
        else
            count <= count + 1;
    end

endmodule
