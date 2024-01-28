# Compilation.....
vlog tb.v
vsim -novopt dual_port_ram_tb -suppress 12110
add wave -position insertpoint sim:/dual_port_ram_tb/dut/*
run -all
