# 64KB RAM Verilog Project

PESU Sem 3: Project for DDCO.

# Team Members

- Nishant Holla - PES1UG23CS401 [Github](https://github.com/nishantHolla)
- Pranav Hemanth - PES1UG23CS433 [Github](https://github.com/Pranavh-2004)
- Aneesh Dutt - PES1UG23CS371 [Github](https://github.com/STRAWBARREL657)
- Nagarjun A H - PES1UG23CS375 [Github](https://github.com/Arjun2453hi)

# Project Overview

This project implements a modular 64KB Random Access Memory (RAM) in Verilog, focusing on simplicity and scalability. It utilizes 16-bit wide registers organized into blocks, along with multiplexers and demultiplexers to effectively simulate RAM behavior.
A comprehensive testbench has been developed to verify the RAM module's basic read and write operations, featuring real-time monitoring of signal changes during simulation. This project serves as an educational resource for understanding memory architecture and Verilog programming.

## Features

- 64KB memory capacity (65536 bytes).
- Supports 8-bit data width.
- Read and write operations controlled by a write enable signal.
- Comprehensive testbench with signal monitoring and waveform generation.

## Modules

### RAM Module (`ram_64kb.v`)

This module implements a simple 64KB RAM structure. It includes:

- **Inputs**:

  - `clk`: Clock signal for synchronization.
  - `address`: 16-bit address bus for accessing memory locations.
  - `data_in`: 8-bit data input for writing to memory.
  - `we`: Write enable signal to control write operations.

- **Output**:
  - `data_out`: 8-bit data output for reading from memory.

### Testbench (`tb_ram_64kb.v`)

The testbench verifies the functionality of the RAM module. It includes:

- Signal initialization and clock generation.
- Write and read operations to test memory functionality.
- Monitoring of key signals during simulation.
- VCD file generation for waveform analysis.

## Usage

To simulate the RAM module and its testbench, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/64kb-ram-verilog.git
   cd 64kb-ram-verilog
   ```
2. **Open your Verilog simulator (e.g., ModelSim, Vivado)**

3. **Compile the modules**:

- Compile both ram_64kb.v and tb_ram_64kb.v.

4. **Run the simulation**:

- Execute the testbench to observe the results in the console and waveform viewer.

5. **View results**:

- Check the console output for monitored signals.
- Open the generated VCD file (tb_ram_64kb.vcd) in a waveform viewer to analyze signal transitions.

## Requirements

To run this project, you need:

- A Verilog simulator (e.g., ModelSim, Vivado).
- Basic knowledge of Verilog syntax and simulation concepts.

# Future Enhancements

- Pipeline Support: Add pipelined architecture to improve read/write speed.
- Write Masking: Enable partial writes to specific bits within a word.
- Dynamic Memory Expansion: Use parameterized Verilog to dynamically scale the memory size.

# License

This project is released under the MIT License. See LICENSE file for more details.
