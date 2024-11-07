module ram1b (
    input wire clk, reset, wr,  // Clock, reset, and write enable
    input wire [29:0] rd_addr_a, rd_addr_b, wr_addr,  // 30-bit addresses
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 `ram128m` modules
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each `ram128m`

    // Instantiate 8 `ram128m` modules
    ram128m ram128m_0 (clk, reset, wr & load[0], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_0, dout_0);
    ram128m ram128m_1 (clk, reset, wr & load[1], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_1, dout_1);
    ram128m ram128m_2 (clk, reset, wr & load[2], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_2, dout_2);
    ram128m ram128m_3 (clk, reset, wr & load[3], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_3, dout_3);
    ram128m ram128m_4 (clk, reset, wr & load[4], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_4, dout_4);
    ram128m ram128m_5 (clk, reset, wr & load[5], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_5, dout_5);
    ram128m ram128m_6 (clk, reset, wr & load[6], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_6, dout_6);
    ram128m ram128m_7 (clk, reset, wr & load[7], rd_addr_a[26:0], rd_addr_b[26:0], wr_addr[26:0], d_in, dout_7, dout_7);

    // Demux to select the correct `ram128m` module for writing
    demux8 demux8_0 (wr, wr_addr[29:27], load);

    // Muxes to select the correct `ram128m` module for reading
    mux8_16 mux8_16_0 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[29:27], d_out_a);
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[29:27], d_out_b);

endmodule