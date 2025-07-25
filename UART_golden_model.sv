module UART_golden_model(UART_if.GOLDEN uartif);
    reg [3:0] counter = 0;
    reg [7:0] DATA_reg;
    reg  PARITY_bit; 
    reg [3:0]cs,ns;
   // cs state
   always @(posedge uartif.clk , negedge uartif.reset)begin
         if (!uartif.reset) begin
            cs <= uartif.IDLE;
            counter <= 0;
         end
        else
            cs <= ns;
   end
   //ns state
     always @(*)begin
            case(cs)
                uartif.IDLE : begin
                            if (uartif.DATA_VALID) begin
                            ns = uartif.START;
                          end
                        end
                uartif.START  : ns = uartif.DATA;
                uartif.DATA   :begin
                  if (counter == 7)
                  ns = (uartif.PAR_EN) ? uartif.PARITY : uartif.STOP;
          end
                uartif.PARITY : ns = uartif.STOP;
                uartif.STOP   : ns = uartif.IDLE;
                default : ns = uartif.IDLE;
            endcase   
     end
     //output
    always @(posedge uartif.clk , negedge uartif.reset) begin
       if (!uartif.reset) begin
            uartif.TX_OUT_ex <= 1'b1;
            uartif.Busy_ex <= 1'b0;
            counter <= 0;
         end
         else begin
        case (cs)
          uartif.IDLE: begin
                uartif.TX_OUT_ex <= 1'b1;
                uartif.Busy_ex <= 1'b0;
                counter <= 0;
                if (uartif.DATA_VALID) begin
                    DATA_reg <= uartif.P_DATA;
                    PARITY_bit <= (uartif.PAR_TYP == 0) ? ~^uartif.P_DATA : ^uartif.P_DATA;
                    uartif.Busy_ex <= 1'b1;
                end
          end
          uartif.START: begin
                uartif.TX_OUT_ex <= 1'b0;
                counter <= 0;
          end
          uartif.DATA: begin
                  uartif.TX_OUT_ex <= DATA_reg[counter];
                  counter <= counter + 1;
          end
          uartif.PARITY: begin
                    uartif.TX_OUT_ex <= PARITY_bit;
          end
          uartif.STOP: begin
                  uartif.TX_OUT_ex <= 1'b1;
          end
        endcase
         end
    end
endmodule