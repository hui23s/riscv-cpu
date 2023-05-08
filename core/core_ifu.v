`timescale 1ns / 1ps
`include "../defines.v"

module core_ifu (
    input wire clk_i,                      // system clock
    input wire rst_n_i,                    // system reset

    input wire [`ADDR_BUS_WIDTH-1:0] data_addr_i,                // d-data address
    input wire [`DATA_BUS_WIDTH-1:0] data_data_i,                // d-data data

    output wire [`DATA_BUS_WIDTH-1:0] data_data_o,                // d-data data
    input wire data_we_i,                  // d-data write enable

    input wire [`ADDR_BUS_WIDTH-1:0] inst_addr_i,                // i-data address
    output wire [`DATA_BUS_WIDTH-1:0] inst_data_o                 // i-data data
    );

pa_core_itcm u_pa_core_itcm (
    .clk_i                      (clk_i),
    .rst_n_i                    (rst_n_i),

    .data_addr_i                (data_addr_i),
    .data_data_i                (data_data_i),
    .data_data_o                (data_data_o),
    .data_we_i                  (data_we_i),

    .inst_addr_i                (inst_addr_i),
    .inst_data_o                (inst_data_o)
);

endmodule