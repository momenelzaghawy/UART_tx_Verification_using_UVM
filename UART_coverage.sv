
package UART_coverage_pkg;
import UART_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class UART_coverage extends uvm_component;
    `uvm_component_utils(UART_coverage)
    
    uvm_analysis_export #(UART_seq_item) cov_export;
    uvm_tlm_analysis_fifo #(UART_seq_item) cov_fifo;
    UART_seq_item seq_item_cov;

      covergroup cvr_gp ;
  reset_cp : coverpoint seq_item_cov.reset { 
    bins zero = {0} ;
    bins one = {1} ;}
  PAR_TYP_cp : coverpoint seq_item_cov.PAR_TYP { 
    bins zero = {0} ;
    bins one = {1} ;}
  PAR_EN_cp : coverpoint seq_item_cov.PAR_EN { 
    bins zero = {0} ;
    bins one = {1} ;}
  P_DATA_cp : coverpoint seq_item_cov.P_DATA {
    bins all_values = {[0:255]};} 
  DATA_VALID_cp : coverpoint seq_item_cov.DATA_VALID { 
    bins zero = {0} ;
    bins one = {1} ;}
  TX_OUT_cp : coverpoint seq_item_cov.TX_OUT {
    bins zero = {0} ;
    bins one = {1} ;}
  Busy_cp : coverpoint seq_item_cov.Busy {
    bins zero = {0} ;
    bins one = {1} ;}
  PAR_EN_TYPE_cross : cross PAR_EN_cp , PAR_TYP_cp ;
  P_DATA_DATA_VALID_cross : cross P_DATA_cp , DATA_VALID_cp ;
  TX_OUT_Busy_cross : cross TX_OUT_cp , Busy_cp ;
  
  endgroup

    function new(string name = "UART_coverage", uvm_component parent = null);
        super.new(name, parent);
        cvr_gp = new();
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cov_export = new("cov_export", this);
        cov_fifo = new("cov_fifo", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cov_export.connect(cov_fifo.analysis_export);
    endfunction

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            cov_fifo.get(seq_item_cov);
            cvr_gp.sample();
        end
    endtask
endclass
endpackage

