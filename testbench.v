`timescale 1ns / 1ps

module TopModule_tb;

// Inputs
reg clk;
reg rst;
reg [7:0] key_input;
reg higher_8;
reg key_on;

// Outputs
wire [7:0] led_output;
wire buzzer_output;
wire [6:0] segment_output;
wire [2:0] digit_select_output;

// Instantiate the Unit Under Test (UUT)
TopModule uut (
    .clk(clk), 
    .rst(rst), 
    .key_input(key_input), 
    .higher_8(higher_8), 
    .key_on(key_on), 
    .led_output(led_output), 
    .buzzer_output(buzzer_output),
    .segment_output(segment_output),
    .digit_select_output(digit_select_output)
);

initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    key_input = 0;
    higher_8 = 0;
    key_on = 1;

    // Wait 100 ns for global reset to finish
    #100;
    rst = 0;

    // Test Case 1: Press a key
    key_input = 8'b00000001; // Simulate pressing the first key
    key_on = 1;
    #20;
    key_on = 1;
    #100;

    // Test Case 2: Press a different key
    key_input = 8'b00000010; // Simulate pressing the second key
    key_on = 1;
    #20;
    key_on = 1;
    #100;

    // Test Case 3: Simulate higher octave
    higher_8 = 1; // Activate higher octave
    key_input = 8'b00000100; // Simulate pressing the third key
    key_on = 1;
    #20;
    key_on = 1;
    higher_8 = 0; // Deactivate higher octave
    #100;

    // Test Case 4: Reset the system
    rst = 1; // Activate reset
    #20;
    rst = 0; // Deactivate reset
    #100;

    // Add more test cases as needed

end

always #0.001 clk = ~clk; // Generate clock signal with period 20 ns

endmodule
