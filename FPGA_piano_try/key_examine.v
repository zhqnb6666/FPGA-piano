module key_examine(
    input clk,
    input rst,
    input [3:0] key_in,       // Input key from the user
    input [3:0] correct_key,  // Correct key that should be pressed
    output reg correct_key_press // Output signal indicating correct key press
);

reg [27:0] counter; 
localparam WAIT_TIME = 28'd10_000_000; 

always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset the output signal and counter
        correct_key_press <= 0;
        counter <= 0;
    end else if (key_in == correct_key) begin
        // Start counting when the correct key is pressed
        if (counter < WAIT_TIME) begin
            counter <= counter + 1;
        end else begin
            // Set the signal after 0.1 seconds of correct key press
            correct_key_press <= 1;
        end
    end else begin
        // Reset the signal and counter if the key is not correct
        correct_key_press <= 0;
        counter <= 0;
    end
end

endmodule
