#You may modified the clock constraints 
#or add more constraints for your design
####################################################
set cycle  10
set_max_area 0 
####################################################


#The following are design spec. for synthesis
#You can NOT modify this seciton 
#####################################################
create_clock -name CLK -period $cycle [get_ports clk]
set_fix_hold                          [get_clocks CLK]
set_dont_touch_network                [get_clocks CLK]
set_ideal_network                     [get_ports clk]
set_clock_uncertainty            0.1  [get_clocks CLK] 
set_clock_latency                0.5  [get_clocks CLK] 

set_max_fanout 6 [all_inputs] 

set_operating_conditions -min_library fast -min fast -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow  
set_drive        1     [all_inputs]
set_load         1     [all_outputs]
set t_in   0.3
set t_out  0.3
set_input_delay  $t_in  -clock CLK [remove_from_collection [all_inputs] [get_ports clk]]
set_output_delay $t_out -clock CLK [all_outputs]
#####################################################


#Compile and save files
#####################################################
compile_ultra
write_sdf -version 2.1 cache_2way_syn.sdf
write -format verilog -hier -output cache_2way_syn.v
write -format ddc     -hier -output cache_2way_syn.ddc
#####################################################