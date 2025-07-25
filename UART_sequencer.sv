package UART_sequencer_pkg;
import uvm_pkg::*;
import UART_seq_item_pkg::*;
`include "uvm_macros.svh"

class UART_sequencer extends uvm_sequencer #(UART_seq_item);
    `uvm_component_utils(UART_sequencer);

    function new (string name = "UART_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass

endpackage