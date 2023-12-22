module fsm(
input clk, rst, [2:0] x_in,//x_in 001 010 100 refer to parameter  
output reg [2:0]state, reg [2:0] mode_led_1_2_3 
);
parameter FREE_MODE = 3'b001; 
parameter AUTO_PLAY_MODE = 3'b010; 
parameter LEARNING_MODE = 3'b100;
parameter WRONG_STATE =3'b000; 

always@(posedge clk,posedge rst)
begin
    if(x_in==FREE_MODE||x_in==AUTO_PLAY_MODE||x_in==LEARNING_MODE)
        begin
        state<=x_in; mode_led_1_2_3<=x_in;
        end
    else
        begin
        state<=WRONG_STATE;
        mode_led_1_2_3<=WRONG_STATE;
    end 
end
endmodule
