module ultrasonic_sensor_v2(input echo, input clk, en,	// SW is for testing enable for buzzer 
	output [9:0]LED, output trig, buzz,
	output [6:0] H0, H1, H2, H3, H4, H5);
	
	reg GPIO_1_reg;
	
	assign trig = GPIO_1_reg;
	
	reg [25:0] counter;
	reg [22:0] dist_count;
	always@(posedge clk)
	begin
		
		counter<=counter+1'b1;
		
		//10 us trig
		if(counter<=9'd500)
			GPIO_1_reg<=1'b1;
		else
			GPIO_1_reg<=1'b0;
		
		//Distance Clock count
		if(echo==1'b1)
			dist_count<=dist_count+1'b1;
		
		//resets
		if(counter==26'd50000000)
		begin
		counter<=26'b0;
		dist_count<=23'b0;
		end
		
	end
	HEXDecoder hex0(dist_count[3:0], H0);
	HEXDecoder hex1(dist_count[7:4], H1);
	HEXDecoder hex2(dist_count[11:8], H2);
	HEXDecoder hex3(dist_count[15:12], H3);
	HEXDecoder hex4(dist_count[19:16], H4);
	HEXDecoder hex5(dist_count[22:20], H5);
	
	
	LED_controller LED_system (.dist_counter(dist_count), .clk(clk), .LED(LED));
	
	reverse_buzzer buzzer (.enable(en), .clk(clk), .buzz(buzz));


endmodule

module reverse_buzzer (input enable, input clk, output buzz);

	
	
	reg [28:0] count = 29'd0;
	
	
	reg buzz_reg;
	
	assign buzz = buzz_reg;
	
	always @ (posedge clk)
	begin
		count <= count + 1;
		
		if (enable == 1'b1)
		begin
			if (count < 29'd50000001) 
				begin	
					buzz_reg <= 1'd1;		
				end
			else if (count < 29'd100000001)
				begin
					buzz_reg <= 1'd0;	
				end
			
			if (count == 29'd100000001)
				begin
					count <= 29'd0;	
				end
		end
		else
			buzz_reg<=1'd0;
		
	end


endmodule

