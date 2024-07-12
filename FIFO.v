`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 13:09:15
// Design Name: 
// Module Name: FIFO
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


module FIFO #(parameter DEPTH = 16, 
parameter WIDTH = 3, 
parameter PTR_LEN = 4)(
//parameter file = "fifo")(

    input   Clock,
    input   read_en,
    input   write_en,
    input   [WIDTH-1:0] write_data,
    input   reset,
    
    output  reg [WIDTH-1:0] read_data,
    output  fifo_full,
    output  fifo_empty
    );
    
reg [WIDTH-1:0] memory [0:DEPTH-1];
reg [PTR_LEN-1:0]read_ptr = 0;
reg [PTR_LEN-1:0]write_ptr = 0;

//initial begin 
//    $readmemh(file, memory);
//end

always @(posedge Clock)
begin
    if(reset == 1)
    begin
        read_data <= 0;
    end  
    else if(read_en == 1 && fifo_empty == 0)
    begin
        read_data <= memory[read_ptr];
        read_ptr <= read_ptr + 1;
    end
end

always @(posedge Clock)
begin
    if(write_en == 1 && fifo_full == 0)
    begin
        memory[write_ptr] <= write_data;
        write_ptr <= write_ptr + 1;
    end
end

assign fifo_empty = (read_ptr==write_ptr);
assign fifo_full  = ((write_ptr + 1'b1) == read_ptr);
endmodule
