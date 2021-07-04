`timescale 1ns/1ns

module FE_16JHSONG_AHB_IF(
		input              HCLK,
		input              RST,
        input       [31:0] HADDR,
		input       [ 1:0] HTRANS,
		input              HWRITE,
		input       [ 2:0] HBURST,
		input       [ 2:0] HSIZE,
		input       [31:0] HWDATA,
		input       [ 3:0] HPROT,
	    output wire        HGRANT,
		output wire [31:0] HRDATA,
		output reg         HREADY,
		output wire [ 1:0] HRESP,
		input       [31:0] rdata,
		output reg  [ 9:0] addr,
		output reg         wen,
		output reg         en,
		output reg  [31:0] wdata);

	localparam ST_IDLE = 0, ST_WRITE =1, ST_READ0 =2, ST_READ1 = 3;
	reg [1:0] state;
	reg       reg_write;

	assign HRESP = 2'b00;
	assign HGRANT = 1; 

	always@(posedge HCLK) begin
		reg_write <= HWRITE;
	end							  

	always@(posedge HCLK or negedge RST) begin
		if(!RST) begin state <= ST_IDLE;
			en <= 0;
			wen <= 0;
			addr <= 0;
			wdata <= 0;
			HREADY <= 1; end
	    else 
	        case(state) 
	        ST_IDLE : begin
			    HREADY <= 1;
			    wdata <= 0;
			    en <= 0;
			    wen <= 0;	
			    if((HTRANS == 2'b10) && HWRITE) begin 
     			    state <= ST_WRITE;
			  	    en <= 0;
				    wen <= reg_write;
				    addr <= HADDR[9:0]; end
			    else if(HTRANS == 2'b10) begin
    			    state <= ST_READ0;
				    en <= 1;
				    addr <= HADDR[9:0];
				    wen <= reg_write/*0*/;
				    HREADY <= 0; end
			    else
    			    state <= ST_IDLE;
			end
			ST_WRITE : begin
			    en <= 1;
				wen <= reg_write;
				state <= ST_IDLE; 
				wdata <= HWDATA;
			end
			ST_READ0 : begin
			    en <= 0;
			    state <= ST_READ1;
			    HREADY<=1; 
			end
			ST_READ1 : begin
			    en <=0;
				state <= ST_IDLE;
				HREADY<=1;
			end
			default : state <= ST_IDLE;
		    endcase
	end	

	assign HRDATA = rdata;

endmodule
