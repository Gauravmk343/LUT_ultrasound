`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 12:02:28
// Design Name: 
// Module Name: LUT
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


module LUT #(
    parameter DEPTH = 16,  // Number of focal points
    parameter PTR_LEN = 4,
    parameter SCAN_LINES = 2,  // Number of scan lines
    parameter file_A_LUT = "Transducer_A.mem", 
    parameter file_B_LUT = "Transducer_B.mem"
)(    
    input Clk, 
    input reset, 
    input fifo_empty_A_in,
    input fifo_empty_B_in,
    input read_en_fifo_A_in, 
    input read_en_fifo_B_in, 
    
    output reg [PTR_LEN-1:0] transducer_A_focal_point_out, 
    output reg [PTR_LEN-1:0] transducer_B_focal_point_out
    );
    
reg [PTR_LEN-1:0] transducer_A_focal_point_array [DEPTH-1:0]; 
reg [PTR_LEN-1:0] transducer_B_focal_point_array [DEPTH-1:0]; 

initial begin 
    $readmemh(file_A_LUT, transducer_A_focal_point_array); 
    $readmemh(file_B_LUT, transducer_B_focal_point_array);
end

reg [PTR_LEN-1:0] fifo_index = 4'b0;

always @ (posedge Clk) begin
    if(reset) begin 
        transducer_A_focal_point_out <= 0;
        transducer_B_focal_point_out <= 0;
    end
    else begin 
        if ((!(fifo_empty_A_in|fifo_empty_B_in))&(read_en_fifo_A_in & read_en_fifo_B_in)) begin
            transducer_A_focal_point_out <= transducer_A_focal_point_array[fifo_index];
            transducer_B_focal_point_out <= transducer_B_focal_point_array [fifo_index];
            fifo_index <= fifo_index + 1;
        end 
    end
end

endmodule
