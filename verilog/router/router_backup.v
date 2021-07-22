module router
#(
parameter WIDTH = 16
)
(

///////////////
//  input
///////////////
    input  [WIDTH-1:0] din,
    input  [WIDTH-1:0] frame_n,
    input  [WIDTH-1:0] valid_n,
    input         reset_n,
    input         clock,

///////////////
//  output
///////////////
    output reg [WIDTH-1:0] dout,
    output reg [WIDTH-1:0] frameo_n,
    output reg [WIDTH-1:0] valido_n);


reg [3:0] addr [WIDTH-1:0];
reg [2:0] addr_counter [WIDTH-1:0];

genvar i;
generate
    for ( i = 0 ; i < WIDTH; i = i+1) begin
        always@(posedge clock or negedge reset_n) begin
            if(reset_n == 1'b0) begin
                addr_counter[i] <= 3'd0;
                addr[i] <= 4'd0;
            end else if(frame_n[i] == 1'b0 && addr_counter[i] != 3'b100) begin
                addr_counter[i] <= addr_counter[i] + 1'b1;
                addr[i] <= addr[i] << 1'b1;
                addr[i][0] <= din[0];
            end
        end
        
        always@(posedge clock or negedge reset_n) begin
            if(reset_n == 1'b0) begin
                dout[0] <= 1'b0;
            end else if(addr_counter[i] == 3'b100) begin
                if(valid_n[i] == 1'b0 && frame_n[i] == 1'b0) begin
                    case(addr[i])
                        4'd0  : dout[0] <= din[0];
                        4'd1  : dout[1] <= din[0];
                        4'd2  : dout[2] <= din[0];
                        4'd3  : dout[3] <= din[0];
                        4'd4  : dout[4] <= din[0];
                        4'd5  : dout[5] <= din[0];
                        4'd6  : dout[6] <= din[0];
                        4'd7  : dout[7] <= din[0];
                        4'd8  : dout[8] <= din[0];
                        4'd9  : dout[9] <= din[0];
                        4'd10 : dout[10] <= din[0];
                        4'd11 : dout[11] <= din[0];
                        4'd12 : dout[12] <= din[0];
                        4'd13 : dout[13] <= din[0];
                        4'd14 : dout[14] <= din[0];
                        4'd15 : dout[15] <= din[0];
                    endcase
                end
            end
        end
    end
endgenerate

endmodule
