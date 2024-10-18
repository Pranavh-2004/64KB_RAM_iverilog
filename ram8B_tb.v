`timescale 1ns / 1ps

module tb_ram8b;

    // Parameters
    reg clk, reset, wr;
    reg [32:0] wr_addr, rd_addr_a, rd_addr_b;  // 33-bit addresses
    reg [15:0] d_in;  // 16-bit input data
    wire [15:0] d_out_a, d_out_b;  // 16-bit output data

    // Instantiate the DUT (Device Under Test)
    ram8b DUT (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .wr_addr(wr_addr),
        .rd_addr_a(rd_addr_a),
        .rd_addr_b(rd_addr_b),
        .d_in(d_in),
        .d_out_a(d_out_a),
        .d_out_b(d_out_b)
    );

    // Clock generation: 10ns period (100 MHz frequency)
    always #5 clk = ~clk;

    // Initial block: Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        wr = 0;
        wr_addr = 0;
        rd_addr_a = 0;
        rd_addr_b = 0;
        d_in = 16'h0000;

        // Reset the RAM
        #10 reset = 0;
        #10 reset = 1;

        // Write some data to various addresses
        #10;
        wr = 1;
        wr_addr = 33'h000000000;  // Address 0
        d_in = 16'hABCD;  // Write ABCD
        #10;

        wr_addr = 33'h000000001;  // Address 1
        d_in = 16'h1234;  // Write 1234
        #10;

        wr_addr = 33'h800000000;  // Address with upper bit set (selecting another RAM block)
        d_in = 16'h5678;  // Write 5678
        #10;

        wr = 0;  // Stop writing

        // Read back the data from the same addresses
        #10;
        rd_addr_a = 33'h000000000;  // Read Address 0
        rd_addr_b = 33'h000000001;  // Read Address 1
        #10;
        $display("Read from Address 0: %h", d_out_a);  // Expected: ABCD
        $display("Read from Address 1: %h", d_out_b);  // Expected: 1234

        #10;
        rd_addr_a = 33'h800000000;  // Read Address with upper bit set
        rd_addr_b = 33'h000000000;  // Read Address 0 again
        #10;
        $display("Read from Address 0 (again): %h", d_out_b);  // Expected: ABCD
        $display("Read from Upper RAM Block: %h", d_out_a);  // Expected: 5678

        // End the simulation
        #20;
        $finish;
    end

endmodule