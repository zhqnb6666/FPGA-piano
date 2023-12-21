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


# Higher 8 and key_on
set_property PACKAGE_PIN U3 [get_ports {higher_8}]
set_property PACKAGE_PIN U2 [get_ports {key_on}]
set_property IOSTANDARD LVCMOS33 [get_ports {higher_8}]
set_property IOSTANDARD LVCMOS33 [get_ports {key_on}]

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

#mode input switch and output led
set_property IOSTANDARD LVCMOS33 [get_ports {mode_input[0]}] #parameter FREE_MODE = 3'b001; 
set_property IOSTANDARD LVCMOS33 [get_ports {mode_input[1]}] #parameter AUTO_PLAY_MODE = 3'b010;  
set_property IOSTANDARD LVCMOS33 [get_ports {mode_input[2]}] #parameter LEARNING_MODE =3'b100; 
set_property IOSTANDARD LVCMOS33 [get_ports {mode_led_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_led_output[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {mode_led_output[2]}]
set_property PACKAGE_PIN T5 [get_ports { mode_input[0]}]
set_property PACKAGE_PIN T3 [get_ports { mode_input[1]}]
set_property PACKAGE_PIN R3 [get_ports { mode_input[2]}]
set_property PACKAGE_PIN K3 [get_ports { mode_led_output[0]}]
set_property PACKAGE_PIN M1 [get_ports { mode_led_output[1]}]
set_property PACKAGE_PIN L1 [get_ports { mode_led_output[2]}] 

set_property IOSTANDARD LVCMOS33 [get_ports {song_select_switch}]  
set_property PACKAGE_PIN V4 [get_ports {song_select_switch}]


set_property IOSTANDARD LVCMOS33 [get_ports {digit_select_output[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {digit_select_output[1]}]
set_property PACKAGE_PIN G2 [get_ports {digit_select_output[1]}]
set_property PACKAGE_PIN C2 [get_ports {digit_select_output[0]}]
