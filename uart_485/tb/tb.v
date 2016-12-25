`timescale 1ns/1ps
module tb;
  
  parameter DATA = 10'b1_0011_0011_0;
  
  reg clk;
  wire baud_clk;
  reg rst;
    
  reg up_rx;
  wire [9:0] tx_data;
  reg [3:0] down_rx;
  
  initial begin
      clk = 0;
  end
  
  always #20 clk = ~clk;
  
  
  assign tx_data = DATA;
  initial begin
      rst = 1;
      up_rx = 0;
      
      #1000
      rst = 0;
      #1000;
      repeat(6) begin
        @(posedge baud_clk)
          up_rx = tx_data[9];
        @(posedge baud_clk)
          up_rx = tx_data[8];
        @(posedge baud_clk)
          up_rx = tx_data[7];
        @(posedge baud_clk)
          up_rx = tx_data[6]; 
        @(posedge baud_clk)
          up_rx = tx_data[5];
        @(posedge baud_clk)
          up_rx = tx_data[4];
        @(posedge baud_clk)
          up_rx = tx_data[3];
        @(posedge baud_clk)
          up_rx = tx_data[2];  
        @(posedge baud_clk)
          up_rx = tx_data[1];
        @(posedge baud_clk)
          up_rx = tx_data[0];        
      end
      
      #2000000; //2ms
      
 	end
 	
 	initial begin
 	    down_rx[0]  = 0;
 	    #2000000 //2ms
      repeat(9) begin
        @(posedge baud_clk)
          down_rx[0] = tx_data[9];
        @(posedge baud_clk)
          down_rx[0] = tx_data[8];
        @(posedge baud_clk)
          down_rx[0] = tx_data[7];
        @(posedge baud_clk)
          down_rx[0] = tx_data[6]; 
        @(posedge baud_clk)
          down_rx[0] = tx_data[5];
        @(posedge baud_clk)
          down_rx[0] = tx_data[4];
        @(posedge baud_clk)
          down_rx[0] = tx_data[3];
        @(posedge baud_clk)
          down_rx[0] = tx_data[2];  
        @(posedge baud_clk)
          down_rx[0] = tx_data[1];
        @(posedge baud_clk)
          down_rx[0] = tx_data[0];        
      end
 	end
 	
 	 	initial begin
 	    down_rx[1]  = 0;
 	    #2000100 //2ms
      repeat(9) begin
        @(posedge baud_clk)
          down_rx[1] = tx_data[9];
        @(posedge baud_clk)
          down_rx[1] = tx_data[8];
        @(posedge baud_clk)
          down_rx[1] = tx_data[7];
        @(posedge baud_clk)
          down_rx[1] = tx_data[6]; 
        @(posedge baud_clk)
          down_rx[1] = tx_data[5];
        @(posedge baud_clk)
          down_rx[1] = tx_data[4];
        @(posedge baud_clk)
          down_rx[1] = tx_data[3];
        @(posedge baud_clk)
          down_rx[1] = tx_data[2];  
        @(posedge baud_clk)
          down_rx[1] = tx_data[1];
        @(posedge baud_clk)
          down_rx[1] = tx_data[0];        
      end
 	end
 	
 	initial begin
 	    down_rx[2]  = 0;
 	    #2000200 //2ms
      repeat(9) begin
        @(posedge baud_clk)
          down_rx[2] = tx_data[9];
        @(posedge baud_clk)
          down_rx[2] = tx_data[8];
        @(posedge baud_clk)
          down_rx[2] = tx_data[7];
        @(posedge baud_clk)
          down_rx[2] = tx_data[6]; 
        @(posedge baud_clk)
          down_rx[2] = tx_data[5];
        @(posedge baud_clk)
          down_rx[2] = tx_data[4];
        @(posedge baud_clk)
          down_rx[2] = tx_data[3];
        @(posedge baud_clk)
          down_rx[2] = tx_data[2];  
        @(posedge baud_clk)
          down_rx[2] = tx_data[1];
        @(posedge baud_clk)
          down_rx[2] = tx_data[0];        
      end
 	end
 	
 	initial begin
 	    down_rx[3]  = 0;
 	    #2000300 //2ms
      repeat(9) begin
        @(posedge baud_clk)
          down_rx[3] = tx_data[9];
        @(posedge baud_clk)
          down_rx[3] = tx_data[8];
        @(posedge baud_clk)
          down_rx[3] = tx_data[7];
        @(posedge baud_clk)
          down_rx[3] = tx_data[6]; 
        @(posedge baud_clk)
          down_rx[3] = tx_data[5];
        @(posedge baud_clk)
          down_rx[3] = tx_data[4];
        @(posedge baud_clk)
          down_rx[3] = tx_data[3];
        @(posedge baud_clk)
          down_rx[3] = tx_data[2];  
        @(posedge baud_clk)
          down_rx[3] = tx_data[1];
        @(posedge baud_clk)
          down_rx[3] = tx_data[0];        
      end
 	end
  
  clkdiv clkdiv(.clk25(clk), .clkout(baud_clk));
  
  uart_test uart_test(
	 .up_rx(up_rx),				
	 .up_tx(),					
	 .up_en(),				
	
	 .down_tx(),			
	 .down_rx(down_rx),			
	 .down_en(),			
	
    .led(),
	

	 .clk25(clk),			
	 .reset_n	(~rst)		

  );
endmodule