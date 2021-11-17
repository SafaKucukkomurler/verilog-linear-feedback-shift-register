module lfsr
    #(
        parameter DATAWITH = 10      // # data bits                  
    )
    
    (
    input clk, load, en,
    input [DATAWITH-1 : 0] polynomial,
    output [DATAWITH-1 : 0] led //output number
    );
	
	//reg [DATAWITH-1 : 0] led = 2**DATAWITH - 1;
	reg [DATAWITH - 1 : 0] led = 1'b1 << DATAWITH - 1;	
	
	reg tempXor = 1'b0;
	reg load_prev = 1'b0;
	reg [DATAWITH - 1 : 0] poly;		
	reg [15:0] i = 16'b0;
	//reg [31:0] counter = 32'd0;

	always@ (posedge clk) begin

		load_prev <= load;
		
		if (load == 1'b1 && load_prev == 1'b0)
			poly <= polynomial;
 		
		if (en) begin
			//if (counter == 32'd1000000) begin
				//counter <= 32'b0;
				led[DATAWITH - 1 : 1] <= led[DATAWITH - 2 : 0];
				
				for (i = 0; i <= DATAWITH-1; i = i + 1) 
				begin: Loadpolynomial
					tempXor = (poly[i] & led[i]) ^ tempXor;
				end
				
				led[0] <= tempXor;
			//end
			//else begin
				//counter <= counter + 1;
			//end
		end	
		
	end
	
    
endmodule
