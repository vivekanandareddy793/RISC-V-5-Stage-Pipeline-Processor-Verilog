# RISC-V 5-Stage Pipelined Processor using Verilog

## Overview

A complete implementation of a **32-bit RISC-V 5-Stage Pipelined Processor** written in **Verilog HDL**. The processor is designed using the classic five-stage pipeline architecture to improve instruction throughput by executing multiple instructions simultaneously.

The design includes dedicated pipeline registers, forwarding logic, hazard detection, stalling, and flush mechanisms to ensure correct execution of dependent and control-flow instructions.

The processor supports a subset of the **RV32I instruction set** and has been functionally verified using a comprehensive Verilog testbench. Simulation was carried out using **Icarus Verilog**, and waveform analysis was performed using **GTKWave**.


## Project Overview

This project implements a modular **32-bit RISC-V 5-Stage Pipeline Processor** consisting of the standard pipeline stages:

- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory Access (MEM)
- Write Back (WB)

The processor demonstrates:

- Instruction-level Parallelism (ILP)
- Pipeline Execution
- Data Forwarding
- Hazard Detection
- Pipeline Stalling
- Pipeline Flushing
- Register File Operations
- ALU Execution
- Memory Access Operations

The modular design makes the processor easy to understand, simulate, and extend with additional RISC-V instructions.


## Pipeline Architecture

Instruction Fetch (IF)
        │
        ▼
Instruction Decode (ID)
        │
        ▼
Execute (EX)
        │
        ▼
Memory Access (MEM)
        │
        ▼
Write Back (WB)

### Instruction Fetch (IF)

- Program Counter (PC)
- Instruction Memory
- Next PC Generation

### Instruction Decode (ID)

- Instruction Decoding
- Register File Access
- Immediate Generation
- Control Signal Generation

### Execute (EX)

- ALU Operations
- Branch Target Calculation
- Operand Forwarding

### Memory Access (MEM)

- Load Operations
- Store Operations
- Memory Interface

### Write Back (WB)

- Register Write-Back
- Result Selection

Pipeline registers (**IF/ID, ID/EX, EX/MEM, MEM/WB**) are implemented between every stage to support pipelined execution.


## Features

- 32-bit RV32I Processor
- 5-Stage Pipeline Architecture
- Modular Verilog RTL Design
- Program Counter (PC)
- Instruction Memory
- Register File
- ALU
- ALU Control
- Immediate Generator
- Control Unit
- Pipeline Registers
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- Hazard Detection Unit
- Data Forwarding Unit
- Stall Control Logic
- Flush Logic
- Complete Verilog Testbench
- Functional Simulation using Icarus Verilog
- Waveform Verification using GTKWave


## Supported Instructions

The processor currently supports the following **RV32I** instructions.

### R-Type Instructions

- add
- sub
- and
- or
- xor
- slt

### I-Type Instructions

- addi
- andi
- ori
- xori
- slti

### Memory Instructions

- lw
- sw

### Branch Instructions

- beq
- bne

### Jump Instructions

- jal
- jalr

### Upper Immediate Instructions

- lui
- auipc


## Design Highlights

- Classic five-stage pipelined processor
- Modular RTL implementation
- Efficient data forwarding to reduce stalls
- Hazard Detection Unit for load-use hazards
- Stall generation for unresolved dependencies
- Flush mechanism for branch/jump instructions
- Clear separation of datapath and control path
- Easily extensible architecture for additional instructions


## Verification

The processor has been verified using a custom Verilog testbench.

Verification includes:

- Arithmetic Instructions
- Logical Instructions
- Immediate Instructions
- Load/Store Operations
- Branch Instructions
- Jump Instructions
- Data Hazards
- Pipeline Forwarding
- Pipeline Stalls
- Flush Operations

Register values and processor behavior were validated through simulation waveforms using **GTKWave**.


## Tools & Technologies

- Verilog HDL
- Icarus Verilog
- GTKWave
- Visual Studio Code


## Future Improvements

- Complete RV32I Instruction Support
- Branch Prediction Unit
- Cache Memory Integration
- Performance Analysis (CPI and Speedup)
- Exception and Interrupt Handling
- RTL-to-GDSII Physical Design Flow
