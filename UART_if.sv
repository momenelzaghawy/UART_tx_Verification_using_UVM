interface UART_if (clk);
    input bit clk;
    logic reset;
    logic [7:0] P_DATA;
    logic PAR_EN;
    logic PAR_TYP;
    logic DATA_VALID;
    logic TX_OUT , TX_OUT_ex;
    logic Busy , Busy_ex;

    parameter IDLE = 0, START = 1, DATA = 2, PARITY = 3, STOP = 4;

    modport DUT ( input clk , reset , P_DATA , PAR_EN , PAR_TYP , DATA_VALID ,
                  output TX_OUT , Busy);
    
    modport GOLDEN ( input clk , reset , P_DATA , PAR_EN , PAR_TYP , DATA_VALID ,
                  output TX_OUT_ex , Busy_ex);

    modport TEST ( output  reset , P_DATA , PAR_EN , PAR_TYP , DATA_VALID ,
                   input clk ,TX_OUT , Busy , TX_OUT_ex , Busy_ex);
    
    modport MONITOR ( output clk , reset , P_DATA , PAR_EN , PAR_TYP , DATA_VALID , TX_OUT , Busy ,TX_OUT_ex , Busy_ex);
endinterface 

