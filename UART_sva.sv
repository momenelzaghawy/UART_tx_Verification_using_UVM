module UART_sva (UART_if.DUT uartif);
    
    always_comb begin
        if(!uartif.reset)
       assert_reset: assert final ((uartif.TX_OUT)&&(!uartif.Busy)&&(UART.state==uartif.IDLE)&&(UART.counter==0));
        cover_reset:cover final ((uartif.TX_OUT)&&(!uartif.Busy)&&(UART.state==uartif.IDLE)&&(UART.counter==0));
    end
    property no2;
    @(posedge uartif.clk) disable iff(!uartif.reset) 
                       ((UART.state==uartif.IDLE) && (!uartif.DATA_VALID) )|=>
                         (uartif.TX_OUT == 1) && (!uartif.Busy) && (UART.counter == 1'b0) ;
    endproperty
      property no3;
       @(posedge uartif.clk) disable iff(!uartif.reset) 
                       ((UART.state==uartif.IDLE) && (!uartif.DATA_VALID) )|=> (UART.state==uartif.IDLE) ;           
      endproperty
     property no4;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.IDLE)&&(uartif.DATA_VALID) && (uartif.PAR_TYP==0) |=>
                         (UART.PARITY_bit==~^$past(uartif.P_DATA)) && (uartif.Busy) && (UART.DATA_reg==$past(uartif.P_DATA)) &&(UART.state==uartif.START);
    endproperty
     property no5;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.IDLE)&&(uartif.DATA_VALID) && (uartif.PAR_TYP==1) |=>
                         (UART.PARITY_bit==^$past(uartif.P_DATA)) && (uartif.Busy) && (UART.DATA_reg==$past(uartif.P_DATA)) &&(UART.state==uartif.START);
    endproperty

    property no6;
      @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.IDLE)&&(uartif.DATA_VALID) |=> (UART.state==uartif.START);
      endproperty
    property no7;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.START) |=>
                         (uartif.TX_OUT==0) && (UART.state==uartif.DATA) && (UART.counter==0);
    endproperty
    property no8;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        ((UART.state==uartif.DATA) && (UART.counter != 7 )) |=>
                         ((uartif.TX_OUT)==UART.DATA_reg[$past(UART.counter)]) && (UART.counter==$past(UART.counter)+1);
    endproperty
    property no9;
      @(posedge uartif.clk) disable iff(!uartif.reset)
                        ((UART.state==uartif.DATA) && (UART.counter != 7 )) |=> (UART.state==uartif.DATA) ;

      endproperty
    property no10;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.DATA)&&(UART.counter==7)&&(uartif.PAR_EN==1) |=>
                          (UART.state==uartif.PARITY);
    endproperty
    property no11;
    @(posedge uartif.clk) disable iff(!uartif.reset)  
                        (UART.state==uartif.DATA)&&(UART.counter==7)&&(uartif.PAR_EN==0) |=>
                          (UART.state==uartif.STOP);
    endproperty
    property no12;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.PARITY) |=>
                         (uartif.TX_OUT==$past(UART.PARITY_bit)) &&(UART.state==uartif.STOP);
    endproperty
     property no13;
    @(posedge uartif.clk) disable iff(!uartif.reset)
                        (UART.state==uartif.STOP) |=>
                         (uartif.TX_OUT==1) &&(UART.state==uartif.IDLE);
    endproperty

    assert_2:assert property (no2);
    cover_2:cover property (no2);
    assert_3:assert property (no3);
    cover_3:cover property (no3);
    assert_4:assert property (no4);
    cover_4:cover property (no4);
    assert_5:assert property (no5);
    cover_5:cover property (no5);
    assert_6:assert property (no6);
    cover_6:cover property (no6);
    assert_7:assert property (no7);
    cover_7:cover property (no7);
    assert_8:assert property (no8);
    cover_8:cover property (no8);
    assert_9:assert property (no9);
    cover_9:cover property (no9);
    assert_10:assert property (no10);
    cover_10:cover property (no10);
    assert_11:assert property (no11);
    cover_11:cover property (no11);
    assert_12:assert property (no12);
    cover_12:cover property (no12);
    assert_13:assert property (no13);
    cover_13:cover property (no13);

    
endmodule