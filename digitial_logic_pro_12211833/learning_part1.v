module learning_part_1(
    input clk,
    input rst,
    input [3:0] note_value,
    input [25:0] duration_value,
    input [3:0] user_input,// 4 bits for note value(0 to 15) [3:0]
    input comfirm_button,
    input isvalid,

    output reg [4:0] score,
    output reg key_on,// is buzzer work
    output reg [3:0] key,// note value
    output reg [4:0] nxt_learning_memory_location
);
reg [27:0] counter;


always@(posedge clk)
begin
    if(rst||comfirm_button) begin
        score<=0;
        key_on<=0;
        key<=0;
        nxt_learning_memory_location<=0;
        counter<=1;
    end else if(~isvalid) begin  counter<=counter; key<=0;key_on<=0;nxt_learning_memory_location<=0;
    end else if(counter>0) begin
            if(counter<=duration_value) begin counter<=counter+1; key_on<=1; key<=note_value;nxt_learning_memory_location<=nxt_learning_memory_location; end
            else if(counter<=(duration_value+26'd50000000)) begin counter<=counter+1; key_on<=0; key<=note_value;nxt_learning_memory_location<=nxt_learning_memory_location; end
            else begin counter<=0; key_on<=0; key<=0;nxt_learning_memory_location<=((nxt_learning_memory_location+1)%26); end 
    end else if(user_input==note_value) begin counter<=counter+1; key_on<=1; key<=note_value;nxt_learning_memory_location<=nxt_learning_memory_location; end
    else begin counter<=counter; key_on<=0; key<=note_value;nxt_learning_memory_location<=nxt_learning_memory_location; end       
end

endmodule