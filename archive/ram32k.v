module ram32k (
    input wire clk, reset, wr,  // Clock, reset, write enable
    input wire [14:0] rd_addr_a, rd_addr_b, wr_addr,  // 15-bit addresses for 32K memory
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 ram4k blocks
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each ram4k block

    // Instantiate 8 ram4k modules
    ram4k ram4k_0 (clk, reset, wr & load[0], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_0, dout_0);
    ram4k ram4k_1 (clk, reset, wr & load[1], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_1, dout_1);
    ram4k ram4k_2 (clk, reset, wr & load[2], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_2, dout_2);
    ram4k ram4k_3 (clk, reset, wr & load[3], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_3, dout_3);
    ram4k ram4k_4 (clk, reset, wr & load[4], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_4, dout_4);
    ram4k ram4k_5 (clk, reset, wr & load[5], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_5, dout_5);
    ram4k ram4k_6 (clk, reset, wr & load[6], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_6, dout_6);
    ram4k ram4k_7 (clk, reset, wr & load[7], rd_addr_a[11:0], rd_addr_b[11:0], wr_addr[11:0], d_in, dout_7, dout_7);

    // Demux to select the correct ram4k block for writing
    demux8 demux8_2 (wr, wr_addr[14:12], load);

    // Muxes to select the correct ram4k block for reading
    mux8_16 mux8_16_3 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[14:12], d_out_a);
    mux8_16 mux8_16_4 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[14:12], d_out_b);

endmodule