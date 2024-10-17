# 64KB RAM Verilog Project

PESU Sem 3: Project for DDCO.

# Team Members

- Nishant Holla - PES1UG23CS401 [Github](https://github.com/nishantHolla)
- Pranav Hemanth - PES1UG23CS433 [Github](https://github.com/Pranavh-2004)
- Aneesh Dutt - PES1UG23CS371 [Github](https://github.com/STRAWBARREL657)
- Nagarjun A H - PES1UG23CS375 [Github](https://github.com/Arjun2453hi)

# Project Overview

This project implements a 64KB Random Access Memory (RAM) using Verilog. It provides a modular design consisting of register-based storage elements, multiplexers, and demultiplexers, which together mimic the behavior of RAM. The design focuses on simplicity and scalability by using 16-bit wide registers grouped into multiple blocks.

# System Architecture

The 64KB RAM is built using the following components:

1. Registers (dfrl_16):
   • Each register stores 16 bits.
   • Includes features like reset, load, and clocked input to update values.
2. Register File (reg_file):
   • Consists of 8 registers, each 16-bits wide, which together form 8 words of 16 bits.
   • Allows two simultaneous reads and one write.
3. Multiplexers and Demultiplexers:
   • mux8_16: Used for reading from one of the registers.
   • demux8: Controls which register receives the data during writes.
4. Scaling the Design to 64KB:
   • The 64KB RAM requires 4096 words, each of 16 bits.
   • This design will use 512 instances of reg_file (8 × 512 = 4096 words).
   • Additional multiplexers and demultiplexers will manage read and write operations across the 512 blocks.

# Module Descriptions

1. dfrl_16:

- Implements a 16-bit register with:
- Clock input for synchronous operations.
- Reset input to initialize the register to 0.
- Load signal to enable writing data into the register.

2. reg_file:

- Contains 8 registers of 16-bit width.
- Supports two simultaneous reads and one write.
- Uses multiplexers for reading and demultiplexers for writing.

3. mux8_16 and demux8:

- Control the selection of registers for read and write operations.

4. top_module:

- Scales up the design to 64KB RAM by combining multiple reg_file blocks.
- Adds additional control logic for addressing the memory blocks.

# Usage and Testing

1. Writing Data:

- Provide the write address, data input, and write enable signal to write data into the selected address.

2. Reading Data:

- Provide the read address to read data from the desired memory location.
- The design supports simultaneous reading from two addresses.

3. Reset Operation:

- When the reset signal is activated, all memory locations are initialized to 0.

# Future Enhancements

- Pipeline Support: Add pipelined architecture to improve read/write speed.
- Write Masking: Enable partial writes to specific bits within a word.
- Dynamic Memory Expansion: Use parameterized Verilog to dynamically scale the memory size.

# License

This project is released under the MIT License. See LICENSE file for more details.
