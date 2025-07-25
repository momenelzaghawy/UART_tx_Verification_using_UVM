package UART_seq_item_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"

parameter IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP = 4;

class UART_seq_item extends uvm_sequence_item;
    `uvm_object_utils(UART_seq_item)
    
    bit clk; 
   rand logic reset;
   rand logic [7:0] P_DATA;
   rand logic PAR_EN;
   rand logic PAR_TYP;
   rand logic DATA_VALID;
   rand int pattern_type;
   
    logic TX_OUT , TX_OUT_ex;
    logic Busy , Busy_ex;

    function new(string name = "UART_seq_item");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("%s reset=%b P_DATA=%h PAR_EN=%b PAR_TYP=%b DATA_VALID=%b", 
                        super.convert2string(), reset, P_DATA, PAR_EN, PAR_TYP, DATA_VALID);
    endfunction

    function string convert2string_stimulus();
        return $sformatf("reset=%b P_DATA=%h PAR_EN=%b PAR_TYP=%b DATA_VALID=%b", 
                        reset, P_DATA, PAR_EN, PAR_TYP, DATA_VALID);
    endfunction

  constraint reset_con {reset dist {0 := 3 , 1 := 97};} 
  constraint PAR_TYP_con {PAR_TYP dist {0 := 50 , 1 := 50};} 
  constraint PAR_EN_con {PAR_EN dist{0 := 75 , 1 := 25};} 
  constraint DATA_VALID_con {DATA_VALID dist {0 := 8 , 1 := 92};} ;
  constraint P_DATA_LSB_con {P_DATA[0] dist {0 := 20 , 1:=80};}
  constraint pattern_type_con { pattern_type dist {0 := 96 , 1 := 4 };} 
  constraint P_DATA_con { if (pattern_type) P_DATA inside{8'hFF , 8'h00 , 8'hAA};}

endclass
endpackage
