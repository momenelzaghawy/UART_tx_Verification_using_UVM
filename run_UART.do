vlib work
vlog -f src_files_UART.list
vsim -voptargs=+acc work.UART_top -classdebug -uvmcontrol=all
add wave /UART_top/uartif/*
run -all