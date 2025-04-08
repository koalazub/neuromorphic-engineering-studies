module DPRAM_open_source (
    input  logic        aclr,
    input  logic        clock,
    input  logic [13:0] data,
    input  logic [17:0] rdaddress,
    input  logic [17:0] wraddress,
    input  logic        wren,
    output logic [13:0] q
);
    logic [13:0] mem [0:199999];
    logic [13:0] q_reg;
    
    // Write operation - synchronous
    always_ff @(posedge clock) begin
        if (wren) begin
            mem[wraddress] <= data;
        end
    end
    
    always_ff @(posedge clock or posedge aclr) begin
        if (aclr) begin
            q_reg <= '0;
        end else begin
            q_reg <= mem[rdaddress];
        end
    end
    
    assign q = q_reg;
    
    initial begin
        for (int i = 0; i < 200000; i++) begin
            mem[i] = '0;
        end
    end
endmodule

