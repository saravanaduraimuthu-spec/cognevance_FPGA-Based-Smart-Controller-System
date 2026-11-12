module countdown_timer(input wire clk,rst,load,enable,tick,
 input wire [7:0] load_value, output reg [7:0] seconds_left);
always @(posedge clk) begin
 if(rst) seconds_left<=0;
 else if(load) seconds_left<=load_value;
 else if(enable && tick && seconds_left!=0) seconds_left<=seconds_left-1'b1;
end
endmodule
