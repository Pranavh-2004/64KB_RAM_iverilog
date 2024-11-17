`timescale 1ns / 1ps

module tb_ram_64kb;
    reg clk;                      
    reg [15:0] address;          
    reg [7:0] data_in;           
    reg we;                      
    wire [7:0] data_out;         

    // Instantiation of the RAM module
    ram_64kb ram (
        .clk(clk),
        .address(address),
        .data_in(data_in),
        .we(we),
        .data_out(data_out)
    );

    always #5 clk = ~clk;  // period of 10 time units

    initial begin
        $monitor("Time=%0t | clk=%b | we=%b | address=%h | data_in=%h | data_out=%h", 
                 $time, clk, we, address, data_in, data_out);
    end

    initial begin
        $dumpfile("tb_ram_64kb.vcd"); 
        $dumpvars(0, tb_ram_64kb);     
    end

    initial begin
        clk = 0;
        we = 0;
        address = 16'h0000;
        data_in = 8'h00;

        // Test writing to RAM
        #5;
        we = 1;                 // Enable
        address = 16'h0001;     // Address to write to
        data_in = 8'hAB;       // Data to write
        #10;

        we = 0;                 // Disable 

        // Test reading from RAM
        address = 16'h0001;     // Address to read from
        #10;

        $display("Data at address %h: %h", address, data_out); 

        
        // Write and read additional values for testing
        we = 1;
        
        address = 16'h0002;     // Write to another address
        data_in = 8'hCD;       // New data to write
        #10;

        we = 0;                 // Disable 
        
        address = 16'h0002;     // Read from the new address
        #10;

        $display("Data at address %h: %h", address, data_out); 
        
        $finish;               
    end

endmodule