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
//nomal : Á¤»ó¸ðµå  secl_cor : ÃÊ1´ÜÀ Á¤Á¤¸ðµå  sech_cor : ÃÊ10´ÜÀ Á¤Á¤¸ðµå  minl_cor : ºÐ1´ÜÀ Á¤Á¤¸ðµå  minh_cor : ºÐ10´ÜÀ Á¤Á¤¸ðµå 
//hourl_cor : ½Ã1´ÜÀ Á¤Á¤¸ðµå  hourh_cor : ½Ã10´ÜÀ Á¤Á¤¸ðµå  apm_cor : am,pmÁ¤Á¤¸ðµå

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
	if(clksup == 9'b1_1111_0011) begin			// 1khz·Î 0ºÎÅÍ 499À» Ä«¿îÆ® ÇÒ¶¸¶´Ù clk_1ÀÌ ¹ÝÀüµÇ¸é¼­
		clk_1 <= !clk_1;						// 1hzÀÇ Å¬·°ÀÌ ¸¸µé¾îÁü
		clksup <= 0;
	end
	else clksup <= clksup +1;
end


always@(posedge clk_1k) begin	 //mode ¹öÆ°
	d<=mode;
end

always@(posedge clk_1k) begin
	e<=!d;
end

assign q = d & e;

always@(posedge clk_1k) begin	//up¹öÆ°
	u0<=up;
end

always@(posedge clk_1k) begin
	u1<=!u0;
end

assign u = u0 & u1;

assign en_sl = (mode_data ==nomal) ? 1: 0; // Á¤»ó¸ðµå¿¡¼­¸¸ ÃÊ1´ÜÀ enable :1 

always@(negedge clk_1 or posedge rst) begin					// sec_l
	if(rst) sec_l <= 0; 									// ¸®¼ÂÀ» ´©¸£¸é ÃÊ1´ÜÀ 0À¸·Î ÃÊ±âÈ­
	else if((mode_data == secl_cor)) sec_l <= save_secl;	// ÃÊ1´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ÃÊ1´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((sec_l == 9) && (en_sl))sec_l<=0;			// 9ÃÊÀÌ¸é 0ÃÊ·Î ¸®¼Â
	else if(en_sl) sec_l <= sec_l + 1;					// Á¤»ó¸ðµåÀÏ ¶ 1hz¿¡ 1¾¿ Áõ°¡
end

assign en_sh = ((en_sl) && (sec_l == 9)) ? 1 : 0;	// Á¤»ó¸ðµåÀÌ°í ÃÊ1´ÜÀ°¡ 9ÀÌ¸é ÃÊ10´ÜÀ enable : 1

always@(negedge clk_1 or posedge rst) begin					// sec_h
	if(rst) sec_h<=0;										// ¸®¼ÂÀ» ´©¸£¸é ÃÊ10´ÜÀ 0À¸·Î ÃÊ±âÈ­
	else if((mode_data == sech_cor)) sec_h <= save_sech;	// ÃÊ10´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ÃÊ10´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((sec_h == 5) && (en_sh)) sec_h<=0;				// 59ÃÊÀÌ¸é 00ÃÊ·Î ¸®¼Â
	else if(en_sh) sec_h <= sec_h+1;						// 9ÃÊ¸¶´Ù ÃÊ10´ÜÀ 1¾¿Áõ°¡
end

assign en_ml = ((sec_h == 5) && (en_sh)) ? 1 : 0;			// ÃÊ10´ÜÀ enableÀÌ 1ÀÌ°í ÃÊ10´ÜÀ°¡ 5ÀÌ¸é ºÐ1´ÜÀ enable : 1

always@(negedge clk_1 or posedge rst) begin					// min_l	
	if(rst) min_l<=0;										// ¸®¼ÂÀ» ´©¸£¸é ºÐ1´ÜÀ 0À¸·Î ÃÊ±âÈ­
	else if((mode_data == minl_cor)) min_l <= save_minl;	// ºÐ1´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ºÐ1´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((min_l==9) && (en_ml)) min_l<=0;				// 9ºÐ 59ÃÊÀÌ¸é 0ºÐ 00ÃÊ·Î ¸®¼Â
	else if(en_ml) min_l <= min_l +1;						// 59ÃÊ¸¶´Ù ºÐ1´ÜÀ 1¾¿ Áõ°¡
end

assign en_mh = ((min_l == 9) && (en_ml)) ? 1 : 0;				// ºÐ1´ÜÀ enableÀÌ 1ÀÌ°í ºÐ1´ÜÀ°¡ 9ÀÌ¸é ºÐ10´ÜÀ enable : 1

always@(negedge clk_1 or posedge rst) begin					// min_h
	if(rst) min_h<=0;										// ¸®¼ÂÀ» ´©¸£¸é ºÐ10´ÜÀ 0À¸·Î ÃÊ±âÈ­
	else if((mode_data == minh_cor)) min_h <= save_minh;	// ºÐ10´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ºÐ10´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((min_h==5) && (en_mh)) min_h<=0;				// 59ºÐ 59ÃÊÀÌ¸é 00ºÐ 00ÃÊ·Î ¸®¼Â
	else if(en_mh) min_h <= min_h+1;						// 9ºÐ 59ÃÊ ¸¶´Ù ºÐ10´ÜÀ 1¾¿ Áõ°¡
end

assign en_hl = ((min_h == 5) && (en_mh)) ? 1: 0;				// ºÐ10´ÜÀ enableÀÌ 1ÀÌ°í ºÐ10´ÜÀ°¡ 5ÀÌ¸é ½Ã1´ÜÀ enable : 1
 
always@(negedge clk_1 or posedge rst) begin						// hour_l
	if(rst) hour_l<=2;											// ¸®¼ÂÀ» ´©¸£¸é ½Ã1´ÜÀ 2·Î ÃÊ±âÈ­
	else if((mode_data == hourl_cor)) hour_l <= save_hourl; 	// ½Ã1´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ½Ã1´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((en_hl) && (hour_h == 1) && (hour_l == 2)) hour_l <= 1; // 12½Ã 59ºÐ 59ÃÊÀÌ¸é ½Ã1´ÜÀ 1 ÇÒ´ç
	else if((en_hl) && (hour_h == 1) && (hour_l == 1)) hour_l <= 2; // 11½Ã 59ºÐ 59ÃÊÀÌ¸é ½Ã1´ÜÀ 2 ÇÒ´ç
	else if((hour_l==9) && (en_hl)) hour_l <=0;					// 09½Ã 59ºÐ 59ÃÊÀÌ¸é ½Ã1´ÜÀ 0 ÇÒ´ç
	else if(en_hl)  hour_l<= hour_l+1; 							// 59ºÐ 59ÃÊ¸¶´Ù ½Ã1´ÜÀ 1¾¿ Áõ°¡
end

assign en_hh = ((hour_l == 9) && (en_hl)) ? 1: 0;					// ½Ã1´ÜÀ enableÀÌ 1ÀÌ°í ½Ã1´ÜÀ°¡ 9ÀÌ¸é ½Ã10´ÜÀ enable : 1

always@(negedge clk_1 or posedge rst) begin							// hour_h
	if(rst) hour_h<=1; 												// ¸®¼ÂÀ» ´©¸£¸é ½Ã10´ÜÀ 1·Î ÃÊ±âÈ­
	else if(mode_data == hourh_cor) hour_h <= save_hourh;			// ½Ã10´ÜÀ Á¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ ½Ã10´ÜÀ °ªÀ» ºÒ·¯¿È
	else if((en_hl) && (hour_h == 1) && (hour_l == 2)) hour_h <= 0;		// 12½Ã 59ºÐ 59ÃÊÀÌ¸é ½Ã1´ÜÀ 0 ÇÒ´ç 
	else if(en_hh) hour_h <= 1;										// 9½Ã 59ºÐ 59ÃÊÀÌ¸é ½Ã10´ÜÀ 1 ÇÒ´ç  
end

always@(negedge clk_1 or posedge rst) begin					// hour_h am=4'b1010 pm=4'b1011 
	if(rst) apm <=4'b1010;									// ¸®¼ÂÀ» ´©¸£¸é amÀ¸·Î ÃÊ±âÈ­
	else if(mode_data == apm_cor) apm <= save_apm;			// am,pmÁ¤Á¤¸ðµå ÀÏ¶ ÀúÀåµÈ am,pm°ªÀ» ºÒ·¯¿È 
	else if((en_hl) && (hour_h == 1) && (hour_l == 1) && (apm == 4'b1010)) apm <= 4'b1011;	// am 11½Ã 59ºÐ 59ÃÊ ÀÌ¸é pm 
	else if((en_hl) && (hour_h == 1) && (hour_l == 1) && (apm == 4'b1011)) apm <= 4'b1010;	// pm 11½Ã 59ºÐ 59ÃÊ ÀÌ¸é am
end

always@(posedge q or posedge rst) begin		// ¸ðµå»óÅÂ Ä«¿îÅÍ
	if(rst) st <= 0;
	else if(st == 7) st <=0;
	else st <= st+1;
end

assign mode_data = (st == 0) ? nomal:				// Ä«¿îÅÍµ¥ µû¸¥ ¸ðµå »óÅÂ
					(st == 1) ? secl_cor:	
					(st == 2) ? sech_cor:	
					(st == 3) ? minl_cor:	
					(st == 4) ? minh_cor:	
					(st == 5) ? hourl_cor:	
					(st == 6) ? hourh_cor: 	
					(st == 7) ? apm_cor : nomal;

assign led = (st==0) ? 8'b0000_0000 :					// ¸ðµå¸¦ Ç¥½ÃÇÏ±â ÀÇÑ ledÁ¡µî
				(st==1) ? 8'b0000_0001 :
				(st==2) ? 8'b0000_0010 :
				(st==3) ? 8'b0000_0100 :
				(st==4) ? 8'b0000_1000 :
				(st==5) ? 8'b0001_0000 :
				(st==6) ? 8'b0010_0000 :
				(st==7) ? 8'b0100_0000 :8'b0000_0000;

always@(posedge u or posedge q) begin 								// ÃÊ1´ÜÀ Á¤Á¤
	if(q) save_secl <= sec_l;										// mode¹öÆ°À» ´©¸£¸é ÇöÀç ½Ã°£°ªÀ» ÀúÀå
	else if((mode_data == secl_cor) && (save_secl ==9)) save_secl <=0;	// ÃÊ1´ÜÀ Á¤Á¤¸ðµåÀÌ°í ÀúÀåµÈ ½Ã1°ªÀÌ 9ÀÌ¸é¼­ up¹öÆ°À» ´©¸¦¸é 0À¸·Î ÇÒ´ç
	else if(mode_data == secl_cor) save_secl <= save_secl +1;			// ÃÊ1´ÜÀ Á¤Á¤¸ðµåÀÌ°í up¹öÆ°À» ´©¸£¸é 
end

always@(posedge u or posedge q) begin 
	if(q) save_sech <= sec_h;
	else if((mode_data == sech_cor) && (save_sech ==5)) save_sech <=0;
	else if(mode_data == sech_cor) save_sech <= save_sech +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_minl <= min_l;										// mode¹öÆ°À» ´©¸£¸é ÇöÀç ½Ã°£°ªÀ» ÀúÀå
	else if((mode_data == minl_cor) && (save_minl ==9)) save_minl <=0;
	else if(mode_data == minl_cor) save_minl <= save_minl +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_minh <= min_h;										// mode¹öÆ°À» ´©¸£¸é ÇöÀç ½Ã°£°ªÀ» ÀúÀå
	else if((mode_data == minh_cor) && (save_minh ==5)) save_minh <=0;
	else if(mode_data == minh_cor) save_minh <= save_minh +1;
end

always@(posedge u or posedge q) begin 
	if(q) save_hourl <= hour_l;										// mode¹öÆ°À» ´©¸£¸é ÇöÀç ½Ã°£°ªÀ» ÀúÀå
	else if((mode_data == hourl_cor) && (save_hourl ==9)) save_hourl <=0;
	else if(mode_data == hourl_cor) save_hourl <= save_hourl +1;	
end

always@(posedge u or posedge q) begin 
	if(q) save_hourh <= hour_h;										// mode¹öÆ°À» ´©¸£¸é ÇöÀç ½Ã°£°ªÀ» ÀúÀå
	else if((mode_data == hourh_cor) && (save_hourh ==1)) save_hourh <=0;
	else if((mode_data == hourh_cor) && (save_hourh ==0)) save_hourh <=1;	
end

always@(posedge u or posedge q) begin 
	if(q) save_apm <= apm;											// mode¹öÆ°À» ´©¸£¸é ÇöÀç am,pm°ªÀ» ÀúÀå
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



