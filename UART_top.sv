import uvm_pkg::*;
`include "uvm_macros.svh"
import UART_test_pkg::*;

module UART_top();

bit clk;

initial begin
    forever begin
        #1 clk = ~clk;
    end
end

UART_if uartif (clk);
UART dut (uartif);
UART_golden_model GM (uartif);
bind UART UART_sva UART_sva_inst(uartif); 

initial begin
    uvm_config_db#(virtual UART_if)::set(null, "uvm_test_top", "UART_IF", uartif);
    run_test("UART_test");
end

endmodule