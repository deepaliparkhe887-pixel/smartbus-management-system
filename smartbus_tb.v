`timescale 1ns/1ps

module smartbus_tb;

reg clk;
reg reset;
reg entry;
reg exit;

wire [3:0] occupied;
wire [3:0] available;
wire bus_full;

smartbus uut(
    .clk(clk),
    .reset(reset),
    .entry(entry),
    .exit(exit),
    .occupied(occupied),
    .available(available),
    .bus_full(bus_full)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("smartbus.vcd");
    $dumpvars(0, smartbus_tb);

    $monitor(
        "Time=%0t | Occupied=%0d | Available=%0d | Bus Full=%b",
        $time, occupied, available, bus_full
    );

    clk = 0;
    reset = 1;
    entry = 0;
    exit = 0;

    #10 reset = 0;

    entry = 1;
    #10 entry = 0;

    #10 entry = 1;
    #10 entry = 0;

    #10 entry = 1;
    #10 entry = 0;

    #10 exit = 1;
    #10 exit = 0;

    #20 $finish;
end

endmodule