`timescale 10ns / 1ps

module eval_module_tb;

reg clk;
reg rst;
reg kernel_enable;
reg [7:0]	data_in1;
reg [7:0]	data_in2;

wire [7:0]  result;

eval_module UUT(
.clk(clk),
.rst(rst),
.kernel_enable(kernel_enable),
.data_in1(data_in1),
.data_in2(data_in2)
);

initial 
begin
 clk =1;
 rst =0;
 kernel_enable= 1;
 data_in1= 3;
 data_in2= 4;
 #10;
end
 always clk = #10 ~clk;
		
endmodule