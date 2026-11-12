module clock_enable #(parameter integer CLK_HZ=100_000_000, TICK_HZ=1)
(input wire clk,rst, output reg tick);
localparam integer DIVISOR=CLK_HZ/TICK_HZ;
localparam integer WIDTH=(DIVISOR<=1)?1:$clog2(DIVISOR);
reg [WIDTH-1:0] count;
always @(posedge clk) begin
 if(rst) begin count<=0; tick<=0; end
 else if(DIVISOR<=1) begin count<=0; tick<=1; end
 else if(count==DIVISOR-1) begin count<=0; tick<=1; end
 else begin count<=count+1'b1; tick<=0; end
end
endmodule
