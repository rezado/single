vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/blk_mem_gen_v8_3_3

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap blk_mem_gen_v8_3_3 msim/blk_mem_gen_v8_3_3

vlog -work xil_defaultlib -64 -sv \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work blk_mem_gen_v8_3_3 -64 \
"../../../ipstatic/blk_mem_gen_v8_3_3/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib -64 \
"../../../../single.srcs/sources_1/ip/IR/sim/IR.v" \

vlog -work xil_defaultlib "glbl.v"

