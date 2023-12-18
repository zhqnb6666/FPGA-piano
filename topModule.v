module TopModule(
    input clk,  // Main clock
    input rst,  // Reset signal
    input [7:0] key_input,    // Key input for key.v
    input higher_8,           // Higher 8 bits of key_input
    input key_on,             // Key on signal from keyControl.v
    // Other global inputs like switches, buttons, etc.
    output [7:0] led_output,  // LED output from led.v
    output buzzer_output,     // Buzzer output from buzzer.v
    output [6:0] segment_output, // Segment output for display
    output [2:0] digit_select_output // Digit select output for display
);

// Inter-module signals
// wire [3:0] current_track;
wire [3:0] key_out;
wire key_out_on;
wire [6:0] counter_value;
assign counter_value = key_out;



// Instantiate keyControl module
keyControl keyControlModule(
    .clk(clk),
    .rst(rst),
    .key_on(key_on),
    .key(key_input),
    .higher_8(higher_8),
    .key_out(key_out),
    .key_out_on(key_out_on)
);

// Instantiate led module
ledControl ledModule(
    .clk(clk),
    .rst(rst),
    .current_track(key_out), // Connected from keyControlModule
    .playing(key_on),
    .led_output(led_output)
);

// Instantiate buzzer module
buzzer buzzerModule(
    .clk(clk),
    .rst(rst),
    .key_on(key_out_on), // Connected from keyControlModule
    .key(key_out),       // Connected from keyControlModule
    .buzzer(buzzer_output)
);

// Instantiate DisplayCounter module
DisplayCounter displayCounterModule(
    .clk(clk),
    .rst(rst),
    .counter_value(counter_value),
    .seg(segment_output),
    .digit_select(digit_select_output)
);


endmodule
