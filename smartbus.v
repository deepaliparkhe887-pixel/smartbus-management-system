module smartbus(
    input clk,
    input reset,
    input entry,
    input exit,
    output reg [3:0] occupied,
    output wire [3:0] available,
    output wire bus_full
);

parameter TOTAL_SEATS = 8;

assign available = TOTAL_SEATS - occupied;
assign bus_full = (occupied == TOTAL_SEATS);

always @(posedge clk or posedge reset) begin
    if (reset)
        occupied <= 0;
    else begin
        case ({entry, exit})
            2'b10: begin
                if (occupied < TOTAL_SEATS)
                    occupied <= occupied + 1'b1;
            end

            2'b01: begin
                if (occupied > 0)
                    occupied <= occupied - 1'b1;
            end

            default: occupied <= occupied;
        endcase
    end
end

endmodule