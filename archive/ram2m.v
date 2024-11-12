module ram2m (
    input wire clk, reset, wr,  // Clock, reset, write enable
    input wire [20:0] rd_addr_a, rd_addr_b, wr_addr,  // 21-bit addresses for 2M memory
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 ram256k blocks
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each ram256k block

    // Instantiate 8 ram256k modules
    ram256k ram256k_0 (clk, reset, wr & load[0], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_0, dout_0);
    ram256k ram256k_1 (clk, reset, wr & load[1], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_1, dout_1);
    ram256k ram256k_2 (clk, reset, wr & load[2], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_2, dout_2);
    ram256k ram256k_3 (clk, reset, wr & load[3], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_3, dout_3);
    ram256k ram256k_4 (clk, reset, wr & load[4], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_4, dout_4);
    ram256k ram256k_5 (clk, reset, wr & load[5], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_5, dout_5);
    ram256k ram256k_6 (clk, reset, wr & load[6], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_6, dout_6);
    ram256k ram256k_7 (clk, reset, wr & load[7], rd_addr_a[17:0], rd_addr_b[17:0], wr_addr[17:0], d_in, dout_7, dout_7);

    // Demux to select the correct ram256k block for writing
    demux8 demux8_0 (wr, wr_addr[20:18], load);

    // Muxes to select the correct ram256k block for reading
    mux8_16 mux8_16_0 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[20:18], d_out_a);
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[20:18], d_out_b);

endmodule