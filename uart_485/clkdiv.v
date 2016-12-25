`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    clkdiv 
//////////////////////////////////////////////////////////////////////////////////

module clkdiv(clk25, clkout);
input 			clk25;		//系统时钟
output 			clkout;		//采样时钟输出
reg 			clkout;
reg 	[15:0] 	cnt;

initial cnt = 0; //sim
always @(posedge clk25)   //分频进程，每163 clk 为1个clk16
begin
	if(cnt == 16'd81)		//记82 clk
	begin
		clkout 	<= 1'b1;
		cnt 	<= cnt + 16'd1;
	end
	else if(cnt >= 16'd162)	//记81clk
	begin
		clkout 	<= 1'b0;
		cnt 	<= 16'd0;
	end
	else
	begin
		cnt 	<= cnt + 16'd1;
	end
end
endmodule
