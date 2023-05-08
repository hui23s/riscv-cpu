`timescale 1ns / 1ps
`include "../defines.v"

module core_pcgen (
    input wire clk_i,                      // system clock
    input wire rst_n_i,                    // system reset

    input wire reset_flag_i,               // need reset

    input wire hold_flag_i,                // need hold

    input wire jump_flag_i,                // need jump
    input wire [`DATA_BUS_WIDTH-1:0] jump_addr_i,                // jump-to pc value

    output wire [`DATA_BUS_WIDTH-1:0] pc_o                        // next pc value
    );

reg  [`DATA_BUS_WIDTH-1:0]      _pc;

always @ (posedge clk_i) begin
// hardware power-on reset
    if (~rst_n_i) begin
        _pc[`DATA_BUS_WIDTH-1:0] <= `RESET_PC_ADDR;
    end
// software reset
    else if (reset_flag_i) begin
        _pc[`DATA_BUS_WIDTH-1:0] <= `RESET_PC_ADDR;
    end
// jump instruction
    else if (jump_flag_i) begin
        _pc[`DATA_BUS_WIDTH-1:0] <= jump_addr_i[`DATA_BUS_WIDTH-1:0];
    end
// cpu stall & hold
    else if (hold_flag_i) begin
        _pc[`DATA_BUS_WIDTH-1:0] <= _pc[`DATA_BUS_WIDTH-1:0];
    end
// only support 32-bits instruction
    else begin
        _pc[`DATA_BUS_WIDTH-1:0] <= _pc[`DATA_BUS_WIDTH-1:0] + 32'h4;
    end
end

assign pc_o[`DATA_BUS_WIDTH-1:0] = _pc[`DATA_BUS_WIDTH-1:0];

endmodule