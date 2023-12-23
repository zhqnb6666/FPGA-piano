module auto_part_1(
    input clk,
    input rst,
    input [3:0] note_value,
    input [25:0] duration_value,
    input comfirm_button,

    output reg key_on,// is buzzer work
    output reg [3:0] key,// note value
    output reg [4:0] nxt_auto_memory_location
);
reg [27:0] counter;

always@(posedge comfirm_button,posedge clk)
begin
    if(rst||comfirm_button) begin
        key_on<=0;
        key<=0;
        nxt_auto_memory_location<=0;
        counter<=0;
    end else if(counter<=duration_value) begin counter<=counter+1; key_on<=1; key<=note_value;nxt_auto_memory_location<=nxt_auto_memory_location;
    end else if(counter<=(duration_value+26'd50000000)) begin counter<=counter+1; key_on<=0; key<=note_value;nxt_auto_memory_location<=nxt_auto_memory_location;
    end else begin counter<=0; key_on<=0; key<=0;nxt_auto_memory_location<=((nxt_auto_memory_location+1)%26);
    end     
end

endmodule