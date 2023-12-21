`include "songpara.vh"
module PlaySong(
    input clk,
    input rst,
    input num,
    input correct_key_press, // Input signal for correct key press
    output reg key_on,
    output reg [3:0] key
    
);

/*reg [3:0] song[0:23];
reg [26:0] durations[0:23];
integer i = 0;*/


reg [27:0] counter = 0;
reg waiting_for_key_press = 1; // Flag to indicate waiting for the correct key press

reg [25:0] counter = 0;
integer i = 0;

// "Twinkle, Twinkle, Little Star" notes (simplified)  num=17


integer songlen=0;
integer durationlen=0; 

reg [99:0] current_song;
reg [299:0] durations; 

reg[4:0] last_num = 0;//上一首歌的索引
reg isSamesong = 0;
reg isvalid;



always @(*) begin
    if(num==last_num)
    begin
    isSamesong<=1;
    end
    else begin
    isSamesong<=0;
    end   
    if(!rst)
    begin
    last_num<=num;
    end      
    if (num == 17) begin
        current_song <= song1;
        durations <= durations1;
        songlen<=song1len;
        durationlen<=durations1len;
        isvalid<=1;
    end else if (num == 18) begin
        current_song <= song2;
        durations <= durations2;
        songlen<=song2len;
        durationlen<=durations2len;
        isvalid<=1;
    end else if (num == 19) begin
        current_song <= song3;
        durations <= durations3;
        songlen<=song3len;
        durationlen<=durations3len;
        isvalid<=1;
    end else if (num == 20) begin
        current_song <= song4;
        durations <= durations4;
        songlen<=song4len;
        durationlen<=durations4len;
        isvalid<=1;
    end else if (num == 21) begin
        current_song <= song5;
        durations <= durations5;
        songlen<=song5len;
        durationlen<=durations5len;
        isvalid<=1;
    end else begin
        isvalid<=0;
    end
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
    else if (counter >= durations[durationlen-i*8-:8]+50000000 ) begin
        key_on <= 0;
        counter <= 0;
        key <= current_song[songlen-i*4-:4 ];
        i <= (i + 1) % (songlen/4);
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