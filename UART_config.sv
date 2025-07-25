package UART_config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

class UART_config extends uvm_object;
    `uvm_object_utils(UART_config)
    
    virtual UART_if UART_vif;
    uvm_active_passive_enum is_active;

    function new(string name = "UART_config");
        super.new(name);
    endfunction
endclass
endpackage