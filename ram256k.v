module ram256k (
    input wire clk, reset, wr,  // Clock, reset, write enable
    input wire [17:0] rd_addr_a, rd_addr_b, wr_addr,  // 18-bit addresses for 256K memory
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 ram32k blocks
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each ram32k block

    // Instantiate 8 ram32k modules
    ram32k ram32k_0 (clk, reset, wr & load[0], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_0, dout_0);
    ram32k ram32k_1 (clk, reset, wr & load[1], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_1, dout_1);
    ram32k ram32k_2 (clk, reset, wr & load[2], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_2, dout_2);
    ram32k ram32k_3 (clk, reset, wr & load[3], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_3, dout_3);
    ram32k ram32k_4 (clk, reset, wr & load[4], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_4, dout_4);
    ram32k ram32k_5 (clk, reset, wr & load[5], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_5, dout_5);
    ram32k ram32k_6 (clk, reset, wr & load[6], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_6, dout_6);
    ram32k ram32k_7 (clk, reset, wr & load[7], rd_addr_a[14:0], rd_addr_b[14:0], wr_addr[14:0], d_in, dout_7, dout_7);

    // Demux to select the correct ram32k block for writing
    demux8 demux8_0 (wr, wr_addr[17:15], load);

    // Muxes to select the correct ram32k block for reading
    mux8_16 mux8_16_0 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[17:15], d_out_a);
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[17:15], d_out_b);

endmodule