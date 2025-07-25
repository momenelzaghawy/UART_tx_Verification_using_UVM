package UART_agent_pkg;
import UART_driver_pkg::*;
import UART_monitor_pkg::*;
import UART_sequencer_pkg::*;
import UART_seq_item_pkg::*;
import UART_config_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class UART_agent extends uvm_agent;
    `uvm_component_utils(UART_agent)
    
    UART_sequencer sqr;
    UART_driver drv;
    UART_monitor mon;
    UART_config UART_cfg;
    uvm_analysis_port #(UART_seq_item) agt_ap;

    function new (string name = "UART_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(UART_config)::get(this, "", "CFG", UART_cfg))
            `uvm_fatal("build_phase", "test - unable to get the configuration");
            
        if (UART_cfg.is_active == UVM_ACTIVE) begin
            sqr = UART_sequencer::type_id::create("sqr", this);
            drv = UART_driver::type_id::create("drv", this);
        end
        mon = UART_monitor::type_id::create("mon", this);
        agt_ap = new("agt_ap", this);
    endfunction
        function void connect_phase(uvm_phase phase);
        mon.UART_vif = UART_cfg.UART_vif;
        mon.mon_ap.connect(agt_ap);
        if (UART_cfg.is_active == UVM_ACTIVE) begin
            drv.UART_vif = UART_cfg.UART_vif;
            drv.seq_item_port.connect(sqr.seq_item_export);
        end
    endfunction
endclass
endpackage