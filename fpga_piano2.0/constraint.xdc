# Clock signal
set_property PACKAGE_PIN P17 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

# Reset signal
set_property PACKAGE_PIN V5 [get_ports {rst}]
set_property IOSTANDARD LVCMOS33 [get_ports {rst}]

# Key input
set_property PACKAGE_PIN P5 [get_ports {key_input[0]}]
set_property PACKAGE_PIN P4 [get_ports {key_input[1]}]
set_property PACKAGE_PIN P3 [get_ports {key_input[2]}]
set_property PACKAGE_PIN P2 [get_ports {key_input[3]}]
set_property PACKAGE_PIN R2 [get_ports {key_input[4]}]
set_property PACKAGE_PIN M4 [get_ports {key_input[5]}]
set_property PACKAGE_PIN N4 [get_ports {key_input[6]}]
set_property PACKAGE_PIN R1 [get_ports {key_input[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_input[7]}]

#input continue_button,input back_button, input mode_switch_button
set_property PACKAGE_PIN V1 [get_ports {continue_button}]
set_property PACKAGE_PIN R11 [get_ports {back_button}]
set_property IOSTANDARD LVCMOS33 [get_ports {continue_button}]
set_property IOSTANDARD LVCMOS33 [get_ports {back_button}]
set_property PACKAGE_PIN U4 [get_ports {mode_switch_button}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_switch_button}]



# Higher 8 , key_on , loop
set_property PACKAGE_PIN U3 [get_ports {higher_8}]
set_property PACKAGE_PIN U2 [get_ports {key_on}]
set_property PACKAGE_PIN T5 [get_ports {loop}]
set_property IOSTANDARD LVCMOS33 [get_ports {higher_8}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_on}]
set_property IOSTANDARD LVCMOS33 [get_ports {loop}]


# LED output
set_property PACKAGE_PIN F6 [get_ports {led_output[0]}]
set_property PACKAGE_PIN G4 [get_ports {led_output[1]}]
set_property PACKAGE_PIN G3 [get_ports {led_output[2]}]
set_property PACKAGE_PIN J4 [get_ports {led_output[3]}]
set_property PACKAGE_PIN H4 [get_ports {led_output[4]}]
set_property PACKAGE_PIN J3 [get_ports {led_output[5]}]
set_property PACKAGE_PIN J2 [get_ports {led_output[6]}]
set_property PACKAGE_PIN K2 [get_ports {led_output[7]}]
set_property PACKAGE_PIN K1 [get_ports higher_8_led]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_output[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports higher_8_led]

# Buzzer output
set_property PACKAGE_PIN H17 [get_ports {buzzer_output}]
set_property IOSTANDARD LVCMOS33 [get_ports {buzzer_output}]

# Display Segment and Digit Select Output
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {segment_output[6]}]
set_property PACKAGE_PIN B4 [get_ports {segment_output[0]}]
set_property PACKAGE_PIN A4 [get_ports { segment_output[1]}]
set_property PACKAGE_PIN A3 [get_ports { segment_output[2]}]
set_property PACKAGE_PIN B1 [get_ports { segment_output[3]}]
set_property PACKAGE_PIN A1 [get_ports { segment_output[4]}]
set_property PACKAGE_PIN B3 [get_ports { segment_output[5]}] 
set_property PACKAGE_PIN B2 [get_ports { segment_output[6]}]

set_property IOSTANDARD LVCMOS33 [get_ports {digit_select_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_select_output[1]}]
set_property PACKAGE_PIN G2 [get_ports {digit_select_output[1]}]
set_property PACKAGE_PIN C2 [get_ports {digit_select_output[0]}]

# Display Segment and char Select Output
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_segment_output[0]}]
set_property PACKAGE_PIN D2 [get_ports {chars_segment_output[6]}]
set_property PACKAGE_PIN E2 [get_ports {chars_segment_output[5]}]
set_property PACKAGE_PIN F3 [get_ports {chars_segment_output[4]}]
set_property PACKAGE_PIN F4 [get_ports {chars_segment_output[3]}]
set_property PACKAGE_PIN D3 [get_ports {chars_segment_output[2]}]
set_property PACKAGE_PIN E3 [get_ports {chars_segment_output[1]}]
set_property PACKAGE_PIN D4 [get_ports {chars_segment_output[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {chars_select_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_select_output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_select_output[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {chars_select_output[3]}]
set_property PACKAGE_PIN G6 [get_ports {chars_select_output[0]}]
set_property PACKAGE_PIN E1 [get_ports {chars_select_output[1]}]
set_property PACKAGE_PIN F1 [get_ports {chars_select_output[2]}]
set_property PACKAGE_PIN G1 [get_ports {chars_select_output[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {note_change_switch}]
set_property PACKAGE_PIN T3 [get_ports {note_change_switch}]

