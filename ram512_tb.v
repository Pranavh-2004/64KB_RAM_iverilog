module tb_ram512;
    // Testbench signals
    reg clk, reset, wr;
    reg [8:0] rd_addr_a, rd_addr_b, wr_addr;  // 9-bit addresses for 512 locations
    reg [15:0] d_in;  // 16-bit data input
    wire [15:0] d_out_a, d_out_b;  // 16-bit data outputs

    // Instantiate the RAM512 module
    ram512 uut (
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

    // Monitor key signals
    initial begin
        $monitor("Time=%0t | clk=%b | reset=%b | wr=%b | wr_addr=%b | d_in=%h | rd_addr_a=%b | rd_addr_b=%b | d_out_a=%h | d_out_b=%h", 
                 $time, clk, reset, wr, wr_addr, d_in, rd_addr_a, rd_addr_b, d_out_a, d_out_b);
    end

    // VCD dump setup
    initial begin
        $dumpfile("tb_ram512.vcd"); // Create VCD file
        $dumpvars(0, tb_ram512);     // Dump all variables in this module
    end

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        wr = 0;
        rd_addr_a = 9'b0;
        rd_addr_b = 9'b0;
        wr_addr = 9'b0;
        d_in = 16'h0000;

        // Apply reset
        $display("Applying reset...");
        reset = 1;
        #10;
        reset = 0;

        // Test Write Operation
        $display("Writing to RAM...");
        wr = 1;
        
        wr_addr = 9'b000000001; // Address 1
        d_in = 16'hAAAA;        // Write pattern
        #10;
        
        wr_addr = 9'b000000010; // Address 2
        d_in = 16'h5555;        // Write pattern
        #10;

        wr_addr = 9'b000010000; // Address 8 (to test different block selection)
        d_in = 16'h1234;        // Write pattern
        #10;

        wr = 0;  // Disable write

        // Test Read Operation
        $display("Reading from RAM...");
        
        // Read from address 1
        rd_addr_a = 9'b000000001;
        #10;
        $display("Read data at address %b: %h", rd_addr_a, d_out_a);

        // Read from address 2
        rd_addr_b = 9'b000000010;
        #10;
        $display("Read data at address %b: %h", rd_addr_b, d_out_b);

        // Read from address 8
        rd_addr_a = 9'b000010000;
        #10;
        $display("Read data at address %b: %h", rd_addr_a, d_out_a);

        // Test Write and Read at the same time in different blocks
        $display("Write and Read simultaneously in different blocks...");
        wr = 1;
        wr_addr = 9'b000001000; // Address 8 (same block as rd_addr_b)
        d_in = 16'hDEAD;        // Write new pattern
        rd_addr_b = 9'b000001000; // Read from the same address
        #10;
        
        wr = 0; // Disable write
        $display("Read data at address %b after writing: %h", rd_addr_b, d_out_b);

        // Finish simulation
        $finish;
    end
endmodule