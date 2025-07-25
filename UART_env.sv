package UART_env_pkg;
import UART_agent_pkg::*;
import UART_scoreboard_pkg::*;
import UART_coverage_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class UART_env extends uvm_env;
    `uvm_component_utils(UART_env)

    UART_agent agt;
    UART_scoreboard sb;
    UART_coverage cov;

    function new(string name = "UART_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = UART_agent::type_id::create("agt", this);
        sb = UART_scoreboard::type_id::create("sb", this);
        cov = UART_coverage::type_id::create("cov", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        agt.agt_ap.connect(sb.sb_export);
        agt.agt_ap.connect(cov.cov_export);
    endfunction
endclass
endpackage