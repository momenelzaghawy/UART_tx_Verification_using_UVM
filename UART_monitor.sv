package UART_monitor_pkg;
import uvm_pkg::*;
import UART_seq_item_pkg::*;
`include "uvm_macros.svh"

class UART_monitor extends uvm_monitor;
    `uvm_component_utils(UART_monitor)
    
    virtual UART_if UART_vif;
    UART_seq_item rsp_seq_item;
    uvm_analysis_port #(UART_seq_item) mon_ap;

    function new (string name = "UART_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        mon_ap = new("mon_ap", this);
    endfunction
    
    task run_phase (uvm_phase phase);
        super.run_phase(phase);
        forever begin
            rsp_seq_item = UART_seq_item::type_id::create("rsp_seq_item");
            @(posedge UART_vif.clk);
            
            rsp_seq_item.reset = UART_vif.reset;
            rsp_seq_item.P_DATA = UART_vif.P_DATA;
            rsp_seq_item.PAR_EN = UART_vif.PAR_EN;
            rsp_seq_item.PAR_TYP = UART_vif.PAR_TYP;
            rsp_seq_item.DATA_VALID = UART_vif.DATA_VALID;

            mon_ap.write(rsp_seq_item);
            `uvm_info("run_phase", rsp_seq_item.convert2string_stimulus(), UVM_HIGH)
        end
    endtask
endclass

endpackage