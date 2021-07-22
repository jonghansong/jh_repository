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


reg [3:0] addr0;
reg [3:0] addr1;
reg [3:0] addr2;
reg [3:0] addr3;
reg [3:0] addr4;
reg [3:0] addr5;
reg [3:0] addr6;
reg [3:0] addr7;
reg [3:0] addr8;
reg [3:0] addr9;
reg [3:0] addr10;
reg [3:0] addr11;
reg [3:0] addr12;
reg [3:0] addr13;
reg [3:0] addr14;
reg [3:0] addr15;

reg [2:0] addr_counter0 ;
reg [2:0] addr_counter1 ;
reg [2:0] addr_counter2 ;
reg [2:0] addr_counter3 ;
reg [2:0] addr_counter4 ;
reg [2:0] addr_counter5 ;
reg [2:0] addr_counter6 ;
reg [2:0] addr_counter7 ;
reg [2:0] addr_counter8 ;
reg [2:0] addr_counter9 ;
reg [2:0] addr_counter10;
reg [2:0] addr_counter11;
reg [2:0] addr_counter12;
reg [2:0] addr_counter13;
reg [2:0] addr_counter14;
reg [2:0] addr_counter15;

always@(frame_n) begin
    frameo_n <= frame_n;
end

always@(valid_n) begin
    valido_n <= valid_n;
end

