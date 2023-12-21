module PlaySongController(
    input clk,
    input rst,
    input [4:0] num,
    output reg key_on,
    output reg [3:0] key,
    output [6:0] duration
);

reg [25:0] counter = 0;
integer i = 0;

// "Twinkle, Twinkle, Little Star" notes (simplified)  num=17
parameter song1={
    4'd0,4'd0, 4'd4, 4'd4, 4'd5, 4'd5, 4'd4, 4'd3,
    4'd3, 4'd2, 4'd2, 4'd1, 4'd1, 4'd0, 4'd4, 4'd4,
    4'd3, 4'd3, 4'd2, 4'd2, 4'd1, 4'd1, 4'd0, 4'd0
};
parameter song1len = 96;


parameter durations1 = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000
};
parameter durations1len = 192;

// "Mary Had a Little Lamb" with varied durations num=18
parameter song2 = {
    4'd2, 4'd1, 4'd0, 4'd1, 4'd2, 4'd2, 4'd2, 4'd1,
    4'd1, 4'd1, 4'd2, 4'd4, 4'd2, 4'd1, 4'd1, 4'd1,
    4'd2, 4'd2, 4'd2, 4'd1, 4'd2, 4'd1, 4'd0
};
parameter song2len = 92;

parameter durations2 = {
    25000000, 75000000, 25000000, 25000000, 25000000, 25000000, 75000000, 25000000,
    25000000, 75000000, 25000000, 75000000, 25000000, 25000000, 75000000, 25000000,
    25000000, 25000000, 25000000, 75000000, 25000000, 25000000, 75000000
};
parameter durations2len = 184;

// "Happy Birthday" melody num=19
parameter song3 = {
    4'd0, 4'd0, 4'd2, 4'd0, 4'd5, 4'd4,
    4'd0, 4'd0, 4'd2, 4'd0, 4'd7, 4'd5,
    4'd0, 4'd0, 4'd14, 4'd10, 4'd5, 4'd4,
    4'd7, 4'd9, 4'd10, 4'd5, 4'd7, 4'd4
};
parameter song3len = 96;

parameter durations3 = {
    50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 100000000
};

parameter durations3len = 192;

// "Jingle Bells" chorus with varied durations num=20
parameter song4 = {
    4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd2, 4'd7, 4'd0, 4'd4,
    4'd9, 4'd9, 4'd9, 4'd9, 4'd9, 4'd7, 4'd7, 4'd7, 4'd7, 4'd7, 4'd4, 4'd4, 4'd4, 4'd2
};
parameter song4len = 92;

parameter durations4 = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    100000000, 50000000, 100000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    100000000
};
parameter durations4len = 200;

// "Ode to Joy" melody with varied durations num=21
parameter song5  = {
    4'd2, 4'd2, 4'd3, 4'd4, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0, 4'd0,
    4'd1, 4'd2, 4'd2, 4'd1, 4'd1, 4'd2, 4'd4, 4'd3, 4'd2, 4'd1,
    4'd0, 4'd0, 4'd1, 4'd2, 4'd1, 4'd0
};
parameter song5len = 104;

parameter durations5 = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 75000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    75000000, 75000000
};

parameter durations5len = 208;

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

always @(posedge clk or posedge rst) begin
   

    if (rst||!isvalid) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
        last_num<=0;
    end else if(!isSamesong)
    begin
        i<=0;
        counter<=0;
        key_on<=0;
    end else if(counter == durations[durationlen-i*8-:8]/2) begin
        key_on <= 0; 
        counter <= counter + 1;
    end else if (counter >= durations[durationlen-i*8-:8]) begin
        counter <= 0;
        i <= (i + 1) % 24; 
    end else begin
        counter <= counter + 1;
        if (counter == 1) begin
            key <= current_song[songlen-i*4-:4];
            key_on <= 1; 
        end
    end
end
endmodule
