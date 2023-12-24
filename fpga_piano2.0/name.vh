`ifndef NAME_VH
`define NAME_VH

reg [1:0] current_state, next_state;
wire [6:0] seg_temp;
wire [3:0]char_digit_temp;
// Debounced mode switch
wire mode_switch;
  /*cb*/
wire [7:0] new_key_input;
reg [2:0] note_memory [0:7];
reg [2:0] note_change_time; 
reg [7:0] last_key_input;
reg [7:0] flag;



`endif