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
parameter [3:0] song1[0:23] = {
    4'd0, 4'd0, 4'd4, 4'd4, 4'd5, 4'd5, 4'd4, 4'd3,
    4'd3, 4'd2, 4'd2, 4'd1, 4'd1, 4'd0, 4'd4, 4'd4,
    4'd3, 4'd3, 4'd2, 4'd2, 4'd1, 4'd1, 4'd0, 4'd0
};

parameter [25:0] durations1[0:23] = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000
};

// "Mary Had a Little Lamb" with varied durations num=18
parameter [3:0] song2[0:22] = {
    4'd2, 4'd1, 4'd0, 4'd1, 4'd2, 4'd2, 4'd2, 4'd1,
    4'd1, 4'd1, 4'd2, 4'd4, 4'd2, 4'd1, 4'd1, 4'd1,
    4'd2, 4'd2, 4'd2, 4'd1, 4'd2, 4'd1, 4'd0
};

parameter [25:0] durations2[0:22] = {
    25000000, 75000000, 25000000, 25000000, 25000000, 25000000, 75000000, 25000000,
    25000000, 75000000, 25000000, 75000000, 25000000, 25000000, 75000000, 25000000,
    25000000, 25000000, 25000000, 75000000, 25000000, 25000000, 75000000
};

// "Happy Birthday" melody num=19
parameter [3:0] song3[0:23] = {
    4'd0, 4'd0, 4'd2, 4'd0, 4'd5, 4'd4,
    4'd0, 4'd0, 4'd2, 4'd0, 4'd7, 4'd5,
    4'd0, 4'd0, 4'd14, 4'd10, 4'd5, 4'd4, 4'd7,
    4'd9, 4'd10, 4'd5, 4'd7, 4'd4
};

parameter [25:0] durations3[0:23] = {
    50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 100000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 100000000
};

// "Jingle Bells" chorus with varied durations num=20
parameter [3:0] song4[0:25] = {
    4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd4, 4'd2, 4'd7, 4'd0, 4'd4,
    4'd9, 4'd9, 4'd9, 4'd9, 4'd9, 4'd7, 4'd7, 4'd7, 4'd7, 4'd7, 4'd4, 4'd4, 4'd4, 4'd2
};

parameter [25:0] durations4[0:25] = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    100000000, 50000000, 100000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    100000000
};

// "Ode to Joy" melody with varied durations num=21
parameter [3:0] song5[0:25] = {
    4'd2, 4'd2, 4'd3, 4'd4, 4'd4, 4'd3, 4'd2, 4'd1, 4'd0, 4'd0,
    4'd1, 4'd2, 4'd2, 4'd1, 4'd1, 4'd2, 4'd4, 4'd3, 4'd2, 4'd1,
    4'd0, 4'd0, 4'd1, 4'd2, 4'd1, 4'd0
};

parameter [25:0] durations5[0:25] = {
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 75000000, 50000000, 50000000, 50000000,
    50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000, 50000000,
    75000000, 75000000
};


// Initialize the current song and duration

reg[4:0] last_num = 0;//上一首歌的索引
reg isSamesong = 0;
reg isvalid

always @(posedge clk or posedge rst) begin
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
        isvalid<=1;
    end else if (num == 18) begin
        current_song <= song2;
        durations <= durations2;
        isvalid<=1;
    end else if (num == 19) begin
        current_song <= song3;
        durations <= durations3;
        isvalid<=1;
    end else if (num == 20) begin
        current_song <= song4;
        durations <= durations4;
        isvalid<=1;
    end else if (num == 21) begin
        current_song <= song5;
        durations <= durations5;
        isvalid<=1;
    end else begin
        isvalid<=0;
    end

    if (rst||!isvalid) begin
        i <= 0;
        counter <= 0;
        key_on <= 0;
        last_num<=0;
    end 
    else if(!isSamesong)
    begin
        i<=0;
        counter<=0;
        key_on<=0;
    end
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
endmodule

