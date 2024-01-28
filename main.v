`timescale 1ns / 1ps
module dual_port_ram (
    input clk,
    input write_enable_A,
    input write_enable_B,
    input [7:0] data_in_A,
    input [7:0] data_in_B,
    input [7:0] address_A,
    input [7:0] address_B,
    input reset,
    output reg [7:0] data_out_A,
    output reg [7:0] data_out_B
);

reg [7:0] mem [7:0];
integer count='d0;
integer i=0;
integer j=0;
reg [2:0] database [7:0];


always @(posedge clk or posedge reset) begin
	if(reset==1'b1) begin
		data_out_A<=8'd0;
		data_out_B<=8'd0;
	end
	else if(reset==1'b0) begin

		if (address_A<8) begin
			if (write_enable_A==1'b1 ) begin
				if (count<8) begin
					mem[address_A] <= data_in_A;
					database[count]<=address_A;
					count=count+1;
				end
				else $display("the memory is full");
			end
			else if (write_enable_A==1'b0) begin
				data_out_A = mem[address_A];
			end
		end

		else if(address_A>8) $display("address is out of range at time %t",$time);

		if(address_B<8) begin
			if (write_enable_B==1'b1) begin
				if (count<8) begin
					mem[address_B] <= data_in_B;
					database[count]<=address_B;
					count=count+1;
				end
				else $display("the memory is full");
			end
			else if (write_enable_B==1'b0) begin
				data_out_B = mem[address_B];
			end
		end

		else if (address_B>8) $display("address is out of range at time %t",$time);
	end
end

always@(database) begin

	for(i=0;i<8;i=i+1) begin

		for(j=i;j<8;j=j+1) begin
			if(database[i]==database[j+1]) begin
				count=count-1;
			end
		end
	end
end
endmodule
