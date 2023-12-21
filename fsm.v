module fsm(
input clk, rst, [2:0] x_in,//x_in 001 010 100 refer to parameter  
output reg [1:0]state, reg [1:0] next_state, reg [2:0] mode_led_1_2_3 
);
parameter FREE_MODE = 3'b001; 
parameter AUTO_PLAY_MODE = 3'b010; 
parameter LEARNING_MODE = 3'b100;
parameter WRONG_STATE =3'b000; 

always@(posedge clk,posedge rst)
begin
    if(rst)
    state<=WRONG_STATE;
    else
    state<=next_state;
end

always@(state,x_in)
begin
    case (state)
        FREE_MODE,AUTO_PLAY_MODE,LEARNING_MODE: if(x_in==FREE_MODE||x_in==AUTO_PLAY_MODE||x_in==LEARNING_MODE) begin next_state<=x_in; mode_led_1_2_3<=x_in; end 
        else  begin next_state<=WRONG_STATE; mode_led_1_2_3<=WRONG_STATE; end
        default: 
        begin
        next_state<=WRONG_STATE;
        mode_led_1_2_3<=WRONG_STATE;
        end
    endcase
end

always@(state,x_in)
begin
    case (state)
        FREE_MODE,AUTO_PLAY_MODE,LEARNING_MODE: if(x_in==FREE_MODE||x_in==AUTO_PLAY_MODE||x_in==LEARNING_MODE) next_state<=x_in; else next_state<=WRONG_STATE;
        default: 
        next_state<=WRONG_STATE;
    endcase
end

endmodule
