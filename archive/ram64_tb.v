`timescale 1ns / 1ps

module tb_ram64;
    // Testbench signals
    reg clk, reset, wr;
    reg [2:0] rd_addr_a, rd_addr_b, wr_addr;
    reg [15:0] d_in;
    wire [15:0] d_out_a, d_out_b;

    // Instantiate the RAM module
    ram64 uut (
        .clk(clk),
        .reset(reset),
        .wr(wr),
        .rd_addr_a(rd_addr_a),
        .rd_addr_b(rd_addr_b),
        .wr_addr(wr_addr),
        .d_in(d_in),
        .d_out_a(d_out_a),
        .d_out_b(d_out_b)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period 10 time units

    // Monitor changes in key signals
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | wr=%b | wr_addr=%b | d_in=%h | rd_addr_a=%b | rd_addr_b=%b | d_out_a=%h | d_out_b=%h", 
                 $time, clk, reset, wr, wr_addr, d_in, rd_addr_a, rd_addr_b, d_out_a, d_out_b);
    end

    // VCD dump setup
    initial begin
        $dumpfile("tb_ram64.vcd"); // Create VCD file
        $dumpvars(0, tb_ram64);     // Dump all variables in this module
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        wr = 0;
        rd_addr_a = 3'b000;
        rd_addr_b = 3'b001;
        wr_addr = 3'b000;
        d_in = 16'hFFFF;

        // Reset the DUT
        $display("Applying reset...");
        reset = 1; #10; // Apply reset for one clock cycle
        reset = 0;

        // Test Write Operation
        $display("Writing to RAM...");
        
        wr = 1; // Enable write
        
        // Write first value
        wr_addr = 3'b000; 
        d_in = 16'hA5A5;  
        
        #10; // Wait for one clock cycle (write happens at next rising edge)
        
        // Write second value
        wr_addr = 3'b001; 
        d_in = 16'h5A5A;  

        #10; // Wait for one clock cycle (write happens at next rising edge)
        
        wr = 0; // Disable write

        // Test Read Operation
        $display("Reading from RAM...");
        
        rd_addr_a = 3'b000; 
        #10; // Wait for one clock cycle (read happens at next rising edge)
        
        $display("Read data at address %b: %h", rd_addr_a, d_out_a);

        rd_addr_b = 3'b001; 
        #10; // Wait for one clock cycle (read happens at next rising edge)
        
        $display("Read data at address %b: %h", rd_addr_b, d_out_b);


       // Test Write and Read at the same time (optional)
       $display("Write and Read simultaneously...");
       wr = 1;
       wr_addr = 3'b000;
       d_in = 16'h1234;  
       
       #10; // Wait for one clock cycle (write happens at next rising edge)
       
       wr = 0;  
       rd_addr_a = 3'b000;  
       
       #10; // Wait for one clock cycle (read happens at next rising edge)
       
       $display("Read data at address %b after writing: %h", rd_addr_a, d_out_a);
       
       // Finish simulation 
       $finish;
    end

endmodule