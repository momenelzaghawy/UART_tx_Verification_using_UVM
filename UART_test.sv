package UART_test_pkg;
import UART_env_pkg::*;
import UART_config_pkg::*;
import UART_seq_pkg::*;
import uvm_pkg::*;
import UART_seq_item_pkg::*;
`include "uvm_macros.svh"

class UART_test extends uvm_test;
    `uvm_component_utils(UART_test)

    UART_env env;
    UART_config UART_cfg;
    virtual UART_if UART_vif;
    UART_main_seq main_seq;
    UART_reset_seq reset_seq;

    function new(string name = "UART_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = UART_env::type_id::create("env", this);
        UART_cfg = UART_config::type_id::create("UART_cfg");
        main_seq = UART_main_seq::type_id::create("main_seq");
        reset_seq = UART_reset_seq::type_id::create("reset_seq");

        UART_cfg.is_active = UVM_ACTIVE;

        if (!uvm_config_db#(virtual UART_if)::get(this, "", "UART_IF", UART_cfg.UART_vif))
            `uvm_fatal("build_phase", "test - unable to get the virtual interface");

        uvm_config_db#(UART_config)::set(this, "*", "CFG", UART_cfg);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);

       
        `uvm_info("run_phase", "reset asserted", UVM_LOW)
        reset_seq.start(env.agt.sqr);
        `uvm_info("run_phase", "reset deasserted", UVM_LOW)

       
        `uvm_info("run_phase", "stimulus generation started 1", UVM_LOW)
        main_seq.start(env.agt.sqr);
        `uvm_info("run_phase", "stimulus generation ended 1", UVM_LOW)

        
        `uvm_info("run_phase", "reset asserted", UVM_LOW)
        reset_seq.start(env.agt.sqr);
        `uvm_info("run_phase", "reset deasserted", UVM_LOW)

        phase.drop_objection(this);
    endtask

endclass
endpackage