`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    uart_test_20161219 
//////////////////////////////////////////////////////////////////////////////////
module uart_test(
	//485 ��λ��
	input   up_rx,					//��λ����������
	output  up_tx,					//��λ����������
	output reg up_en,					//��λ��ͨ��ʹ��
	
	//485_1 ��
	output	[3:0] down_tx,			//�ӻ���������
	input	[3:0] down_rx,			//������������
	output  [3:0] down_en,			//�ӻ�ͨ��ʹ��
	
	//led
	output [3:0]  led,
	
	//clk & reset
	input			clk25,			//25MHzϵͳ��ʱ��
//	input           band_clk,   	//9600������ʱ��
	input         	reset_n			//ϵͳ��λ�ź�

);

	parameter	UP_BYTE_WIDTH = 6;		//��λ�������ֽڿ��
	parameter	DOWN_BYTE_WIDTH = 9;	//�ӻ������ֽڿ��
	
	reg up_valid;		//��λ�����������ж��ź�
	reg rxbuf;
	reg rxfall;			//��λ���������ݿ�ʼ�ź�
	reg up_end;			//��λ���������ݽ����ź�
	reg [31:0] up_wait_t;		//��λ���������ݵȴ�ʱ�������
	reg [3:0] txbuf;	
  reg [3:0] txbuf_r1;
  reg [3:0] txbuf_r2;  		
	reg [3:0] txfall;			//�ӻ�����������ʼ�ź�
	reg [3:0] end_vliad;		//�ӻ��������ݽ�����־
	wire down_start;			//��λ������������ʼ�ź�
	reg [9:0] down_reg[35:0];	
	reg [7:0] i[3:0]; 		//�������Ϊ256
	reg [3:0] j[3:0]; 		//�̶�Ϊ10λ	
	reg [1:0] sta[3:0];		
	reg [1:0] up_sta;
	reg [15:0] up_i; 		//�洢������256*4
	reg [3:0] up_j; 		//�̶�Ϊ10λ
	reg down_end;
	reg up_tx_r;
	wire band_clk;
	
	assign down_en[0] = ~up_en;
	assign down_en[1] = ~up_en;
	assign down_en[2] = ~up_en;
	assign down_en[3] = ~up_en;
	
	assign down_tx[0] = up_rx;
	assign down_tx[1] = up_rx;
	assign down_tx[2] = up_rx;
	assign down_tx[3] = up_rx;

	assign up_tx = up_tx_r;
	
	//up en control
	always @(posedge band_clk or negedge reset_n) begin 
		if(!reset_n)
			up_en = 0;
		
		//�жϷ�����ɣ� ��λ��
		else if(up_end)
			up_en = 1;
		//�жϽ�����ɣ� �ӻ�
		else if(down_end)
			up_en = 0;		
	end
	
	//�����ʼ����λ��
	always @(posedge band_clk)   	//�����·���½���
	begin
		rxbuf		<= up_rx;
		rxfall 		<= rxbuf & (~up_rx);
	end
	
	always @(posedge band_clk or negedge reset_n)
		if(!reset_n)
			up_valid <= 1'b0;
		else if(rxfall)
			up_valid <= 1'b1;
		else if(up_end)
			up_valid <= 1'b0;
	
	//����ʱ�䣬��λ��
	always @(posedge band_clk or negedge reset_n) begin 
		if(!reset_n) begin
			up_wait_t <= 32'd0;
			up_end <= 1'b0;
		end
		//ʱ��
		else if(up_wait_t == 104) begin
			up_end <= 1'b1;
			up_wait_t <= 32'd0;
		end
		else if(up_valid) begin
			up_wait_t <= up_wait_t + 1'b1;
			up_end <= 1'b0;
		end
		else
			up_end <= 1'b0;
	end
	
	assign  down_start = end_vliad[0] & end_vliad[1] & end_vliad[2] & end_vliad[3];
	
	//�����ʼ���ӻ�1
	always @(posedge band_clk)   	//�����·���½���
	begin
		txbuf[0]		<= down_rx[0];
		txfall[0] 	<= txbuf[0] & (~down_rx[0]);
	end
	
	//�����ʼ���ӻ�2
	always @(posedge band_clk)   	//�����·���½���
	begin
		txbuf[1]		<= down_rx[1];
		txfall[1] 	<= txbuf[1] & (~down_rx[1]);
	end
	
	//�����ʼ���ӻ�3
	always @(posedge band_clk)   	//�����·���½���
	begin
		txbuf[2]		<= down_rx[2];
		txfall[2] 	<= txbuf[2] & (~down_rx[2]);
	end
	
	//�����ʼ���ӻ�4
	always @(posedge band_clk)   	//�����·���½���
	begin
		txbuf[3]		<= down_rx[3];
		txfall[3] 	<= txbuf[3] & (~down_rx[3]);
	end
	
	always @(posedge band_clk) begin
	   txbuf_r1 <= txbuf;
	   txbuf_r2 <= txbuf_r1;
  end
  
	//�洢���ӻ�1
	always @(posedge band_clk or negedge reset_n) begin
		if(!reset_n) begin
			i[0] <= 8'd0;
			j[0] <= 4'd0;
			sta[0] <= 0;
			end_vliad[0] <= 1'b0;
		end 
		else  
			case (sta[0]) 
		0:   	if(txfall[0])
					sta[0] <= 1;
		1:  	if(i[0] < DOWN_BYTE_WIDTH) begin
					if(j[0] < 9) begin
						j[0] <= j[0] + 1;
					end
					else begin
						j[0] <= 0;
						i[0] <= i[0] + 1;
					end
					down_reg[i[0]] <= {down_reg[i[0]][8:0], txbuf_r2[0]};
				end
				else begin
					end_vliad[0] <= 1;
					sta[0] <= 2;
				end
		2:      if(down_end) begin
					end_vliad[0] <= 0;
					sta[0] <= 0;
				end
		default : begin
					i[0] <= 8'd0;
					j[0] <= 4'd0;
					sta[0] <= 0;	
					end_vliad[0] <= 1'b0;
				end
			endcase
	end
	
	//�洢���ӻ�2
	always @(posedge band_clk or negedge reset_n) begin
		if(!reset_n) begin
			i[1] <= DOWN_BYTE_WIDTH;
			j[1] <= 4'd0;
			sta[1] <= 0;
			end_vliad[1] <= 1'b0;
		end 
		else  
			case (sta[1]) 
		0:   	if(txfall[1])
					sta[1] <= 1;
		1:  	if(i[1] < DOWN_BYTE_WIDTH*2) begin
					if(j[1] < 9) begin
						j[1] <= j[1] + 1;
					end
					else begin
						j[1] <= 0;
						i[1] <= i[1] + 1;
					end
					down_reg[i[1]] <= {down_reg[i[1]][8:0], txbuf_r2[1]};
				end
				else begin
					end_vliad[1] <= 1;
					sta[1] <= 2;
				end
		2:      if(down_end) begin
					end_vliad[1] <= 0;
					sta[1] <= 0;
				end
		default : begin
					i[1] <= 8'd0;
					j[1] <= 4'd0;
					sta[1] <= 0;	
					end_vliad[1] <= 1'b0;
				end
			endcase
	end

	//�洢���ӻ�3
	always @(posedge band_clk or negedge reset_n) begin
		if(!reset_n) begin
			i[2] <= DOWN_BYTE_WIDTH*2;
			j[2] <= 4'd0;
			sta[2] <= 0;
			end_vliad[2] <= 1'b0;
		end 
		else  
			case (sta[2]) 
		0:   	if(txfall[2])
					sta[2] <= 1;
		1:  	if(i[2] < DOWN_BYTE_WIDTH*3) begin
					if(j[2] < 9) begin
						j[2] <= j[2] + 1;
					end
					else begin
						j[2] <= 0;
						i[2] <= i[2] + 1;
					end
					down_reg[i[2]] <= {down_reg[i[2]][8:0], txbuf_r2[2]};
				end
				else begin
					end_vliad[2] <= 1;
					sta[2] <= 2;
				end
		2:      if(down_end) begin
					end_vliad[2] <= 0;
					sta[2] <= 0;
				end
		default : begin
					i[2] <= 8'd0;
					j[2] <= 4'd0;
					sta[2] <= 0;	
					end_vliad[2] <= 1'b0;
				end
			endcase
	end
	
	//�洢���ӻ�4
	always @(posedge band_clk or negedge reset_n) begin
		if(!reset_n) begin
			i[3] <= DOWN_BYTE_WIDTH*3;
			j[3] <= 4'd0;
			sta[3] <= 0;
			end_vliad[3] <= 1'b0;
		end 
		else  
			case (sta[3]) 
		0:   	if(txfall[3])
					sta[3] <= 1;
		1:  	if(i[3] < DOWN_BYTE_WIDTH*4) begin
					if(j[3] < 9) begin
						j[3] <= j[3] + 1;
					end
					else begin
						j[3] <= 0;
						i[3] <= i[3] + 1;
					end
					down_reg[i[3]] <= {down_reg[i[3]][8:0], txbuf_r2[3]};
				end
				else begin
					end_vliad[3] <= 1;
					sta[3] <= 2;
				end
		2:      if(down_end) begin
					end_vliad[3] <= 0;
					sta[3] <= 0;
				end
		default : begin
					i[3] <= 8'd0;
					j[3] <= 4'd0;
					sta[3] <= 0;	
					end_vliad[3] <= 1'b0;
				end
			endcase
	end
	
	//���ͣ��ӻ�	
	always @(posedge band_clk or negedge reset_n) begin
		if(!reset_n) begin
			up_sta <= 0;
			up_i <= 0;
			up_j <= 0;
			up_tx_r <= 0;
		end
		else 
			case(up_sta)
		0:	if(down_start) begin
				up_sta <= 1;
			end	
		1:	if(up_i < DOWN_BYTE_WIDTH*4) begin
				if(up_j < 9) begin
					up_j <= up_j + 1;
				end
				else begin
					up_j <= 0;
					up_i <= up_i + 1;
				end
				down_reg[up_i] <= {down_reg[up_i][8:0], down_reg[up_i][9]};
				up_tx_r <= down_reg[up_i][9];
				end
			else begin
					up_sta <= 2;
					up_i <= 0;
					up_j <= 0;
			end
		2:  if(down_start == 0)
		      up_sta <= 0;
		default:  begin
					up_sta <= 0;
					up_i <= 0;
					up_j <= 0;
					up_tx_r <= 0;
				  end
			endcase
	end
	
	always @(posedge band_clk or negedge reset_n) begin
	   if(!reset_n)
	       down_end <= 0;
	   else if(up_sta == 1) begin
	       if(up_i == DOWN_BYTE_WIDTH*4)
	           down_end <= 1;
	   end
	   else
	      down_end <= 0;
	end
	
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////	
clkdiv	u0 (
		 .clk25		(clk25),
		 .clkout	(band_clk)
);	
	
endmodule
