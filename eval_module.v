
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
	    
	    output reg [7:0] result;
	    
		wire [3:0] address =	data_in1[3:0];
		wire [7:0] rom_out;
		wire [7:0] flipped = 	~(data_in2);
		
	    reg [7:0]  L1_flipped, L1_data_in1, L2_flipped, L2_rom_out;
	    
		rom_memory rom(.address(address),.data(rom_out));
	
		always@(posedge clk)
		begin
			if(rst)
			begin
				result <=	8'd0;
			end
			else
			begin
			
		       L1_data_in1 <= data_in1;
		       L1_flipped <= flipped;  //assigning values to registers for buffer for 1st adder
		       
		       L2_flipped <= flipped;
		       L2_rom_out <= rom_out;  //assigning values to registers for buffer for 2nd adder
		       
	    
				if(kernel_enable)
				begin
				   result <=  L2_rom_out + L2_flipped +data_in1;
				 end
				else	
					result <=	L1_flipped + L1_data_in1;
			end
		end
endmodule