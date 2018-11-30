# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35ticpg236-1L

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.cache/wt} [current_project]
set_property parent.project_path {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.xpr} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property ip_output_repo {c:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.cache/ip} [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/A.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/AVG_Control.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/BCD_to_Binary.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Binary_to_BCD.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Binary_to_BCD_dig.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Diagonal2.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Diagonal4.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/E.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Game_Control.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Growing_Rectangle.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/L.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Menu_Control.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Num1.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/P.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/PRNG_Delay.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/PWM_DAC.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.srcs/sources_1/imports/Aaron Modules/Player1_Display.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Player_Display.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.srcs/sources_1/new/Player_Display_Winner.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/R.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Rectangle.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Sound_Control.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.srcs/sources_1/new/Time_Display_VGA.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/Y.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/clock_divider.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/VGA Default/clock_divider_VGA.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/digit_multiplexor.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/display_top_level.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/VGA Default/downcounter.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/main_logic.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/mode_multiplexor.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/seven_segment_decoder.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.srcs/sources_1/new/seven_segment_decoder_VGA.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/seven_segment_digit_selector.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/VGA Default/sync_signal_generator.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.srcs/sources_1/imports/VGA Default/up_down_counter.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/upcounter.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/Aaron Modules/vga_module.vhd}
  {C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.sim/desnew/Game_Top_Level.vhd}
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc {{C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/VGA Default/Basys3_VGA_reference.xdc}}
set_property used_in_implementation false [get_files {{C:/Users/Taha Hamdy/Desktop/Aux Work/Bluetooth/VGA_Reaction_Game-Lab_5/VGA_Reaction_Game-Lab_5/Lab_5.ip_user_files/VGA Default/Basys3_VGA_reference.xdc}}]

set_param ips.enableIPCacheLiteLoad 0
close [open __synthesis_is_running__ w]

synth_design -top Game_Top_Level -part xc7a35ticpg236-1L


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef Game_Top_Level.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file Game_Top_Level_utilization_synth.rpt -pb Game_Top_Level_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]