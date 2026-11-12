module config_rom(input wire [1:0] profile, output reg [7:0] duration_seconds);
always @* case(profile)
 2'b00: duration_seconds=8'd5;
 2'b01: duration_seconds=8'd10;
 2'b10: duration_seconds=8'd20;
 2'b11: duration_seconds=8'd30;
 default: duration_seconds=8'd5;
endcase
endmodule
