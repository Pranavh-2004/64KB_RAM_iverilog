`timescale 1ns / 1ps

module tb_ram128m;

    // Parameters
    reg clk, reset, wr;
    reg [26:0] wr_addr, rd_addr_a, rd_addr_b;  // 27-bit addresses for 128M RAM
    reg [15:0] d_in;  // 16-bit input data
    wire [15:0] d_out_a, d_out_b;  // 16-bit output data

    // Instantiate the DUT (Device Under Test)
    ram128m DUT (
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
        wr_addr = 27'b0;
        rd_addr_a = 27'b0;
        rd_addr_b = 27'b0;
        d_in = 16'h0000;

        // Initialize GTKWave dumpfile
        $dumpfile("ram128m.vcd");    // Specify the VCD file name
        $dumpvars(0, tb_ram128m);     // Dump all variables in the testbench

        // Reset the RAM
        #10 reset = 0; // Release reset
        #10 reset = 1;

        // Write some data to various addresses
        #10;
        wr = 1;
        wr_addr = 27'h0000001;  // Address 1
        d_in = 16'hABCD;  // Write ABCD
        #10;

        wr_addr = 27'h0000002;  // Address 2
        d_in = 16'h1234;  // Write 1234
        #10;

        wr = 0;  // Stop writing

        // Read back the data from the same addresses
        #10;
        rd_addr_a = 27'h0000001;  // Read Address 1
        rd_addr_b = 27'h0000002;  // Read Address 2
        #10;
        $display("Read from Address 1: %h", d_out_a);  // Expected: ABCD
        $display("Read from Address 2: %h", d_out_b);  // Expected: 1234

        // End the simulation
        #20;
        $finish;
    end

endmodule