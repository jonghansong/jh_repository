module watch(clk_1k,rst,seg,com,mode,up,led);

input clk_1k,rst,mode,up;
output [7:0]com,led;
output [7:0]seg;
reg clk_1,next_mode,d,e,u0,u1;
reg [8:0]clksup;
reg [3:0]sec_l,min_l,hour_l,sec_h,min_h,hour_h,apm,save_secl,save_sech,save_minl,save_minh,save_hourl,save_hourh,save_apm,timescan;
reg [7:0]com;
reg [2:0]st;
wire q,u;
wire [6:0]segscan;
wire [2:0]num,mode_data;
wire en_sl,en_sh,en_ml,en_mh,en_hl,en_hh;
parameter [2:0] nomal =4'b0000, secl_cor =4'b0001, sech_cor = 4'b0010, minl_cor = 4'b0011, minh_cor =4'b0100, hourl_cor =4'b0101, hourh_cor = 4'b0110, apm_cor =4'b0111;
//nomal : 정상모드  secl_cor : 초1단� 정정모드  sech_cor : 초10단� 정정모드  minl_cor : 분1단� 정정모드  minh_cor : 분10단� 정정모드 
//hourl_cor : 시1단� 정정모드  hourh_cor : 시10단� 정정모드  apm_cor : am,pm정정모드

function [6:0]segfunc;							//7segment FUNCTION
	input [3:0] a;
		case(a)	4'b0000 : segfunc = 7'b011_1111 ;	//0
			4'b0001 : segfunc = 7'b000_0110 ;	//1
			4'b0010 : segfunc = 7'b101_1011 ;	//2
			4'b0011 : segfunc = 7'b100_1111 ;	//3
			4'b0100 : segfunc = 7'b110_0110 ; 	//4
			4'b0101 : segfunc = 7'b110_1101 ; 	//5
			4'b0110 : segfunc = 7'b111_1101 ; 	//6
			4'b0111 : segfunc = 7'b010_0111 ;	//7
			4'b1000 : segfunc = 7'b111_1111 ;	//8
			4'b1001 : segfunc = 7'b110_1111 ;	//9
			4'b1010 : segfunc = 7'b111_0111 ;	//A
			4'b1011 : segfunc = 7'b111_0011 ;	//P
			default : segfunc = 7'b000_0000 ;
		endcase
endfunction

