`timescale 1ns / 1ps

module keyControl_tb;

// Inputs
reg clk;
reg rst;
reg key_on;
reg [7:0] key;
reg higher_8;

// Outputs
wire [3:0] key_out;
wire key_out_on;

// Instantiate the Unit Under Test (UUT)
keyControl uut (
    .clk(clk), 
    .rst(rst), 
    .key_on(key_on), 
    .key(key), 
    .higher_8(higher_8), 
    .key_out(key_out), 
    .key_out_on(key_out_on)
);

initial begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    key_on = 0;
    key = 0;
    higher_8 = 0;

    // Wait for global reset to finish
    #100;
    rst = 0;

    // Test Case 1: Press key 1
    key_on = 1;
    key = 8'h01; // Pressing key 1
    #20;
    key_on = 0;
    #100;

    // Test Case 2: Press key 2 with higher octave
    higher_8 = 1;
    key_on = 1;
    key = 8'h02; // Pressing key 2
    #20;
    key_on = 0;
    #100;
    higher_8 = 0;

    // Test Case 3: Reset while key is pressed
    key_on = 1;
    key = 8'h04; // Pressing key 3
    #20;
    rst = 1;
    #20;
    rst = 0;
    key_on = 0;
    #100;

    // Add more test cases as necessary

end

always #10 clk = ~clk; // Clock generation with 20ns period

endmodule
