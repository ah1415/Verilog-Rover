module LED_controller (input [25:0] dist_counter, input clk, output [9:0] LED);

	
	reg LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9;
	
	assign LED[0] = LED0;
	assign LED[1] = LED1;
	assign LED[2] = LED2;
	assign LED[3] = LED3;
	assign LED[4] = LED4;
	assign LED[5] = LED5;
	assign LED[6] = LED6;
	assign LED[7] = LED7;
	assign LED[8] = LED8;
	assign LED[9] = LED9;
	
	always @ (posedge clk)
	begin
		
		if (dist_counter >= 14500) 
			LED0 <= 1;	
		else 
			LED0 <= 0;
		
		if (dist_counter >= 29000)  
			LED1 <= 1;
		else 
			LED1 <= 0;
		
		if (dist_counter >= 43500) 
			LED2 <= 1;
		else 
			LED2 <= 0;
			
		if (dist_counter >= 58000)  
			LED3 <= 1;
		else 
			LED3 <= 0;
			
		if (dist_counter >= 72500) 
			LED4 <= 1;
		else 
			LED4 <= 0;
			
		if (dist_counter >= 87000)  
			LED5 <= 1;
		else 
			LED5 <= 0;
			
		if (dist_counter >= 101500) 
			LED6 <= 1;
		else 
			LED6 <= 0;
		
		if (dist_counter >= 116000)  
			LED7 <= 1;
		else 
			LED7 <= 0;
		
		if (dist_counter >= 130500) 
			LED8 <= 1;
		else 
			LED8 <= 0;
			
		if (dist_counter >= 145000)  
			LED9 <= 1;
		else 
			LED9 <= 0;
			
			
	end
	
	

endmodule
