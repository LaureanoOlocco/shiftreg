module tb_shiftreg_count;

    // Parameters
    parameter NB_LEDS    = 4 ;
    parameter NB_SW      = 3 ;
    parameter NB_COUNTER = 8 ;
    
    // Signals for shiftreg module
    reg                    clock  ;
    reg                    i_reset;
    wire [NB_LEDS-1:0]     o_led  ;

    // Signals for count module
    reg  [NB_SW-1:0]       i_sw   ;
    wire                   o_valid;
    
    // Instantiate shiftreg module
    shiftreg #(.NB_LEDS(NB_LEDS)) uut_shiftreg (
        .o_led  (o_led  ),
        .i_valid(o_valid),
        .i_reset(i_reset),
        .clock  (clock  )
    );

    // Instantiate count module
    count #(.NB_SW(NB_SW), .NB_COUNTER(NB_COUNTER)) uut_count (
        .o_valid(o_valid),
        .i_sw   (i_sw   ),
        .i_reset(i_reset),
        .clock  (clock  )
    );
    
    // Clock generation (50 MHz)
    always begin
        #10 clock = ~clock; // Generates a clock period of 20 time units
    end
    
    // Test procedure
    initial begin
        // Initialize signals
        clock   = 0     ;
        i_reset = 1     ;
        i_sw    = 3'b000;
        
        // Apply reset to both modules
        #10 i_reset = 0;
        
        // Test count module with different switches
        #10 i_sw = 3'b001;  // Select R1

        // Apply reset
        #10 i_reset = 1;
        #10 i_reset = 0;

        // End simulation
        #100 $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0d | o_led=%b | o_valid=%b | i_sw=%b", 
                 $time, o_led, o_valid, i_sw);
    end

endmodule
