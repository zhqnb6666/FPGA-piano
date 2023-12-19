module PlaySong(
    input clk,
    input rst,
    input correct_key_press, // Input signal for correct key press
    output reg key_on,
    output reg [3:0] key
);

reg [3:0] song[0:23];
reg [26:0] durations[0:23];
integer i = 0;
reg [27:0] counter = 0;
reg waiting_for_key_press = 1; // Flag to indicate waiting for the correct key press

initial begin
    // "Twinkle, Twinkle, Little Star" notes (simplified)
    // Each pair of notes is the same, representing one syllable
    song[0] = 5'd0;  // C
    song[1] = 5'd0;  // C
    song[2] = 5'd4;  // G
    song[3] = 5'd4;  // G
    song[4] = 5'd5;  // A
    song[5] = 5'd5;  // A
    song[6] = 5'd4;  // G
    song[7] = 5'd3;  // F
    song[8] = 5'd3;  // F
    song[9] = 5'd2;  // E
    song[10] = 5'd2; // E
    song[11] = 5'd1; // D
    song[12] = 5'd1; // D
    song[13] = 5'd0; // C
    song[14] = 5'd4; // G
    song[15] = 5'd4; // G
    song[16] = 5'd3; // F
    song[17] = 5'd3; // F
    song[18] = 5'd2; // E
    song[19] = 5'd2; // E
    song[20] = 5'd1; // D
    song[21] = 5'd1; // D
    song[22] = 5'd0; // C
    song[23] = 5'd0; // C
end

integer j;
initial begin
    // Fill the durations array with 10000000
    for (j = 0; j < 24; j = j + 1) begin
        durations[j] = 100000000;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
        waiting_for_key_press <= 1;
    end
    else if (waiting_for_key_press && correct_key_press) begin
        // Move to next note when correct key is pressed
        waiting_for_key_press <= 0;
    end
    else if (counter >= durations[i]+50000000 ) begin
        key_on <= 0;
        counter <= 0;
        key <= song[(i + 1) % 24];
        i <= (i + 1) % 24;
        waiting_for_key_press <= 1; // Wait for correct key press
    end
    else if (!waiting_for_key_press) begin
        counter <= counter + 1;
        if (counter == 50000000) begin
            key_on <= 1;
        end 
    end
    else begin
        // Do nothing
    end
end

endmodule
