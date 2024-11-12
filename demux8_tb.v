`timescale 1ns / 1ps

module tb_demux2;
    reg input_signal;
    reg select;
    wire output_0;
    wire output_1;

    // Instantiate the demultiplexer
    demux2 uut (
        .i(input_signal),
        .j(select),
        .o0(output_0),
        .o1(output_1)
    );

    initial begin
        // Monitor outputs
        $monitor("Time=%0t | Input=%b | Select=%b | Output_0=%b | Output_1=%b", 
                 $time, input_signal, select, output_0, output_1);

        // Test case 1
        input_signal = 1; select = 0; #10; // Expect Output_0 = 1, Output_1 = 0
        // Test case 2
        input_signal = 1; select = 1; #10; // Expect Output_0 = 0, Output_1 = 1
        // Test case 3
        input_signal = 0; select = 0; #10; // Expect Output_0 = 0, Output_1 = 0
        // Test case 4
        input_signal = 0; select = 1; #10; // Expect Output_0 = 0, Output_1 = 0

        $finish;
    end
endmodule