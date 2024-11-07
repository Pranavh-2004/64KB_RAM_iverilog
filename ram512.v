module ram512 (
    input wire clk, reset, wr,
    input wire [8:0] rd_addr_a, rd_addr_b, wr_addr, // 9-bit addresses for 512 locations
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Signals to enable one of the 8 ram64 blocks for writing
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Data outputs from 8 ram64 blocks

    // Instantiate 8 ram64 modules
    ram64 ram64_0 (clk, reset, wr & load[0], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_0, dout_0);
    ram64 ram64_1 (clk, reset, wr & load[1], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_1, dout_1);
    ram64 ram64_2 (clk, reset, wr & load[2], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_2, dout_2);
    ram64 ram64_3 (clk, reset, wr & load[3], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_3, dout_3);
    ram64 ram64_4 (clk, reset, wr & load[4], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_4, dout_4);
    ram64 ram64_5 (clk, reset, wr & load[5], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_5, dout_5);
    ram64 ram64_6 (clk, reset, wr & load[6], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_6, dout_6);
    ram64 ram64_7 (clk, reset, wr & load[7], rd_addr_a[2:0], rd_addr_b[2:0], wr_addr[2:0], d_in, dout_7, dout_7);

    // Demux to select which ram64 block receives the write signal
    demux8 demux8_1 (wr, wr_addr[5:3], load);

    // Muxes to read data from the correct ram64 block
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[5:3], d_out_a);
    mux8_16 mux8_16_2 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[5:3], d_out_b);

endmodule