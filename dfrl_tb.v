`timescale 1ns / 1ps

module tb_dfrl;
    reg clk;
    reg reset;
    reg load;
    reg d_in;
    wire d_out;

    // Instantiate the DFRL module
    dfrl uut (
        .clk(clk),
        .reset(reset),
        .load(load),
        .in(d_in),
        .out(d_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period of 10 time units

    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        load = 0;
        d_in = 0;

        // Monitor output changes
        $monitor("Time=%0t | Reset=%b | Load=%b | d_in=%b | d_out=%b", 
                 $time, reset, load, d_in, d_out);

        // Test case 1: Reset functionality
        $display("Applying reset...");
        reset = 1; #10; // Apply reset
        reset = 0; #10; // Release reset

        // Test case 2: Load data into flip-flop
        $display("Loading data...");
        load = 1; d_in = 1; #10; // Load '1'
        
        load = 0; #10; // Disable load
        $display("Reading data after loading: %b", d_out); // Should be '1'

        // Test case 3: Change input while not loading
        $display("Changing input without loading...");
        d_in = 0; #10; // Change input to '0'
        
        $display("Reading data without loading: %b", d_out); // Should still be '1'

        // Test case 4: Load new data
        $display("Loading new data...");
        load = 1; d_in = 0; #10; // Load '0'
        
        load = 0; #10; // Disable load
        $display("Reading data after loading new value: %b", d_out); // Should be '0'

        // Finish simulation
        $finish;
    end

endmodule