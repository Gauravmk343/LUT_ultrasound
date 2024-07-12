`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 14:38:56
// Design Name: 
// Module Name: Top
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


module Top #(
    parameter DEPTH = 16,  // Number of focal points
    parameter PTR_LEN = 4,
    parameter WIDTH = 3, 
    parameter SCAN_LINES = 2,  // Number of scan lines
    parameter file_A_LUT = "Transducer_A.mem", 
    parameter file_B_LUT = "Transducer_B.mem"
)(
    input Clk, 
    input [PTR_LEN-1:0] focal_point, 
    input read_en_fifo_A, 
    input write_en_fifo_A, 
    input read_en_fifo_B, 
    input write_en_fifo_B,
    input [WIDTH-1:0] write_data_fifo_A,
    input [WIDTH-1:0] write_data_fifo_B,
    input reset, 
    
    
    output [WIDTH+1:0] output_data, 
    output fifo_A_empty, 
    output fifo_B_empty, 
    output fifo_B_full, 
    output fifo_A_full 
    );
    
// Wires from LUT
wire [PTR_LEN-1:0] transducer_A_focal_point_LUT_to_Adder; 
wire [PTR_LEN-1:0] transducer_B_focal_point_LUT_to_Adder; 

// Wires from FIFO_A
wire [PTR_LEN-1:0] read_data_fifo_A_to_Adder; 

// Wires from FIFO B
wire [PTR_LEN-1:0] read_data_fifo_B_to_Adder; 

    
LUT #(.DEPTH(DEPTH), .PTR_LEN(PTR_LEN), .SCAN_LINES(SCAN_LINES), .file_A_LUT(file_A_LUT), .file_B_LUT(file_B_LUT)) lut (
    Clk, 
    reset, 
    fifo_A_empty, 
    fifo_B_empty, 
    read_en_fifo_A, 
    read_en_fifo_B, 
    transducer_A_focal_point_LUT_to_Adder, 
    transducer_B_focal_point_LUT_to_Adder
);

FIFO #(.DEPTH(DEPTH), .WIDTH(WIDTH), .PTR_LEN(PTR_LEN)) FIFO_A (
    .Clock(Clk),
    .read_en(read_en_fifo_A),
    .write_en(write_en_fifo_A), 
    .write_data(write_data_fifo_A), 
    .reset(reset), 
    .read_data(read_data_fifo_A_to_Adder),
    .fifo_full(fifo_A_full),
    .fifo_empty(fifo_A_empty)
);

FIFO #(.DEPTH(DEPTH), .WIDTH(WIDTH), .PTR_LEN(PTR_LEN)) FIFO_B (
    .Clock(Clk),
    .read_en(read_en_fifo_B),
    .write_en(write_en_fifo_B), 
    .write_data(write_data_fifo_B), 
    .reset(reset), 
    .read_data(read_data_fifo_B_to_Adder),
    .fifo_full(fifo_B_full),
    .fifo_empty(fifo_B_empty)
);

Adder_store #(.DEPTH(DEPTH), .WIDTH(WIDTH), .PTR_LEN(PTR_LEN)) Adder (
    transducer_A_focal_point_LUT_to_Adder, 
    transducer_B_focal_point_LUT_to_Adder, 
    Clk, 
    reset, 
    read_data_fifo_A_to_Adder,
    read_data_fifo_B_to_Adder,
    read_en_fifo_A, 
    read_en_fifo_B,
    focal_point, 
    fifo_A_empty, 
    fifo_B_empty, 
    
    output_data
);
    
endmodule
