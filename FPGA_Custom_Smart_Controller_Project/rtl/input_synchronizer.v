module input_synchronizer(input wire clk,rst,async_in, output reg sync_out);
(* ASYNC_REG="TRUE" *) reg sync_ff1;
always @(posedge clk) begin
 if(rst) begin sync_ff1<=0; sync_out<=0; end
 else begin sync_ff1<=async_in; sync_out<=sync_ff1; end
end
endmodule