always@(negedge clk_1k) begin 					// clk_1=1hz
	if(clksup == 9'b1_1111_0011) begin			// 1khz로 0부터 499을 카운트 할�마다 clk_1이 반전되면서
		clk_1 <= !clk_1;						// 1hz의 클럭이 만들어짐
		clksup <= 0;
	end
	else clksup <= clksup +1;
end


always@(posedge clk_1k) begin	 //mode 버튼
	d<=mode;
end

always@(posedge clk_1k) begin
	e<=!d;
end

assign q = d & e;

always@(posedge clk_1k) begin	//up버튼
	u0<=up;
end

always@(posedge clk_1k) begin
	u1<=!u0;
end

assign u = u0 & u1;

assign en_sl = (mode_data ==nomal) ? 1: 0; // 정상모드에서만 초1단� enable :1 

always@(negedge clk_1 or posedge rst) begin					// sec_l
	if(rst) sec_l <= 0; 									// 리셋을 누르면 초1단� 0으로 초기화
	else if((mode_data == secl_cor)) sec_l <= save_secl;	// 초1단� 정정모드 일� 저장된 초1단� 값을 불러옴
	else if((sec_l == 9) && (en_sl))sec_l<=0;			// 9초이면 0초로 리셋
	else if(en_sl) sec_l <= sec_l + 1;					// 정상모드일 � 1hz에 1씩 증가
end

assign en_sh = ((en_sl) && (sec_l == 9)) ? 1 : 0;	// 정상모드이고 초1단�가 9이면 초10단� enable : 1

always@(negedge clk_1 or posedge rst) begin					// sec_h
	if(rst) sec_h<=0;										// 리셋을 누르면 초10단� 0으로 초기화
	else if((mode_data == sech_cor)) sec_h <= save_sech;	// 초10단� 정정모드 일� 저장된 초10단� 값을 불러옴
	else if((sec_h == 5) && (en_sh)) sec_h<=0;				// 59초이면 00초로 리셋
	else if(en_sh) sec_h <= sec_h+1;						// 9초마다 초10단� 1씩증가
end

assign en_ml = ((sec_h == 5) && (en_sh)) ? 1 : 0;			// 초10단� enable이 1이고 초10단�가 5이면 분1단� enable : 1

always@(negedge clk_1 or posedge rst) begin					// min_l	
	if(rst) min_l<=0;										// 리셋을 누르면 분1단� 0으로 초기화
	else if((mode_data == minl_cor)) min_l <= save_minl;	// 분1단� 정정모드 일� 저장된 분1단� 값을 불러옴
	else if((min_l==9) && (en_ml)) min_l<=0;				// 9분 59초이면 0분 00초로 리셋
	else if(en_ml) min_l <= min_l +1;						// 59초마다 분1단� 1씩 증가
end

assign en_mh = ((min_l == 9) && (en_ml)) ? 1 : 0;				// 분1단� enable이 1이고 분1단�가 9이면 분10단� enable : 1

always@(negedge clk_1 or posedge rst) begin					// min_h
	if(rst) min_h<=0;										// 리셋을 누르면 분10단� 0으로 초기화
	else if((mode_data == minh_cor)) min_h <= save_minh;	// 분10단� 정정모드 일� 저장된 분10단� 값을 불러옴
	else if((min_h==5) && (en_mh)) min_h<=0;				// 59분 59초이면 00분 00초로 리셋
	else if(en_mh) min_h <= min_h+1;						// 9분 59초 마다 분10단� 1씩 증가
end

assign en_hl = ((min_h == 5) && (en_mh)) ? 1: 0;				// 분10단� enable이 1이고 분10단�가 5이면 시1단� enable : 1
 
always@(negedge clk_1 or posedge rst) begin						// hour_l
	if(rst) hour_l<=2;											// 리셋을 누르면 시1단� 2로 초기화
	else if((mode_data == hourl_cor)) hour_l <= save_hourl; 	// 시1단� 정정모드 일� 저장된 시1단� 값을 불러옴
	else if((en_hl) && (hour_h == 1) && (hour_l == 2)) hour_l <= 1; // 12시 59분 59초이면 시1단� 1 할당
	else if((en_hl) && (hour_h == 1) && (hour_l == 1)) hour_l <= 2; // 11시 59분 59초이면 시1단� 2 할당
	else if((hour_l==9) && (en_hl)) hour_l <=0;					// 09시 59분 59초이면 시1단� 0 할당
	else if(en_hl)  hour_l<= hour_l+1; 							// 59분 59초마다 시1단� 1씩 증가
end

assign en_hh = ((hour_l == 9) && (en_hl)) ? 1: 0;					// 시1단� enable이 1이고 시1단�가 9이면 시10단� enable : 1

always@(negedge clk_1 or posedge rst) begin							// hour_h
	if(rst) hour_h<=1; 												// 리셋을 누르면 시10단� 1로 초기화
	else if(mode_data == hourh_cor) hour_h <= save_hourh;			// 시10단� 정정모드 일� 저장된 시10단� 값을 불러옴
	else if((en_hl) && (hour_h == 1) && (hour_l == 2)) hour_h <= 0;		// 12시 59분 59초이면 시1단� 0 할당 
	else if(en_hh) hour_h <= 1;										// 9시 59분 59초이면 시10단� 1 할당  
end

always@(negedge clk_1 or posedge rst) begin					// hour_h am=4'b1010 pm=4'b1011 
	if(rst) apm <=4'b1010;									// 리셋을 누르면 am으로 초기화
	else if(mode_data == apm_cor) apm <= save_apm;			// am,pm정정모드 일� 저장된 am,pm값을 불러옴 
	else if((en_hl) && (hour_h == 1) && (hour_l == 1) && (apm == 4'b1010)) apm <= 4'b1011;	// am 11시 59분 59초 이면 pm 
	else if((en_hl) && (hour_h == 1) && (hour_l == 1) && (apm == 4'b1011)) apm <= 4'b1010;	// pm 11시 59분 59초 이면 am
end

always@(posedge q or posedge rst) begin		// 모드상태 카운터
	if(rst) st <= 0;
	else if(st == 7) st <=0;
	else st <= st+1;
end

assign mode_data = (st == 0) ? nomal:				// 카운터데 따른 모드 상태
					(st == 1) ? secl_cor:	
					(st == 2) ? sech_cor:	
					(st == 3) ? minl_cor:	
					(st == 4) ? minh_cor:	
					(st == 5) ? hourl_cor:	
					(st == 6) ? hourh_cor: 	
					(st == 7) ? apm_cor : nomal;

assign led = (st==0) ? 8'b0000_0000 :					// 모드를 표시하기 �한 led점등
				(st==1) ? 8'b0000_0001 :
				(st==2) ? 8'b0000_0010 :
				(st==3) ? 8'b0000_0100 :
				(st==4) ? 8'b0000_1000 :
				(st==5) ? 8'b0001_0000 :
				(st==6) ? 8'b0010_0000 :
				(st==7) ? 8'b0100_0000 :8'b0000_0000;

always@(posedge u or posedge q) begin 								// 초1단� 정정
	if(q) save_secl <= sec_l;										// mode버튼을 누르면 현재 시간값을 저장
	else if((mode_data == secl_cor) && (save_secl ==9)) save_secl <=0;	// 초1단� 정정모드이고 저장된 시1값이 9이면서 up버튼을 누를면 0으로 할당
	else if(mode_data == secl_cor) save_secl <= save_secl +1;			// 초1단� 정정모드이고 up버튼을 누르면 
end

always@(posedge u or posedge q) begin 
	if(q) save_sech <= sec_h;
	else if((mode_data == sech_cor) && (save_sech ==5)) save_sech <=0;
	else if(mode_data == sech_cor) save_sech <= save_sech +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_minl <= min_l;										// mode버튼을 누르면 현재 시간값을 저장
	else if((mode_data == minl_cor) && (save_minl ==9)) save_minl <=0;
	else if(mode_data == minl_cor) save_minl <= save_minl +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_minh <= min_h;										// mode버튼을 누르면 현재 시간값을 저장
	else if((mode_data == minh_cor) && (save_minh ==5)) save_minh <=0;
	else if(mode_data == minh_cor) save_minh <= save_minh +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_hourl <= hour_l;										// mode버튼을 누르면 현재 시간값을 저장
	else if((mode_data == hourl_cor) && (save_hourl ==9)) save_hourl <=0;
	else if(mode_data == hourl_cor) save_hourl <= save_hourl +1;	
end

always@(posedge u or posedge q) begin 
	if(q) save_hourh <= hour_h;										// mode버튼을 누르면 현재 시간값을 저장
	else if((mode_data == hourh_cor) && (save_hourh ==1)) save_hourh <=0;
	else if((mode_data == hourh_cor) && (save_hourh ==0)) save_hourh <=1;	
end

always@(posedge u or posedge q) begin 
	if(q) save_apm <= apm;											// mode버튼을 누르면 현재 am,pm값을 저장
	else if((mode_data == apm_cor) && (save_apm == 4'b1010)) save_apm <= 4'b1011;
	else if((mode_data == apm_cor) && (save_apm == 4'b1011)) save_apm <= 4'b1010;
end

///////////////////////////////////////////////////////////////////////////////////////

assign num = {clksup[2],clksup[1],clksup[0]};

always@(negedge clk_1k) begin
	case(num) 3'b000 : timescan <= sec_l;
   		3'b001 : timescan <= sec_h;  
    	3'b010 : timescan <= min_l;  
    	3'b011 : timescan <= min_h; 
    	3'b100 : timescan <= hour_l; 
    	3'b101 : timescan <= hour_h;
    	3'b110 : timescan <= apm; 
		3'b111 : timescan <= sec_l; 	
	endcase
end

always@(negedge clk_1k) begin
	case(num) 3'b000 : if((mode_data == secl_cor) && (clk_1 ==1)) com <= 8'b1111_1110;
						else if((mode_data == secl_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1111_1110;
   		3'b001 : if((mode_data == sech_cor) && (clk_1 ==1)) com <= 8'b1111_1101;
						else if((mode_data == sech_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1111_1101;
    	3'b010 : if((mode_data == minl_cor) && (clk_1 ==1)) com <= 8'b1111_1011;
						else if((mode_data == minl_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1111_1011; 
    	3'b011 : if((mode_data == minh_cor) && (clk_1 ==1)) com <= 8'b1111_0111;
						else if((mode_data == minh_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1111_0111; 
    	3'b100 : if((mode_data == hourl_cor) && (clk_1 ==1)) com <= 8'b1110_1111;
						else if((mode_data == hourl_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1110_1111; 
    	3'b101 : if(hour_h ==0) com<=8'b1111_1111;
				 else if((mode_data == hourh_cor) && (clk_1 ==1)) com <= 8'b1101_1111;
						else if((mode_data == hourh_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1101_1111;
    	3'b110 : if((mode_data == apm_cor) && (clk_1 ==1)) com <= 8'b1011_1111;
						else if((mode_data == apm_cor) && (clk_1 ==0)) com <= 8'b1111_1111;
						else com <= 8'b1011_1111; 
    	3'b111 : com <= 8'b1111_1111; 
	endcase
end

assign segscan = segfunc(timescan);
assign seg = (num == 3'b011) ? {1'b1,segscan} :
			(num == 3'b101) ? {1'b1,segscan} : {1'b0,segscan};

endmodule



