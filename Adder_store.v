`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 12:53:27
// Design Name: 
// Module Name: Adder_store
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


module Adder_store#(
    parameter DEPTH = 16, 
    parameter WIDTH = 3, 
    parameter PTR_LEN = 4)(
    
    input [PTR_LEN-1:0] transducer_A_focal_point_in, 
    input [PTR_LEN-1:0] transducer_B_focal_point_in,
    input Clk, 
    input reset, 
    input [WIDTH-1:0] fifo_A_in,  
    input [WIDTH-1:0] fifo_B_in,
    input read_en_fifo_A, 
    input read_en_fifo_B, 
    input [PTR_LEN-1:0] focal_point,
    input fifo_empty_A_in, 
    input fifo_empty_B_in,
    
    output reg [PTR_LEN-1:0] output_data
    );
    
integer i; 
reg [PTR_LEN-1:0] image_storage [DEPTH-1:0]; 
reg extra_clock = 0;

always @ (posedge Clk) begin
    if(reset) begin 
        output_data <= 0; 
        extra_clock <= 0; 
        for (i = 0; i < DEPTH; i = i + 1) begin 
            image_storage [i] <= 4'b0000; 
        end
    end 
    else begin 
        if (!extra_clock & (read_en_fifo_A & read_en_fifo_B)) begin 
            if(!(fifo_empty_A_in|fifo_empty_B_in)) begin
                image_storage [transducer_A_focal_point_in] = image_storage [transducer_A_focal_point_in] + fifo_A_in; 
                image_storage [transducer_B_focal_point_in] = image_storage [transducer_B_focal_point_in] + fifo_B_in;
                
                output_data <= image_storage [focal_point];
            end
            else begin 
                extra_clock <= extra_clock + 1;
                image_storage [transducer_A_focal_point_in] = image_storage [transducer_A_focal_point_in] + fifo_A_in; 
                image_storage [transducer_B_focal_point_in] = image_storage [transducer_B_focal_point_in] + fifo_B_in;
                
                output_data <= image_storage [focal_point];
            end
        end
    end
end
endmodule