/////////////////////////////////////////////////
// din0
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter0 <= 3'd0;
        addr0 <= 4'd0;
    end else if(frame_n[0] == 1'b1) begin
        addr_counter0 <= 3'd0;
        addr0 <= 4'd0;
    end else if(frame_n[0] == 1'b0 && addr_counter0 != 3'b100) begin
        addr_counter0 <= addr_counter0 + 1'b1;
        addr0 <= addr0 << 1'b1;
        addr0[0] <= din[0];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[0] <= 1'b0;
    end else if(addr_counter0 == 3'b100) begin
        if(valid_n[0] == 1'b0 && frame_n[0] == 1'b0) begin
            case(addr0)
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

/////////////////////////////////////////////////
// din1
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter1 <= 3'd0;
        addr1 <= 4'd0;
    end else if(frame_n[1] == 1'b1) begin
        addr_counter1 <= 3'd0;
        addr1 <= 4'd0;
    end else if(frame_n[1] == 1'b0 && addr_counter1 != 3'b100) begin
        addr_counter1 <= addr_counter1 + 1'b1;
        addr1 <= addr1 << 1'b1;
        addr1[0] <= din[1];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[1] <= 1'b0;
    end else if(addr_counter1 == 3'b100) begin
        if(valid_n[1] == 1'b0 && frame_n[1] == 1'b0) begin
            case(addr1)
                4'd0  : dout[0] <= din[1];
                4'd1  : dout[1] <= din[1];
                4'd2  : dout[2] <= din[1];
                4'd3  : dout[3] <= din[1];
                4'd4  : dout[4] <= din[1];
                4'd5  : dout[5] <= din[1];
                4'd6  : dout[6] <= din[1];
                4'd7  : dout[7] <= din[1];
                4'd8  : dout[8] <= din[1];
                4'd9  : dout[9] <= din[1];
                4'd10 : dout[10] <= din[1];
                4'd11 : dout[11] <= din[1];
                4'd12 : dout[12] <= din[1];
                4'd13 : dout[13] <= din[1];
                4'd14 : dout[14] <= din[1];
                4'd15 : dout[15] <= din[1];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din2
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter2 <= 3'd0;
        addr2 <= 4'd0;
    end else if(frame_n[2] == 1'b1) begin
        addr_counter2 <= 3'd0;
        addr2 <= 4'd0;
    end else if(frame_n[2] == 1'b0 && addr_counter2 != 3'b100) begin
        addr_counter2 <= addr_counter2 + 1'b1;
        addr2 <= addr2 << 1'b1;
        addr2[0] <= din[2];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[2] <= 1'b0;
    end else if(addr_counter2 == 3'b100) begin
        if(valid_n[2] == 1'b0 && frame_n[2] == 1'b0) begin
            case(addr2)
                4'd0  : dout[0] <= din[2];
                4'd1  : dout[1] <= din[2];
                4'd2  : dout[2] <= din[2];
                4'd3  : dout[3] <= din[2];
                4'd4  : dout[4] <= din[2];
                4'd5  : dout[5] <= din[2];
                4'd6  : dout[6] <= din[2];
                4'd7  : dout[7] <= din[2];
                4'd8  : dout[8] <= din[2];
                4'd9  : dout[9] <= din[2];
                4'd10 : dout[10] <= din[2];
                4'd11 : dout[11] <= din[2];
                4'd12 : dout[12] <= din[2];
                4'd13 : dout[13] <= din[2];
                4'd14 : dout[14] <= din[2];
                4'd15 : dout[15] <= din[2];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din3
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter3 <= 3'd0;
        addr3 <= 4'd0;
    end else if(frame_n[3] == 1'b1) begin
        addr_counter3 <= 3'd0;
        addr3 <= 4'd0;
    end else if(frame_n[3] == 1'b0 && addr_counter3 != 3'b100) begin
        addr_counter3 <= addr_counter3 + 1'b1;
        addr3 <= addr3 << 1'b1;
        addr3[0] <= din[3];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[3] <= 1'b0;
    end else if(addr_counter3 == 3'b100) begin
        if(valid_n[3] == 1'b0 && frame_n[3] == 1'b0) begin
            case(addr3)
                4'd0  : dout[0] <= din[3];
                4'd1  : dout[1] <= din[3];
                4'd2  : dout[2] <= din[3];
                4'd3  : dout[3] <= din[3];
                4'd4  : dout[4] <= din[3];
                4'd5  : dout[5] <= din[3];
                4'd6  : dout[6] <= din[3];
                4'd7  : dout[7] <= din[3];
                4'd8  : dout[8] <= din[3];
                4'd9  : dout[9] <= din[3];
                4'd10 : dout[10] <= din[3];
                4'd11 : dout[11] <= din[3];
                4'd12 : dout[12] <= din[3];
                4'd13 : dout[13] <= din[3];
                4'd14 : dout[14] <= din[3];
                4'd15 : dout[15] <= din[3];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din4
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter4 <= 3'd0;
        addr4 <= 4'd0;
    end else if(frame_n[4] == 1'b1) begin
        addr_counter4 <= 3'd0;
        addr4 <= 4'd0;
    end else if(frame_n[4] == 1'b0 && addr_counter4 != 3'b100) begin
        addr_counter4 <= addr_counter4 + 1'b1;
        addr4 <= addr4 << 1'b1;
        addr4[0] <= din[4];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[4] <= 1'b0;
    end else if(addr_counter4 == 3'b100) begin
        if(valid_n[4] == 1'b0 && frame_n[4] == 1'b0) begin
            case(addr4)
                4'd0  : dout[0] <= din[4];
                4'd1  : dout[1] <= din[4];
                4'd2  : dout[2] <= din[4];
                4'd3  : dout[3] <= din[4];
                4'd4  : dout[4] <= din[4];
                4'd5  : dout[5] <= din[4];
                4'd6  : dout[6] <= din[4];
                4'd7  : dout[7] <= din[4];
                4'd8  : dout[8] <= din[4];
                4'd9  : dout[9] <= din[4];
                4'd10 : dout[10] <= din[4];
                4'd11 : dout[11] <= din[4];
                4'd12 : dout[12] <= din[4];
                4'd13 : dout[13] <= din[4];
                4'd14 : dout[14] <= din[4];
                4'd15 : dout[15] <= din[4];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din5
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter5 <= 3'd0;
        addr5 <= 4'd0;
    end else if(frame_n[5] == 1'b1) begin
        addr_counter5 <= 3'd0;
        addr5 <= 4'd0;
    end else if(frame_n[5] == 1'b0 && addr_counter5 != 3'b100) begin
        addr_counter5 <= addr_counter5 + 1'b1;
        addr5 <= addr5 << 1'b1;
        addr5[0] <= din[5];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[5] <= 1'b0;
    end else if(addr_counter5 == 3'b100) begin
        if(valid_n[5] == 1'b0 && frame_n[5] == 1'b0) begin
            case(addr5)
                4'd0  : dout[0] <= din[5];
                4'd1  : dout[1] <= din[5];
                4'd2  : dout[2] <= din[5];
                4'd3  : dout[3] <= din[5];
                4'd4  : dout[4] <= din[5];
                4'd5  : dout[5] <= din[5];
                4'd6  : dout[6] <= din[5];
                4'd7  : dout[7] <= din[5];
                4'd8  : dout[8] <= din[5];
                4'd9  : dout[9] <= din[5];
                4'd10 : dout[10] <= din[5];
                4'd11 : dout[11] <= din[5];
                4'd12 : dout[12] <= din[5];
                4'd13 : dout[13] <= din[5];
                4'd14 : dout[14] <= din[5];
                4'd15 : dout[15] <= din[5];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din6
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter6 <= 3'd0;
        addr6 <= 4'd0;
    end else if(frame_n[6] == 1'b1) begin
        addr_counter6 <= 3'd0;
        addr6 <= 4'd0;
    end else if(frame_n[6] == 1'b0 && addr_counter6 != 3'b100) begin
        addr_counter6 <= addr_counter6 + 1'b1;
        addr6 <= addr6 << 1'b1;
        addr6[0] <= din[6];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[6] <= 1'b0;
    end else if(addr_counter6 == 3'b100) begin
        if(valid_n[6] == 1'b0 && frame_n[6] == 1'b0) begin
            case(addr6)
                4'd0  : dout[0] <= din[6];
                4'd1  : dout[1] <= din[6];
                4'd2  : dout[2] <= din[6];
                4'd3  : dout[3] <= din[6];
                4'd4  : dout[4] <= din[6];
                4'd5  : dout[5] <= din[6];
                4'd6  : dout[6] <= din[6];
                4'd7  : dout[7] <= din[6];
                4'd8  : dout[8] <= din[6];
                4'd9  : dout[9] <= din[6];
                4'd10 : dout[10] <= din[6];
                4'd11 : dout[11] <= din[6];
                4'd12 : dout[12] <= din[6];
                4'd13 : dout[13] <= din[6];
                4'd14 : dout[14] <= din[6];
                4'd15 : dout[15] <= din[6];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din7
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter7 <= 3'd0;
        addr7 <= 4'd0;
    end else if(frame_n[7] == 1'b1) begin
        addr_counter7 <= 3'd0;
        addr7 <= 4'd0;
    end else if(frame_n[7] == 1'b0 && addr_counter7 != 3'b100) begin
        addr_counter7 <= addr_counter7 + 1'b1;
        addr7 <= addr7 << 1'b1;
        addr7[0] <= din[7];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[7] <= 1'b0;
    end else if(addr_counter7 == 3'b100) begin
        if(valid_n[7] == 1'b0 && frame_n[7] == 1'b0) begin
            case(addr7)
                4'd0  : dout[0] <= din[7];
                4'd1  : dout[1] <= din[7];
                4'd2  : dout[2] <= din[7];
                4'd3  : dout[3] <= din[7];
                4'd4  : dout[4] <= din[7];
                4'd5  : dout[5] <= din[7];
                4'd6  : dout[6] <= din[7];
                4'd7  : dout[7] <= din[7];
                4'd8  : dout[8] <= din[7];
                4'd9  : dout[9] <= din[7];
                4'd10 : dout[10] <= din[7];
                4'd11 : dout[11] <= din[7];
                4'd12 : dout[12] <= din[7];
                4'd13 : dout[13] <= din[7];
                4'd14 : dout[14] <= din[7];
                4'd15 : dout[15] <= din[7];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din8
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter8 <= 3'd0;
        addr8 <= 4'd0;
    end else if(frame_n[8] == 1'b1) begin
        addr_counter8 <= 3'd0;
        addr8 <= 4'd0;
    end else if(frame_n[8] == 1'b0 && addr_counter8 != 3'b100) begin
        addr_counter8 <= addr_counter8 + 1'b1;
        addr8 <= addr8 << 1'b1;
        addr8[0] <= din[8];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[8] <= 1'b0;
    end else if(addr_counter8 == 3'b100) begin
        if(valid_n[8] == 1'b0 && frame_n[8] == 1'b0) begin
            case(addr8)
                4'd0  : dout[0] <= din[8];
                4'd1  : dout[1] <= din[8];
                4'd2  : dout[2] <= din[8];
                4'd3  : dout[3] <= din[8];
                4'd4  : dout[4] <= din[8];
                4'd5  : dout[5] <= din[8];
                4'd6  : dout[6] <= din[8];
                4'd7  : dout[7] <= din[8];
                4'd8  : dout[8] <= din[8];
                4'd9  : dout[9] <= din[8];
                4'd10 : dout[10] <= din[8];
                4'd11 : dout[11] <= din[8];
                4'd12 : dout[12] <= din[8];
                4'd13 : dout[13] <= din[8];
                4'd14 : dout[14] <= din[8];
                4'd15 : dout[15] <= din[8];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din9
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter9 <= 3'd0;
        addr9 <= 4'd0;
    end else if(frame_n[9] == 1'b1) begin
        addr_counter9 <= 3'd0;
        addr9 <= 4'd0;
    end else if(frame_n[9] == 1'b0 && addr_counter9 != 3'b100) begin
        addr_counter9 <= addr_counter9 + 1'b1;
        addr9 <= addr9 << 1'b1;
        addr9[0] <= din[9];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[9] <= 1'b0;
    end else if(addr_counter9 == 3'b100) begin
        if(valid_n[9] == 1'b0 && frame_n[9] == 1'b0) begin
            case(addr9)
                4'd0  : dout[0] <= din[9];
                4'd1  : dout[1] <= din[9];
                4'd2  : dout[2] <= din[9];
                4'd3  : dout[3] <= din[9];
                4'd4  : dout[4] <= din[9];
                4'd5  : dout[5] <= din[9];
                4'd6  : dout[6] <= din[9];
                4'd7  : dout[7] <= din[9];
                4'd8  : dout[8] <= din[9];
                4'd9  : dout[9] <= din[9];
                4'd10 : dout[10] <= din[9];
                4'd11 : dout[11] <= din[9];
                4'd12 : dout[12] <= din[9];
                4'd13 : dout[13] <= din[9];
                4'd14 : dout[14] <= din[9];
                4'd15 : dout[15] <= din[9];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din10
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter10 <= 3'd0;
        addr10 <= 4'd0;
    end else if(frame_n[10] == 1'b1) begin
        addr_counter10 <= 3'd0;
        addr10 <= 4'd0;
    end else if(frame_n[10] == 1'b0 && addr_counter10 != 3'b100) begin
        addr_counter10 <= addr_counter10 + 1'b1;
        addr10 <= addr10 << 1'b1;
        addr10[0] <= din[10];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[10] <= 1'b0;
    end else if(addr_counter10 == 3'b100) begin
        if(valid_n[10] == 1'b0 && frame_n[10] == 1'b0) begin
            case(addr10)
                4'd0  : dout[0] <= din[10];
                4'd1  : dout[1] <= din[10];
                4'd2  : dout[2] <= din[10];
                4'd3  : dout[3] <= din[10];
                4'd4  : dout[4] <= din[10];
                4'd5  : dout[5] <= din[10];
                4'd6  : dout[6] <= din[10];
                4'd7  : dout[7] <= din[10];
                4'd8  : dout[8] <= din[10];
                4'd9  : dout[9] <= din[10];
                4'd10 : dout[10] <= din[10];
                4'd11 : dout[11] <= din[10];
                4'd12 : dout[12] <= din[10];
                4'd13 : dout[13] <= din[10];
                4'd14 : dout[14] <= din[10];
                4'd15 : dout[15] <= din[10];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din11
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter11 <= 3'd0;
        addr11 <= 4'd0;
    end else if(frame_n[11] == 1'b1) begin
        addr_counter11 <= 3'd0;
        addr11 <= 4'd0;
    end else if(frame_n[11] == 1'b0 && addr_counter11 != 3'b100) begin
        addr_counter11 <= addr_counter11 + 1'b1;
        addr11 <= addr11 << 1'b1;
        addr11[0] <= din[11];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[11] <= 1'b0;
    end else if(addr_counter11 == 3'b100) begin
        if(valid_n[11] == 1'b0 && frame_n[11] == 1'b0) begin
            case(addr11)
                4'd0  : dout[0] <= din[11];
                4'd1  : dout[1] <= din[11];
                4'd2  : dout[2] <= din[11];
                4'd3  : dout[3] <= din[11];
                4'd4  : dout[4] <= din[11];
                4'd5  : dout[5] <= din[11];
                4'd6  : dout[6] <= din[11];
                4'd7  : dout[7] <= din[11];
                4'd8  : dout[8] <= din[11];
                4'd9  : dout[9] <= din[11];
                4'd10 : dout[10] <= din[11];
                4'd11 : dout[11] <= din[11];
                4'd12 : dout[12] <= din[11];
                4'd13 : dout[13] <= din[11];
                4'd14 : dout[14] <= din[11];
                4'd15 : dout[15] <= din[11];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din12
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter12 <= 3'd0;
        addr12 <= 4'd0;
    end else if(frame_n[12] == 1'b1) begin
        addr_counter12 <= 3'd0;
        addr12 <= 4'd0;
    end else if(frame_n[12] == 1'b0 && addr_counter12 != 3'b100) begin
        addr_counter12 <= addr_counter12 + 1'b1;
        addr12 <= addr12 << 1'b1;
        addr12[0] <= din[12];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[12] <= 1'b0;
    end else if(addr_counter12 == 3'b100) begin
        if(valid_n[12] == 1'b0 && frame_n[12] == 1'b0) begin
            case(addr12)
                4'd0  : dout[0] <= din[12];
                4'd1  : dout[1] <= din[12];
                4'd2  : dout[2] <= din[12];
                4'd3  : dout[3] <= din[12];
                4'd4  : dout[4] <= din[12];
                4'd5  : dout[5] <= din[12];
                4'd6  : dout[6] <= din[12];
                4'd7  : dout[7] <= din[12];
                4'd8  : dout[8] <= din[12];
                4'd9  : dout[9] <= din[12];
                4'd10 : dout[10] <= din[12];
                4'd11 : dout[11] <= din[12];
                4'd12 : dout[12] <= din[12];
                4'd13 : dout[13] <= din[12];
                4'd14 : dout[14] <= din[12];
                4'd15 : dout[15] <= din[12];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din13
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter13 <= 3'd0;
        addr13 <= 4'd0;
    end else if(frame_n[13] == 1'b1) begin
        addr_counter13 <= 3'd0;
        addr13 <= 4'd0;
    end else if(frame_n[13] == 1'b0 && addr_counter13 != 3'b100) begin
        addr_counter13 <= addr_counter13 + 1'b1;
        addr13 <= addr13 << 1'b1;
        addr13[0] <= din[13];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[13] <= 1'b0;
    end else if(addr_counter13 == 3'b100) begin
        if(valid_n[13] == 1'b0 && frame_n[13] == 1'b0) begin
            case(addr13)
                4'd0  : dout[0] <= din[13];
                4'd1  : dout[1] <= din[13];
                4'd2  : dout[2] <= din[13];
                4'd3  : dout[3] <= din[13];
                4'd4  : dout[4] <= din[13];
                4'd5  : dout[5] <= din[13];
                4'd6  : dout[6] <= din[13];
                4'd7  : dout[7] <= din[13];
                4'd8  : dout[8] <= din[13];
                4'd9  : dout[9] <= din[13];
                4'd10 : dout[10] <= din[13];
                4'd11 : dout[11] <= din[13];
                4'd12 : dout[12] <= din[13];
                4'd13 : dout[13] <= din[13];
                4'd14 : dout[14] <= din[13];
                4'd15 : dout[15] <= din[13];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din14
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter14 <= 3'd0;
        addr14 <= 4'd0;
    end else if(frame_n[14] == 1'b1) begin
        addr_counter14 <= 3'd0;
        addr14 <= 4'd0;
    end else if(frame_n[14] == 1'b0 && addr_counter14 != 3'b100) begin
        addr_counter14 <= addr_counter14 + 1'b1;
        addr14 <= addr14 << 1'b1;
        addr14[0] <= din[14];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[14] <= 1'b0;
    end else if(addr_counter14 == 3'b100) begin
        if(valid_n[14] == 1'b0 && frame_n[14] == 1'b0) begin
            case(addr14)
                4'd0  : dout[0] <= din[14];
                4'd1  : dout[1] <= din[14];
                4'd2  : dout[2] <= din[14];
                4'd3  : dout[3] <= din[14];
                4'd4  : dout[4] <= din[14];
                4'd5  : dout[5] <= din[14];
                4'd6  : dout[6] <= din[14];
                4'd7  : dout[7] <= din[14];
                4'd8  : dout[8] <= din[14];
                4'd9  : dout[9] <= din[14];
                4'd10 : dout[10] <= din[14];
                4'd11 : dout[11] <= din[14];
                4'd12 : dout[12] <= din[14];
                4'd13 : dout[13] <= din[14];
                4'd14 : dout[14] <= din[14];
                4'd15 : dout[15] <= din[14];
            endcase
        end
    end
end

/////////////////////////////////////////////////
// din15
/////////////////////////////////////////////////

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        addr_counter15 <= 3'd0;
        addr15 <= 4'd0;
    end else if(frame_n[15] == 1'b1) begin
        addr_counter15 <= 3'd0;
        addr15 <= 4'd0;
    end else if(frame_n[15] == 1'b0 && addr_counter15 != 3'b100) begin
        addr_counter15 <= addr_counter15 + 1'b1;
        addr15 <= addr15 << 1'b1;
        addr15[0] <= din[15];
    end
end

always@(posedge clock or negedge reset_n) begin
    if(reset_n == 1'b0) begin
        dout[15] <= 1'b0;
    end else if(addr_counter15 == 3'b100) begin
        if(valid_n[15] == 1'b0 && frame_n[15] == 1'b0) begin
            case(addr15)
                4'd0  : dout[0] <= din[15];
                4'd1  : dout[1] <= din[15];
                4'd2  : dout[2] <= din[15];
                4'd3  : dout[3] <= din[15];
                4'd4  : dout[4] <= din[15];
                4'd5  : dout[5] <= din[15];
                4'd6  : dout[6] <= din[15];
                4'd7  : dout[7] <= din[15];
                4'd8  : dout[8] <= din[15];
                4'd9  : dout[9] <= din[15];
                4'd10 : dout[10] <= din[15];
                4'd11 : dout[11] <= din[15];
                4'd12 : dout[12] <= din[15];
                4'd13 : dout[13] <= din[15];
                4'd14 : dout[14] <= din[15];
                4'd15 : dout[15] <= din[15];
            endcase
        end
    end
end

endmodule
