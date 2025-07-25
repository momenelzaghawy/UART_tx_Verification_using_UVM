module UART (UART_if.DUT uartif);

    reg [3:0] state = uartif.IDLE;
    reg [3:0] counter = 0;
    reg [7:0] DATA_reg;
    reg  PARITY_bit;
always @(posedge uartif.clk or negedge uartif.reset) begin
    if (!uartif.reset) begin
        state <= uartif.IDLE;
        uartif.TX_OUT <= 1'b1;
        uartif.Busy <= 1'b0;
        counter <= 0;
    end else begin
        case (state)
          uartif.IDLE: begin
                uartif.TX_OUT <= 1'b1;
                uartif.Busy <= 1'b0;
                counter <= 0;
                if (uartif.DATA_VALID) begin
                    DATA_reg <= uartif.P_DATA;
                    PARITY_bit <= (uartif.PAR_TYP == 0) ? ~^uartif.P_DATA : ^uartif.P_DATA;
                    state <= uartif.START;
                    uartif.Busy <= 1'b1;
                end
          end
          uartif.START: begin
                uartif.TX_OUT <= 1'b0;
                state <= uartif.DATA;
                counter <= 0;
          end
          uartif.DATA: begin
                  uartif.TX_OUT <= DATA_reg[counter];
                  counter <= counter + 1;
                  if (counter == 7)
                  state <= (uartif.PAR_EN) ? uartif.PARITY : uartif.STOP;
          end
          uartif.PARITY: begin
                    uartif.TX_OUT <= PARITY_bit;
                    state <= uartif.STOP;
          end
          uartif.STOP: begin
                  uartif.TX_OUT <= 1'b1;
                  state <= uartif.IDLE;
          end
        endcase
        end
end
endmodule