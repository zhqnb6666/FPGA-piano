module PlaySong_2(
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
    // "Mary Had a Little Lamb" with varied durations
    song[0] = 5'd2;  durations[0] = 25000000;  // E, short
    song[1] = 5'd1;  durations[1] = 75000000;  // D, long
    song[2] = 5'd0;  durations[2] = 25000000;  // C, short
    song[3] = 5'd1;  durations[3] = 25000000;  // D, short
    song[4] = 5'd2;  durations[4] = 25000000;  // E, short
    song[5] = 5'd2;  durations[5] = 25000000;  // E, short
    song[6] = 5'd2;  durations[6] = 75000000;  // E, long
    song[7] = 5'd1;  durations[7] = 25000000;  // D, short
    song[8] = 5'd1;  durations[8] = 25000000;  // D, short
    song[9] = 5'd1;  durations[9] = 75000000;  // D, long
    song[10] = 5'd2; durations[10] = 25000000; // G, short
    song[11] = 5'd4; durations[11] = 75000000; // G, long
    song[12] = 5'd2; durations[12] = 25000000; // E, short
    song[13] = 5'd1; durations[13] = 75000000; // D, long
    song[14] = 5'd0; durations[14] = 25000000; // C, short
    song[15] = 5'd1; durations[15] = 25000000; // D, short
    song[16] = 5'd2; durations[16] = 25000000; // E, short
    song[17] = 5'd2; durations[17] = 25000000; // E, short
    song[18] = 5'd2; durations[18] = 75000000; // E, long
    song[19] = 5'd1; durations[19] = 25000000; // D, short
    song[20] = 5'd2; durations[20] = 25000000; // E, short
    song[21] = 5'd1; durations[21] = 75000000; // D, long
    song[22] = 5'd0; durations[22] = 25000000; // C, short
end



always @(posedge clk or posedge rst) begin
    if (rst) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
    end else if (counter >= durations[i]) begin
        key_on <= 0; 
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
