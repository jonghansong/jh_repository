`timescale 1ns/1ns

module dut();

reg [15:0] din;
reg [15:0] frame_n;
reg [15:0] valid_n;
reg        reset_n;
reg        clock;


wire [15:0] dout;
wire [15:0] frameo_n;
wire [15:0] valido_n;

router u_router(
            .din(din),
            .frame_n(frame_n),
            .valid_n(valid_n),
            .reset_n(reset_n),
            .clock(clock),
            .dout(dout),
            .frameo_n(frameo_n),
            .valido_n(valido_n));

always 
    #5 clock = ~clock;


initial begin
    $dumpfile("./router.vcd");
    $dumpvars;

    clock = 1'b0;
    din = 16'd0;
    frame_n = 16'hFFFF;
    valid_n = 16'hFFFF;

    reset_n = 1'b1;
    #15; reset_n = 1'b0;
    #12; reset_n = 1'b1;

    #150;
    frame_n = 16'd0;
    valid_n = 16'd0;
    din = 16'h00FF;
    #10; din = 16'h0F0F;
    #10; din = 16'h3333;
    #10; din = 16'h5555;

    #10; din = 16'h9287;

    #20; valid_n = 16'hFFFF;
    #10; din = 16'h7829;
    #10; valid_n = 16'h0000;
    #10; din = 16'hFFFF;

    #10; frame_n = 16'hFFFF;
    #10; frame_n = 16'd0;

    #10; din = 16'h5555;
    #10; din = 16'h3333;
    #10; din = 16'h0F0F;
    #10; din = 16'h00FF;

    #10; din = 16'h9287;
   

    #100; $finish;
end



endmodule
