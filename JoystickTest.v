//WRITE en

module adc_demo_mega (CLOCK_50, KEY,  LEDR, GPIO_0, GPIO_1, ADC_SCLK,
ADC_CS_N, ADC_DOUT, ADC_DIN, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

input CLOCK_50;
input [0:0]KEY;
input ADC_DOUT;
input [35:0] GPIO_0;
output [9:0] LEDR;
output ADC_SCLK, ADC_CS_N, ADC_DIN;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

//Pin 0 = en1, 1, 2 = motor dir 1, Pin 5 = en2, 3, 4 = motor dir 4,
output [35:0] GPIO_1;

wire [11:0] values [7:0];

reg l1, l2, r1, r2;

//1/2s sampling rate
wire [25:0] rate = 26'd12499999;
reg en;///////
wire Enable;

reg [25:0] RateDivider;
reg [11:0] x, y;
reg [16:0] x1, y1;
localparam xmax = 12'd3295, ymax = 12'd3295, xmin = 12'd0, ymin= 12'd3, xmid = 12'd1620, ymid = 12'd1606;

reg [16:0] motorv1, motorv2, motorv1i, motorv2i;
//Count 1/2s
always@(posedge CLOCK_50)
	begin
		if(RateDivider != 26'b0)
			RateDivider= RateDivider-1'b1;
		else
			RateDivider=rate;
	end
assign Enable = (RateDivider == 26'b0)?1'b1:1'b0;


//Read the joystick and determine motor direction and magnitude
always@(posedge Enable)
begin
	x=values[0];
	y=values[1];
	
	//Backwards
	if(y<(ymid-3'd7))begin
	
		//Left Motor Backwards
		l1 = 1'b1;
		l2 = 1'b0;
		
		//Right Motor Backwards
		r1 = 1'b1;
		r2 = 1'b0;
		
		y1=(ymid-y)*6'd62;
		
		//Convert to constant math later
		
		motorv1 = y1;
		motorv2 = y1;
		en=1'b1;
		
		
	end
	
	
	//Forwards
	else if(y>(ymid+3'd7))begin
	
		//Left Motor Forwards
		l1 = 1'b0;
		l2 = 1'b1;
		
		//Right Motor Forwards
		r1 = 1'b0;
		r2 = 1'b1;
		y1 = y*6'd59-17'd94754;
		//Convert to constant math later
		motorv1 = y1;
		motorv2 = y1;
		
		en=1'b0;
		
	end
	
	//Stopped
	else begin
		motorv1 = 17'b0;
		motorv2 = 17'b0;
		en=1'b0;
	end
	
	//Left
	if(x<xmid)begin
		
		x1=(xmid-x)*6'd62;
		
		if(motorv1 < x1)begin
			motorv1 = 17'b0;
		end
		
		else begin
		motorv1 = motorv1 - x1;
		end
		
		if((motorv2 + x1) > 17'd100000)begin
		motorv2 = 17'd100000;
		end
		else
			motorv2 = motorv2 + x1;
		
		
	end

	else if(x>xmid)begin
		x1= x*6'd60-17'd97200;
		
		
		if(motorv2 < x1)begin
			motorv2 = 17'b0;
		end
		
		else begin
		motorv2 = motorv2 - x1;
		end
		
		
		if((motorv1 +x1)> 17'd100000)begin
		motorv1 = 17'd100000;
		end
		else
		motorv1 = motorv1 + x1;
		
	end
	motorv1i=motorv1;
	motorv2i=motorv2;
end

assign GPIO_1[0] = l1;
assign GPIO_1[1] = l2;
assign GPIO_1[2] = r1;
assign GPIO_1[3] = r2;

PWM Left(motorv1i, CLOCK_50, GPIO_1[4]);
PWM Right(motorv2i, CLOCK_50, GPIO_1[5]);
	


joystick ADC (
.CLOCK (CLOCK_50),
.RESET (~KEY[0]),
.ADC_SCLK (ADC_SCLK),
.ADC_CS_N (ADC_CS_N),
.ADC_DOUT (ADC_DOUT),
.ADC_DIN (ADC_DIN),
.CH0 (values[0]),
.CH1 (values[1]),
.CH2 (values[2]),
.CH3 (values[3]),
.CH4 (values[4]),
.CH5 (values[5]),
.CH6 (values[6]),
.CH7 (values[7])
);

ultrasonic_sensor_v2 u0(GPIO_0[35], CLOCK_50, en,	// SW is for testing enable for buzzer 
	LEDR, GPIO_1[34], GPIO_1[35],
	HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

ADXLTest a0(GPIO_1[19:10],CLOCK_50,GPIO_0[8:0]);
endmodule

module PWM(input [16:0]val, input clk, output sig);
	
	
	localparam hz500 = 17'd100000;
	reg [16:0] RateDivider = 17'd0;
	always@(posedge clk)
	begin
		if(RateDivider < hz500)
			RateDivider= RateDivider+1'b1;
		else
			RateDivider=17'd0;
	end
	assign sig = (RateDivider<val)?1'b1:1'b0;
	
endmodule

//Convert Input Signals into HEX
module HEXDecoder(input [3:0] c,
					   output [6:0] sig);

	wire [6:0] eqn;
	
	//Equation for HEX LED 0
	assign eqn[0] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & c[1] & c[0]) | 
				(~c[3] & c[2] & ~c[1] & c[0]) | 
				(~c[3] & c[2] & c[1] & ~c[0]) | 
				(~c[3] & c[2] & c[1] & c[0]) | 
				(c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(c[3] & ~c[2] & ~c[1] & c[0]) | 
				(c[3] & ~c[2] & c[1] & ~c[0]) | 
				(c[3] & c[2] & ~c[1] & ~c[0]) | 
				(c[3] & c[2] & c[1] & ~c[0]) | 
				(c[3] & c[2] & c[1] & c[0]);
	
	//Equation for HEX LED 1	
	assign eqn[1] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & ~c[1] & c[0]) |
				(~c[3] & ~c[2] & c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & c[1] & c[0]) | 
				(~c[3] & c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & c[2] & c[1] & c[0]) | 
				(c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(c[3] & ~c[2] & ~c[1] & c[0]) | 
				(c[3] & ~c[2] & c[1] & ~c[0]) | 
				(c[3] & c[2] & ~c[1] & c[0]);
				
	//Equation for HEX LED 2
	assign eqn[2] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & ~c[1] & c[0]) |
				(~c[3] & ~c[2] & c[1] & c[0]) | 
				(~c[3] & c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & c[2] & ~c[1] & c[0]) | 
				(~c[3] & c[2] & c[1] & ~c[0]) | 
				(~c[3] & c[2] & c[1] & c[0]) | 
				(c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(c[3] & ~c[2] & ~c[1] & c[0]) | 
				(c[3] & ~c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & c[1] & c[0]) |
				(c[3] & c[2] & ~c[1] & c[0]);
	
	//Equation for HEX LED 3
	assign eqn[3] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(~c[3] & ~c[2] & c[1] & ~c[0]) |
				(~c[3] & ~c[2] & c[1] & c[0]) | 
				(~c[3] & c[2] & ~c[1] & c[0]) | 
				(~c[3] & c[2] & c[1] & ~c[0]) | 
				(c[3] & ~c[2] & ~c[1] & ~c[0]) | 
				(c[3] & ~c[2] & ~c[1] & c[0]) | 
				(c[3] & ~c[2] & c[1] & c[0]) |
				(c[3] & c[2] & ~c[1] & ~c[0]) |
				(c[3] & c[2] & ~c[1] & c[0]) |
				(c[3] & c[2] & c[1] & ~c[0]);
	
	//Equation for HEX LED 4
	assign eqn[4] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) |
				(~c[3] & ~c[2] & c[1] & ~c[0]) |
				(~c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & ~c[1] & ~c[0]) |
				(c[3] & ~c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & c[1] & c[0]) |
				(c[3] & c[2] & ~c[1] & ~c[0]) |
				(c[3] & c[2] & ~c[1] & c[0]) |
				(c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & c[2] & c[1] & c[0]);
				
	//Equation for HEX LED 5
	assign eqn[5] = (~c[3] & ~c[2] & ~c[1] & ~c[0]) |
				(~c[3] & c[2] & ~c[1] & ~c[0]) |
				(~c[3] & c[2] & ~c[1] & c[0]) |
				(~c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & ~c[1] & ~c[0]) |
				(c[3] & ~c[2] & ~c[1] & c[0]) |
				(c[3] & ~c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & c[1] & c[0]) |
				(c[3] & c[2] & ~c[1] & ~c[0]) |
				(c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & c[2] & c[1] & c[0]);
				
	//Equation for HEX LED 6
	assign eqn[6] = (~c[3] & ~c[2] & c[1] & ~c[0]) |
				(~c[3] & ~c[2] & c[1] & c[0]) |
				(~c[3] & c[2] & ~c[1] & ~c[0]) |
				(~c[3] & c[2] & ~c[1] & c[0]) |
				(~c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & ~c[1] & ~c[0]) |
				(c[3] & ~c[2] & ~c[1] & c[0]) |
				(c[3] & ~c[2] & c[1] & ~c[0]) |
				(c[3] & ~c[2] & c[1] & c[0]) |
				(c[3] & c[2] & ~c[1] & c[0]) |
				(c[3] & c[2] & c[1] & ~c[0]) |
				(c[3] & c[2] & c[1] & c[0]);
	
	//Invert Equation Output Due to Common Anode
	assign sig = ~eqn;
	
endmodule
module LCDTest(input CLK, input [3:0]X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3, output [9:0]lcdcontrol);
	
wire clk;
	reg [7:0] clkcnt;
	always@(posedge CLK)
	begin
		if(clkcnt==1'b0)
			clkcnt<=8'b11001000;
		else
			clkcnt<=clkcnt-1'b1;
	end
	assign clk= (clkcnt==8'b0)?1'b1:1'b0;
	
	reg[6:0]current_state,next_state;
	
	reg[6:0]counter;
	wire en;
	always@(posedge clk)
	begin
	if(counter !=6'b0)	
		counter = counter-6'b1;
	else
		counter = 6'd40;
	end
	assign en = (counter==6'b0)?1'b1:1'b0;
	localparam  
					 S_FUNC = 7'd0,
					 S_FUNC_WAIT = 7'd1,
					 S_DISP         = 7'd2,
                S_DISP_WAIT    = 7'd3,
					 S_ENT         = 7'd4,
					 S_ENT_WAIT	 	  = 7'd5,
					 S_XP = 7'd6,
					 S_XP_WAIT		     = 7'd7,
					 S_XW = 7'd8,
					 S_XW_WAIT = 7'd9,
					 S_XC		     = 7'd10,
					 S_XC_WAIT = 7'd11,
					 S_YP = 7'd12,
					 S_YP_WAIT		     = 7'd13,
					 S_YW = 7'd14,
					 S_YW_WAIT = 7'd15,
					 S_YC		     = 7'd16,
					 S_YC_WAIT = 7'd17,
					 S_ZP = 7'd18,
					 S_ZP_WAIT		     = 7'd19,
					 S_ZW = 7'd20,
					 S_ZW_WAIT = 7'd21,
					 S_ZC		     = 7'd22,
					 S_ZC_WAIT = 7'd23,
					 S_UP=7'd24,
					 S_U_WAIT=7'd25,
					 S_UM=7'd26,
					 S_UM_WAIT=7'd27,
					 S_USL=7'd28,
					 S_USL_WAIT=7'd29,
					 S_US=7'd30,
					 S_US_WAIT=7'd31,
					 S_UE=7'd32,
					 S_UE_WAIT=7'd33,
					 S_UT=7'd34,
					 S_UT_WAIT=7'd35,
					 S_XVP=7'd36,
					 S_XVP_WAIT=7'd37,
					 S_XV1=7'd38,
					 S_XV1_WAIT=7'd39,
					 S_XV2=7'd40,
					 S_XV2_WAIT=7'd41,
					 S_XD=7'd42,
					 S_XD_WAIT=7'd43,
					 S_XV3=7'd44,
					 S_XV3_WAIT =7'd45;
	
	
    // Next state logic aka our state table
    always@(*)
    begin: state_table 
            case (current_state)
					 current_state: next_state=(en==1'b1)?((current_state==7'd46)?7'd36:(current_state+1'b1)):current_state;
            default:     next_state = 7'd0;
        endcase
    end // s
	
	
	//RW to gnd
	reg [7:0] data;
	reg RS;
	reg E;
	
	always @(*)
	begin
		case(current_state)
		
		S_FUNC: begin
		//State Machine Function Set
			data<=8'b00111000;
			RS<=1'b0;
			E<=1'b1;
		end
		S_FUNC_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
		end
	
	S_DISP: begin
	//Display
	data<=8'b00001100;
	RS<=1'b0;
	E<=1'b1;
	end
	S_DISP_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_ENT:begin
	//Entry
	data<=8'b00000110;
	RS<=1'b0;
	E<=1'b1;
	end
	S_ENT_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	/*
	//Clear
	data<=8'b00000001;
	RS<=1'b0;
	*/
	//X:
	S_XP: begin
	data<=8'b10000000;
	RS<=1'b0;
	E<=1'b1;
	end
	S_XP_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_XW: begin
	data<=8'b01011000;
	RS<=1'b1;
	E<=1'b1;
	end
	S_XW_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_XC: begin
	data<=8'b00111010;
	RS<=1'b1;
	E<=1'b1;
	end
	S_XC_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	
	S_YP: begin
	data<=8'b10001000;
	RS<=1'b0;
	E<=1'b1;
	end
	S_YP_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_YW: begin
	data<=8'b01011001;
	RS<=1'b1;
	E<=1'b1;
	end
	S_YW_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_YC: begin
	data<=8'b00111010;
	RS<=1'b1;
	E<=1'b1;
	end
	S_YC_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	
	S_ZP: begin
	data<=8'b11000000;
	RS<=1'b0;
	E<=1'b1;
	end
	S_ZP_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_ZW: begin
	data<=8'b01011010;
	RS<=1'b1;
	E<=1'b1;
	end
	S_ZW_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_ZC: begin
	data<=8'b00111010;
	RS<=1'b1;
	E<=1'b1;
	end
	S_ZC_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_UP:begin
	//m/s2
	data<=8'b11001000;
	RS<=1'b0;
	E<=1'b1;
	end
	S_U_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_UM:begin
	data<=8'b01101101;
	RS<=1'b1;
	E<=1'b1;
	end
	S_UM_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_USL: begin
	data<=8'b00101111;
	RS=1'b1;
	E<=1'b1;
	end
	S_USL_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_US:begin
	data<=8'b01110011;
	RS<=1'b1;
	E<=1'b1;
	end
	S_US_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_UE:begin
	data<=8'b01011110;
	RS<=1'b1;
	E<=1'b1;
	end
	S_UE_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_UT:begin
	data<=8'b00110010;
	RS<=1'b1;
	E<=1'b1;
	end
	S_UT_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_XVP:begin
	//xval
	data<=8'b11000000;
	RS<=1'b0;
	E<=1'b1;
	end
	S_XVP_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_XV1:begin
	data<={4'b0011, X1};
	RS<=1'b1;
	E<=1'b1;
	end
	S_XV1_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	
	S_XV2:begin
	data<={4'b0011, X2};
	RS<=1'b1;
	E<=1'b1;
	end
	S_XV2_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_XD:begin
	data<=8'b00101110;
	RS<=1'b1;
	E<=1'b1;
	end
	S_XD_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	S_XV3:begin
	data<={4'b0011, X3};
	RS<=1'b1;
	E<=1'b1;
	end
	S_XV3_WAIT: begin
		//State Machine Function Set
			E<=1'b0;
	end
	endcase
	end

	
always@(posedge clk)
    begin: state_FFs
            current_state <= next_state;
    end // state_FFS
	
	
	assign lcdcontrol[9:2]=data;
	assign lcdcontrol[1]=E;
	assign lcdcontrol[0]=RS;
endmodule

module ADXLTest(output [9:0]out, input CLK,input [8:0]in);

wire [3:0]X2,X3,X1, Y1=4'b0, Y2=4'b0, Y3=4'b0,Z1=4'b0, Z2=4'b0, Z3=4'b0;
		assign X2=in[3:0];
		assign X3=in[7:4];
		assign X1={3'b0,in[8]};

		LCDTest l0(CLK, X1,X2,X3,Y1,Y2,Y3,Z1,Z2,Z3,out[9:0]);
endmodule