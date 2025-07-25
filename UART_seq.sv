package UART_seq_pkg;
import uvm_pkg::*;
import UART_seq_item_pkg::*;
`include "uvm_macros.svh"

class UART_reset_seq extends uvm_sequence #(UART_seq_item);
    `uvm_object_utils(UART_reset_seq)
    UART_seq_item seq_item;

    function new(string name = "UART_reset_seq");
        super.new(name);
    endfunction

    task body;
        seq_item = UART_seq_item::type_id::create("seq_item");
        start_item(seq_item);
        seq_item.reset = 0; 
        seq_item.P_DATA = 0; 
        seq_item.PAR_EN = 0; 
        seq_item.PAR_TYP = 0; 
        seq_item.DATA_VALID = 0; 
        finish_item(seq_item);
    endtask
endclass

class UART_main_seq extends uvm_sequence #(UART_seq_item);
    `uvm_object_utils(UART_main_seq)
    UART_seq_item seq_item;

    function new(string name = "UART_main_seq");
        super.new(name);
    endfunction

    task body;
        seq_item = UART_seq_item::type_id::create("seq_item");
        repeat (1000) begin
            start_item(seq_item);
            assert(seq_item.randomize());
            finish_item(seq_item);
        end
    endtask
endclass
endpackage

    