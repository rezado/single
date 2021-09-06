onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib DR_opt

do {wave.do}

view wave
view structure
view signals

do {DR.udo}

run -all

quit -force
