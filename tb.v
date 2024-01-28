`include "main.v"
module dual_port_ram_tb;

reg clk;
reg write_enable_A;
reg write_enable_B;
reg [7:0] data_in_A;
reg [7:0] data_in_B;
reg [7:0] address_A;
reg [7:0] address_B;
wire [7:0] data_out_A;
wire [7:0] data_out_B;
reg reset;

dual_port_ram dut (
    .clk(clk),
    .write_enable_A(write_enable_A),
    .write_enable_B(write_enable_B),
    .data_in_A(data_in_A),
    .data_in_B(data_in_B),
    .address_A(address_A),
    .address_B(address_B),
    .data_out_A(data_out_A),
    .data_out_B(data_out_B),
    .reset(reset)
);
initial begin
	{data_in_A,data_in_B,address_A,address_B,write_enable_A,write_enable_B,reset}=0;
end

initial begin
// this is checking 
// ** two parallel access at different location
// ** and memory full condition
    clk = 0;
    write_enable_A = 1;
    write_enable_B = 1;
    data_in_A = 4'hF;
    data_in_B = 4'h0;
    address_A = 3'b000;
    address_B = 3'b001;

    #10;
    write_enable_A = 0;
    write_enable_B = 0;

    #10;
    write_enable_A = 1;
    write_enable_B = 1;
    address_A = 5'b00010;
    data_in_A = 4'h5;
    address_B = 3'b011;
    data_in_B = 4'hA;
  
    #10;
    write_enable_A = 0;
    write_enable_B = 0;
    reset=1;


    #10;
    write_enable_A = 1;
    write_enable_B = 1;
    address_A = 3'b100; 
    address_B = 3'b101;

    #10;
    write_enable_A = 0;
    write_enable_B = 0;

    reset=0;
    #10;
    write_enable_A=1;
    write_enable_B=1;
    address_A = 3'b110;
    address_B = 3'b111;
    
    #10;
    write_enable_A = 0;
    write_enable_B = 0;

    #10;

    write_enable_A=1;
    write_enable_B=1;
    address_A = 3'b110;
    data_in_B = 3'b111;
   #10;
    $stop;

end

/*
initial begin
	//this is checking
	//when memory is out of range
    clk=0;
    write_enable_A=1;
    write_enable_B=1;
    data_in_A = 4'h7;
    data_in_B = 4'hB;
    address_A=4'd5;
    address_B=8'd13;

    #10;
    write_enable_A=0;
    write_enable_B=0;

#10;
$stop;
end
*/

/*
initial begin

	clk=0;
	write_enable_A=1;
	data_in_A=3'b111;
	address_A=$urandom_range(0,7);

	#10;
	
	write_enable_A=1;
	write_enable_B=0;
	address_B=address_A;
	#10;
	reset=1;

	#10
	


	#10;
	$stop;







end
*/




initial forever #5 clk=~clk;
 

endmodule
