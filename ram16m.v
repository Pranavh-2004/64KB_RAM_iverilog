module ram16m (
    input wire clk, reset, wr,  // Clock, reset, write enable
    input wire [23:0] rd_addr_a, rd_addr_b, wr_addr,  // 24-bit addresses for 16M memory
    input wire [15:0] d_in,  // 16-bit data input
    output wire [15:0] d_out_a, d_out_b  // 16-bit data outputs
);

    wire [7:0] load;  // Load signals for the 8 ram2m blocks
    wire [15:0] dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7;  // Outputs from each ram2m block

    // Instantiate 8 ram2m modules
    ram2m ram2m_0 (clk, reset, wr & load[0], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_0, dout_0);
    ram2m ram2m_1 (clk, reset, wr & load[1], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_1, dout_1);
    ram2m ram2m_2 (clk, reset, wr & load[2], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_2, dout_2);
    ram2m ram2m_3 (clk, reset, wr & load[3], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_3, dout_3);
    ram2m ram2m_4 (clk, reset, wr & load[4], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_4, dout_4);
    ram2m ram2m_5 (clk, reset, wr & load[5], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_5, dout_5);
    ram2m ram2m_6 (clk, reset, wr & load[6], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_6, dout_6);
    ram2m ram2m_7 (clk, reset, wr & load[7], rd_addr_a[20:0], rd_addr_b[20:0], wr_addr[20:0], d_in, dout_7, dout_7);

    // Demux to select the correct ram2m block for writing
    demux8 demux8_0 (wr, wr_addr[23:21], load);

    // Muxes to select the correct ram2m block for reading
    mux8_16 mux8_16_0 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_a[23:21], d_out_a);
    mux8_16 mux8_16_1 (dout_0, dout_1, dout_2, dout_3, dout_4, dout_5, dout_6, dout_7, rd_addr_b[23:21], d_out_b);

endmodule