module ram4k (
    input wire clk, reset, wr,  // Clock, reset, write enable
    input wire [11:0] rd_addr_a, rd_addr_b, wr_addr,  // 12-bit addresses for 4K memory locations
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 ram512 blocks
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each ram512 block

    // Instantiate 8 ram512 modules
    ram512 ram512_0 (clk, reset, wr & load[0], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_0, dout_0);
    ram512 ram512_1 (clk, reset, wr & load[1], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_1, dout_1);
    ram512 ram512_2 (clk, reset, wr & load[2], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_2, dout_2);
    ram512 ram512_3 (clk, reset, wr & load[3], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_3, dout_3);
    ram512 ram512_4 (clk, reset, wr & load[4], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_4, dout_4);
    ram512 ram512_5 (clk, reset, wr & load[5], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_5, dout_5);
    ram512 ram512_6 (clk, reset, wr & load[6], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_6, dout_6);
    ram512 ram512_7 (clk, reset, wr & load[7], rd_addr_a[8:0], rd_addr_b[8:0], wr_addr[8:0], d_in, dout_7, dout_7);

    // Demux to select the correct ram512 block for writing
    demux8 demux8_1 (wr, wr_addr[11:9], load);

    // Muxes to select the correct ram512 block for reading
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[11:9], d_out_a);
    mux8_16 mux8_16_2 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[11:9], d_out_b);

endmodule