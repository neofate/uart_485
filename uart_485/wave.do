onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk
add wave -noupdate /tb/baud_clk
add wave -noupdate /tb/rst
add wave -noupdate /tb/up_rx
add wave -noupdate /tb/tx_data
add wave -noupdate -expand /tb/down_rx
add wave -noupdate /tb/uart_test/up_rx
add wave -noupdate /tb/uart_test/up_tx
add wave -noupdate /tb/uart_test/up_en
add wave -noupdate -expand /tb/uart_test/down_tx
add wave -noupdate /tb/uart_test/down_rx
add wave -noupdate -expand /tb/uart_test/down_en
add wave -noupdate /tb/uart_test/led
add wave -noupdate /tb/uart_test/clk25
add wave -noupdate /tb/uart_test/reset_n
add wave -noupdate /tb/uart_test/up_valid
add wave -noupdate /tb/uart_test/rxbuf
add wave -noupdate /tb/uart_test/rxfall
add wave -noupdate /tb/uart_test/up_end
add wave -noupdate -radix unsigned /tb/uart_test/up_wait_t
add wave -noupdate /tb/uart_test/band_clk
add wave -noupdate -expand /tb/uart_test/txbuf
add wave -noupdate -expand /tb/uart_test/txfall
add wave -noupdate -radix binary {/tb/uart_test/down_reg[0]}
add wave -noupdate /tb/uart_test/end_vliad
add wave -noupdate /tb/uart_test/down_start
add wave -noupdate /tb/uart_test/up_sta
add wave -noupdate /tb/uart_test/i
add wave -noupdate /tb/uart_test/j
add wave -noupdate /tb/uart_test/sta
add wave -noupdate /tb/uart_test/i
add wave -noupdate /tb/uart_test/j
add wave -noupdate /tb/uart_test/sta
add wave -noupdate /tb/uart_test/i
add wave -noupdate /tb/uart_test/j
add wave -noupdate /tb/uart_test/up_i
add wave -noupdate /tb/uart_test/up_j
add wave -noupdate /tb/uart_test/down_end
add wave -noupdate /tb/uart_test/up_tx_r
add wave -noupdate /tb/uart_test/band_clk
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate /tb/uart_test/txfall
add wave -noupdate -childformat {{{/tb/uart_test/down_reg[0]} -radix hexadecimal}} -expand -subitemconfig {{/tb/uart_test/down_reg[0]} {-height 15 -radix hexadecimal}} /tb/uart_test/down_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {973989140000 ps} 0} {{Cursor 2} {113813543 ps} 0}
quietly wave cursor active 2
configure wave -namecolwidth 216
configure wave -valuecolwidth 174
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {1497345165 ps} {2715394957 ps}
bookmark add wave bookmark20 {{83422738 ps} {1751877906 ps}} 7
