module ram_64kb (
    input wire clk,                // Clock signal
    input wire [15:0] address,     // 16-bit address bus (0 to 65535)
    input wire [7:0] data_in,      // 8-bit data input
    input wire we,                 // Write enable signal
    output reg [7:0] data_out      // 8-bit data output
);
    // Memory array declaration (64KB = 65536 bytes)
    reg [7:0] memory [0:65535];

    always @(posedge clk) begin
        if (we) begin
            // Write operation
            memory[address] <= data_in;
        end else begin
            // Read operation
            data_out <= memory[address];
        end
    end
endmodule