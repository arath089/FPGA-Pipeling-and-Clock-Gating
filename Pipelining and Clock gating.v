
`timescale 1ns / 1ps


	module rom_memory(address, data);
	
		input [3:0] address;
		output [7:0] data;
	
		assign data = 	(address == 4'd0)	?	8'd57:
						(address == 8'd1)	?	8'd61:
						(address == 8'd2)	?	8'd22:
						(address == 8'd3)	?	8'd98:
						(address == 8'd4)	?	8'd121:
						(address == 8'd5)	?	8'd17:
						(address == 8'd6)	?	8'd13:
												8'd3;
	endmodule


	module eval_module(clk, rst, data_in1, data_in2, result, kernel_enable);
	
		input clk, rst;
	
		input [7:0]	data_in1;
		input [7:0]	data_in2;
		
		input kernel_enable;
	    reg [7:0] L1_rom_out, L1_flipped;
		output reg [7:0] result;
	
		wire [3:0] address =	data_in1[3:0];
		
		wire [7:0] rom_out;
		wire [7:0] flipped = 	~(data_in2);
		
	    
		rom_memory rom(.address(address),.data(rom_out));
	
		always@(posedge clk)
		begin
			if(rst)
			begin
				result <=	8'd0;
			end
			else
			begin
			
		       L1_rom_out <= rom_out;
		       L1_flipped <= flipped;
	    
				if(kernel_enable)
					   
				   result <=	L1_rom_out + L1_flipped + data_in1;
				 
				else	
					result <=	flipped + data_in1;
			end
		end
endmodule