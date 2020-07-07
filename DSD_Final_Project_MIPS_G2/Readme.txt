//------------------------Essentials------------------------//
We have added an NOP instruction (0x60) to I_mem_BrPred. The testbench adjustment was approved by TA Winken Beh in the private group, DSD Spring 2020, on Facebook.

All *.v files in every rtl/ folder are essential for rtl simulation, when simulating, please put them with CHIP.v in the same directory.

//-------------------------Simulation commands------------------------//
- Baseline (no hazard):
	- RTL: ncverilog Final_tb.v CHIP.v cache_dm.v slow_memory.v +define+noHazard +access+r
	-syn: ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +define+noHazard +define+SDF +access+r (clk: 4.57)

- Baseline (has hazard):
	- RTL: ncverilog Final_tb.v CHIP.v cache_dm.v slow_memory.v +define+hasHazard +access+r
	-syn: ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +define+hasHazard +define+SDF +access+r (clk: 4.47)

-Extension (branch prediction):
	-RTL: ncverilog Final_tb.v CHIP.v cache_dm.v slow_memory.v +define+BrPred +access+r
	-syn: ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +define+BrPred +define+SDF +access+r

-Extension (L2 cache):
	-RTL: ncverilog Final_tb.v CHIP.v cache_dm.v slow_memory.v +define+L2Cache +access+r
	-syn: ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +define+L2Cache +define+SDF +access+r

-Extension (multiplication & division):
	-RTL: ncverilog Final_tb.v CHIP.v cache_dm.v slow_memory.v +define+MultDiv +access+r
	-syn: ncverilog Final_tb.v CHIP_syn.v slow_memory.v tsmc13.v +define+MultDiv +define+SDF +access+r (clk: 4.21)