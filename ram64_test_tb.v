`timescale 1ns / 1ps

module tb_ram_64kb;
    // Testbench signals
    reg clk;                      // Clock signal for the testbench
    reg [15:0] address;          // Address for the RAM
    reg [7:0] data_in;           // Data input for the RAM
    reg we;                      // Write enable signal
    wire [7:0] data_out;         // Data output from the RAM

    // Instantiate the RAM module
    ram_64kb ram (
        .clk(clk),
        .address(address),
        .data_in(data_in),
        .we(we),
        .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period of 10 time units

    // Monitor changes in key signals
    initial begin
        $monitor("Time=%0t | clk=%b | we=%b | address=%h | data_in=%h | data_out=%h", 
                 $time, clk, we, address, data_in, data_out);
    end

    // VCD dump setup
    initial begin
        $dumpfile("tb_ram_64kb.vcd"); // Create VCD file
        $dumpvars(1, tb_ram_64kb);     // Dump all variables in this module
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        we = 0;
        address = 16'h0000;
        data_in = 8'h00;

        // Test writing to RAM
        #5;
        we = 1;                 // Enable write
        address = 16'h0001;     // Address to write to
        data_in = 8'hAB;       // Data to write
        #10;

        we = 0;                 // Disable write for reading

        // Test reading from RAM
        address = 16'h0001;     // Address to read from
        #10;

        $display("Data at address %h: %h", address, data_out); // Should display AB

        // Further tests can be added here...
        
        // Write and read additional values for testing
        we = 1;
        
        address = 16'h0002;     // Write to another address
        data_in = 8'hCD;       // New data to write
        #10;

        we = 0;                 // Disable write for reading
        
        address = 16'h0002;     // Read from the new address
        #10;

        $display("Data at address %h: %h", address, data_out); // Should display CD
        
        $finish;               // End simulation
    end

endmodule