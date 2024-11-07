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
        reset = 1;
        #10;
        reset = 0;
        
        // Test Write Operation
        $display("Writing to RAM...");
        wr = 1;
        wr_addr = 3'b000;
        d_in = 16'hA5A5;  // Write pattern
        #10;
        
        wr_addr = 3'b001;
        d_in = 16'h5A5A;  // Write pattern
        #10;

        // Test Read Operation
        $display("Reading from RAM...");
        wr = 0;  // Disable write
        
        // Read from address 0
        rd_addr_a = 3'b000;
        #10;
        $display("Read data at address %b: %h", rd_addr_a, d_out_a);
        
        // Read from address 1
        rd_addr_b = 3'b001;
        #10;
        $display("Read data at address %b: %h", rd_addr_b, d_out_b);
        
        // Test Write and Read at the same time
        $display("Write and Read simultaneously...");
        wr = 1;
        wr_addr = 3'b000;
        d_in = 16'h1234;  // Write new pattern
        #10;
        
        wr = 0;  // Disable write
        rd_addr_a = 3'b000;  // Read from the same address
        #10;
        $display("Read data at address %b after writing: %h", rd_addr_a, d_out_a);
        
        // Finish simulation
        $finish;
    end
endmodule