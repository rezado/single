onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib IR_opt

do {wave.do}

view wave
view structure
view signals

do {IR.udo}

run -all

quit -force
