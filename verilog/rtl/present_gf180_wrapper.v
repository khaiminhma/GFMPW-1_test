
`default_nettype wire // change to "wire" for simulation
/*
 *-------------------------------------------------------------
 *
 * present_gf180_wrapper
 *
 * Description (TODO)
 *
 *-------------------------------------------------------------
 */


module present_gf180_wrapper (
`ifdef USE_POWER_PINS
    inout vdd,	// User area 1
    inout vss,	// User area 1 digital ground
`endif

    // Wishbone Bus Signals
    input wb_clk_i,
    input wb_rst_i,

    // Logic Analyzer Signals
    input  [38:0] la_data_in,
    output [31:0] la_data_out
);

wire [31:0] present_wrapper_output;
wire [31:0] dmpresent_wrapper_output;

assign la_data_out =    (la_data_in[38:37] == 2'b10) ? dmpresent_wrapper_output :
                        (la_data_in[38:37] == 2'b01) ? present_wrapper_output   : 32'b0 ;

present_wrapper dut_present_wrapper(
    .clk            (wb_clk_i),
    .iReset         (wb_rst_i),
    .iChipselect    (la_data_in[37]),
    .iWriteRead     (la_data_in[36]),
    .iAddress       (la_data_in[35:32]),
    .idat           (la_data_in[31:0]),
    .odat           (present_wrapper_output)
);

dmpresent_wrapper dut_dmpresent_wrapper(
    .clk            (wb_clk_i),
    .iReset         (wb_rst_i),
    .iChipselect    (la_data_in[38]),
    .iWriteRead     (la_data_in[36]),
    .iAddress       (la_data_in[34:32]),
    .idat           (la_data_in[31:0]),
    .odat           (dmpresent_wrapper_output)
);


endmodule  // end of "present_gf180_wrapper"
`default_nettype wire
