# MIPS32 Pipeline Processor
## Introduction
The MIPS32 Pipeline Processor project demonstrates the design and implementation of a MIPS32 architecture with a five-stage pipeline. This processor effectively handles instruction execution by dividing it into five distinct stages: Instruction Fetch, Instruction Decode, Execute, Memory Access, and Write Back. By implementing these stages, the processor can achieve higher instruction throughput compared to a single-cycle processor.  
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
## References
_Digital Design and Computer Architecture_ by David Money Harris & Sarah L. Harris
