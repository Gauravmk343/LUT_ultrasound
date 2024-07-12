`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 16:01:11
// Design Name: 
// Module Name: top_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_tb( );

reg Clk;             
reg [3:0] focal_point;
reg read_en_fifo_A;
reg write_en_fifo_A;    
reg read_en_fifo_B;
reg write_en_fifo_B; 
reg [2:0] write_data_fifo_A;    
reg [2:0] write_data_fifo_B;   
reg reset;    

wire [4:0] output_data;
wire fifo_A_empty;     
wire fifo_B_empty;     
wire fifo_B_full;      
wire fifo_A_full;         

Top Top_instance (
    Clk, 
    focal_point, 
    read_en_fifo_A,
    write_en_fifo_A,
    read_en_fifo_B,
    write_en_fifo_B,
    write_data_fifo_A, 
    write_data_fifo_B, 
    reset,   
    output_data,
    fifo_A_empty,  
    fifo_B_empty,   
    fifo_B_full,    
    fifo_A_full     
);  

initial begin 
    Clk = 0;
    forever begin
        #10 Clk = ~Clk; 
    end
end     

initial begin 
    focal_point <= 4'b1001; 
    read_en_fifo_A <= 0; 
    read_en_fifo_B <= 0;
    write_en_fifo_A <= 0;
    write_en_fifo_B <= 0; 
    reset <= 1'b1;
    #30
    reset <= 0;
    write_en_fifo_A <= 1;
    write_en_fifo_B <= 1; 
    write_data_fifo_A <= 3'b111; 
    write_data_fifo_B <= 3'b101; 
    #20 
    write_data_fifo_A <= 3'b101; 
    write_data_fifo_B <= 3'b111; 
    #20 
    write_data_fifo_A <= 3'b011; 
    write_data_fifo_B <= 3'b001;
    #20 
    write_data_fifo_A <= 3'b110; 
    write_data_fifo_B <= 3'b100;
    #20 
    write_data_fifo_A <= 3'b100; 
    write_data_fifo_B <= 3'b110;
    #20 
    write_data_fifo_A <= 3'b110; 
    write_data_fifo_B <= 3'b111;
    #20 
    write_data_fifo_A <= 3'b001; 
    write_data_fifo_B <= 3'b011;
    #20 
    write_data_fifo_A <= 3'b101; 
    write_data_fifo_B <= 3'b001;
    #20 
    write_data_fifo_A <= 3'b011; 
    write_data_fifo_B <= 3'b110;
    #20 
    write_data_fifo_A <= 3'b100; 
    write_data_fifo_B <= 3'b010;
    #20 
    write_data_fifo_A <= 3'b011; 
    write_data_fifo_B <= 3'b000;
    #20 
    write_data_fifo_A <= 3'b001; 
    write_data_fifo_B <= 3'b100;
    #20 
    write_data_fifo_A <= 3'b001; 
    write_data_fifo_B <= 3'b101;
    #20 
    write_data_fifo_A <= 3'b110; 
    write_data_fifo_B <= 3'b101;
    #20 
    write_data_fifo_A <= 3'b011; 
    write_data_fifo_B <= 3'b101;
    #20 
    write_data_fifo_A <= 3'b101; 
    write_data_fifo_B <= 3'b001;
    #20 
    write_data_fifo_A <= 3'b110; 
    write_data_fifo_B <= 3'b111;
    #20 
    write_data_fifo_A <= 3'b101; 
    write_data_fifo_B <= 3'b011;
    #20
    write_en_fifo_A <= 0; 
    write_en_fifo_B <= 0; 
    
    read_en_fifo_A <= 1;
    read_en_fifo_B <= 1;
end
endmodule
