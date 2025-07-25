package UART_driver_pkg;
import uvm_pkg::*;
import UART_seq_item_pkg::*;
`include "uvm_macros.svh"

class UART_driver extends uvm_driver #(UART_seq_item);
    `uvm_component_utils(UART_driver)

    virtual UART_if UART_vif;
    UART_seq_item stim_seq_item;

    function new(string name = "UART_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            stim_seq_item = UART_seq_item::type_id::create("stim_seq_item");
            seq_item_port.get_next_item(stim_seq_item);
            
            UART_vif.reset = stim_seq_item.reset;
            UART_vif.P_DATA = stim_seq_item.P_DATA;
            UART_vif.PAR_EN = stim_seq_item.PAR_EN;
            UART_vif.PAR_TYP = stim_seq_item.PAR_TYP;
            UART_vif.DATA_VALID = stim_seq_item.DATA_VALID;

            @(negedge UART_vif.clk);
            seq_item_port.item_done();
            `uvm_info("run_phase", stim_seq_item.convert2string_stimulus(), UVM_HIGH)
        end
    endtask
endclass
endpackage
