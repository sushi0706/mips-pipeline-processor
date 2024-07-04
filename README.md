# MIPS32 Pipeline Processor
## Introduction
This project is an implementation of a MIPS32 pipeline processor, designed to illustrate the concepts of pipelining in computer architecture. The processor is capable of executing a set of MIPS32 instructions across five pipeline stages: Instruction Fetch, Instruction Decode, Execute, Memory Access, and Write Back.  
## Implementation
### Stages
1. Instruction Fetch (IF)    
2. Instruction Decode (ID)  
3. Execute (EX)  
4. Memory Access (MEM)  
5. Write Back (WB)
### Instruction Set
The MIPS32 pipeline processor currently supports the following instructions:  
* `add` - Add  
* `sub` - Subtract  
* `or` - Bitwise OR  
* `and` - Bitwise AND  
* `slt` - Set Less Than  
* `addi` - Add Immediate  
* `lw` - Load Word  
* `sw` - Store Word  
* `beq` - Branch if Equal  
* `j` - Jump
### Datapath
![image](https://github.com/sushi0706/mips-pipeline-processor/assets/170224108/42be59ee-724e-446d-8359-7eaf3874ca5b)  
## Tools
* Verilog compiler (such as Icarus Verilog)  
* Simulator (such as Modelsim)
## Reference
_Digital Design and Computer Architecture_ by David Money Harris & Sarah L. Harris
