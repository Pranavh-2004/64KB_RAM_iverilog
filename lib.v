module invert (input wire i, output wire o);
   assign o = !i;
endmodule

module and2 (input wire i0, i1, output wire o);
  assign o = i0 & i1;
endmodule

module or2 (input wire i0, i1, output wire o);
  assign o = i0 | i1;
endmodule

module xor2 (input wire i0, i1, output wire o);
  assign o = i0 ^ i1;
endmodule

module nand2 (input wire i0, i1, output wire o);
   wire t;
   and2 and2_0 (i0, i1, t);
   invert invert_0 (t, o);
endmodule

module nor2 (input wire i0, i1, output wire o);
   wire t;
   or2 or2_0 (i0, i1, t);
   invert invert_0 (t, o);
endmodule

module xnor2 (input wire i0, i1, output wire o);
   wire t;
   xor2 xor2_0 (i0, i1, t);
   invert invert_0 (t, o);
endmodule

module and3 (input wire i0, i1, i2, output wire o);
   wire t;
   and2 and2_0 (i0, i1, t);
   and2 and2_1 (i2, t, o);
endmodule

module or3 (input wire i0, i1, i2, output wire o);
   wire t;
   or2 or2_0 (i0, i1, t);
   or2 or2_1 (i2, t, o);
endmodule

module nor3 (input wire i0, i1, i2, output wire o);
   wire t;
   or2 or2_0 (i0, i1, t);
   nor2 nor2_0 (i2, t, o);
endmodule

module nand3 (input wire i0, i1, i2, output wire o);
   wire t;
   and2 and2_0 (i0, i1, t);
   nand2 nand2_1 (i2, t, o);
endmodule

module xor3 (input wire i0, i1, i2, output wire o);
   wire t;
   xor2 xor2_0 (i0, i1, t);
   xor2 xor2_1 (i2, t, o);
endmodule

module mux2 (input wire i0, i1, j, output wire o);
    assign o = (j == 0) ? i0 : i1;
endmodule

module mux4 (input wire [0:3] i, input wire j1, j2, output wire o);
    wire t0, t1;
    mux2 mux2_0 (i[0], i[1], j1, t0);
    mux2 mux2_1 (i[2], i[3], j1, t1);
    mux2 mux2_2 (t0, t1, j2, o);  // Corrected j2 usage
endmodule

module mux8 (input wire [0:7] i, input wire j2, j1, j0, output wire o);
    wire t0, t1;
    mux4 mux4_0 (i[0:3], j2, j1, t0);
    mux4 mux4_1 (i[4:7], j2, j1, t1);  // Corrected j2 usage
    mux2 mux2_0 (t0, t1, j0, o);
endmodule

module demux2 (input wire i, j, output wire o0, o1);
    assign o0 = (j == 0) ? i : 1'b0;
    assign o1 = (j == 1) ? i : 1'b0;
endmodule

module demux4 (input wire i, j1, j0, output wire [0:3] o);
    wire t0, t1;
    demux2 demux2_0 (i, j1, t0, t1);
    demux2 demux2_1 (t0, j0, o[0], o[1]);
    demux2 demux2_2 (t1, j0, o[2], o[3]);
endmodule

/*
module demux8 (input wire i, j2, j1, j0, output wire [0:7] o);
   wire t0, t1;
   demux2 demux2_0 (i, j2, t0, t1);         // Correct - 4 ports
   demux2 demux2_1 (t0, j1, o[0], o[1]);    // Correct - split into 2 bits
   demux2 demux2_2 (t1, j1, o[2], o[3]);    // Correct - split into 2 bits
   demux2 demux2_3 (t0, j1, o[4], o[5]);    // Correct - split into 2 bits
   demux2 demux2_4 (t1, j1, o[6], o[7]);    // Correct - split into 2 bits
endmodule
*/

module demux8 (
    input wire i,         // Input signal
    input wire j2, j1, j0, // 3-bit select signals
    output wire [0:7] o    // 8 output wires
);
    wire t0, t1;
    demux2 demux2_0 (i, j2, t0, t1);         // Splits to two groups based on j2
    demux4 demux4_0 (t0, j1, j0, o[0:3]);    // Lower 4 outputs (o[0] to o[3])
    demux4 demux4_1 (t1, j1, j0, o[4:7]);    // Upper 4 outputs (o[4] to o[7])
endmodule


module df (input wire clk, in, output wire out);
    reg df_out;
    always @(posedge clk) df_out <= in;
    assign out = df_out;
endmodule

module dfr (input wire clk, reset, in, output wire out);
    wire reset_, df_in;
    assign reset_ = ~reset;  // Directly using NOT operation
    and and2_0 (df_in, in, reset_);
    df df_0 (clk, df_in, out);
endmodule

module dfrl (input wire clk, reset, load, in, output wire out);
    wire _in;
    mux2 mux2_0 (out, in, load, _in);
    dfr dfr_1 (clk, reset, _in, out);
endmodule

