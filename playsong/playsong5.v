module PlaySong_3(
    input clk,
    input rst,
    output reg key_on,
    output reg [3:0] key
);

reg [3:0] song[0:23]; 
reg [25:0] durations[0:23]; 
integer i = 0; 
reg [25:0] counter = 0; 

initial begin
    // "Ode to Joy" melody with varied durations
    song[0] = 5'd2;  durations[0] = 50000000;  // E
    song[1] = 5'd2;  durations[1] = 50000000;  // E
    song[2] = 5'd3;  durations[2] = 50000000;  // F
    song[3] = 5'd4;  durations[3] = 50000000;  // G
    song[4] = 5'd4;  durations[4] = 50000000;  // G
    song[5] = 5'd3;  durations[5] = 50000000;  // F
    song[6] = 5'd2;  durations[6] = 50000000;  // E
    song[7] = 5'd1;  durations[7] = 50000000;  // D
    song[8] = 5'd0;  durations[8] = 50000000;  // C
    song[9] = 5'd0;  durations[9] = 50000000;  // C
    song[10] = 5'd1; durations[10] = 50000000; // D
    song[11] = 5'd2; durations[11] = 50000000; // E
    song[12] = 5'd2; durations[12] = 75000000; // E (longer duration)
    song[13] = 5'd1; durations[13] = 50000000; // D
    song[14] = 5'd1; durations[14] = 50000000; // D
    song[15] = 5'd2; durations[15] = 50000000; // E
    song[16] = 5'd4; durations[16] = 50000000; // G
    song[17] = 5'd3; durations[17] = 50000000; // F
    song[18] = 5'd2; durations[18] = 50000000; // E
    song[19] = 5'd1; durations[19] = 50000000; // D
    song[20] = 5'd0; durations[20] = 50000000; // C
    song[21] = 5'd0; durations[21] = 50000000; // C
    song[22] = 5'd1; durations[22] = 50000000; // D
    song[23] = 5'd2; durations[23] = 50000000; // E
    song[24] = 5'd1; durations[24] = 75000000; // D (longer duration)
    song[25] = 5'd0; durations[25] = 75000000; // C (longer duration)
    // Continue with the rest of the song or repeat the above
end





always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
    end else if(counter == durations[i]/2) begin
        key_on <= 0; 
        counter <= counter + 1;
    end else if (counter >= durations[i]) begin
        counter <= 0;
        i <= (i + 1) % 24; 
    end else begin
        counter <= counter + 1;
        if (counter == 1) begin
            key <= song[i];
            key_on <= 1; 
        end
    end
end

endmodule
