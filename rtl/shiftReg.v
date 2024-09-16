module shiftreg
    #(
        parameter NB_LEDS = 4
    )
    (
        output [NB_LEDS - 1 : 0] o_led  ,
        input                    i_valid,
        input                    i_reset,
        input                    clock
    );

    // Vars
    reg [NB_LEDS - 1 : 0] shiftRegister;


    always @(posedge clock) begin
        if(i_reset) begin
            shiftRegister <= {{NB_LEDS-1{1'b0}}, 1'b1}; // Corrected line with semicolon
        end
        else if (i_valid) begin
            // Option 1
            // shiftRegister[1] <= shiftRegister[0];
            // shiftRegister[2] <= shiftRegister[1];
            // shiftRegister[3] <= shiftRegister[2];
            // shiftRegister[0] <= shiftRegister[3];

            // Option 2           
           shiftRegister <= {shiftRegister[NB_LEDS-2:0], shiftRegister[NB_LEDS-1]};

        end

        else begin
            shiftRegister <= shiftRegister;
        end
    end

    assign o_led = shiftRegister;
    
endmodule