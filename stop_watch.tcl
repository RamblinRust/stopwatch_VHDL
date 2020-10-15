# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: stop_watch.tcl
# Generated on: Thu Oct 15 02:09:21 2020

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "stop_watch"]} {
		puts "Project stop_watch is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists stop_watch]} {
		project_open -revision stop_watch stop_watch
	} else {
		project_new -revision stop_watch stop_watch
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSXFC6D6F31C6
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.0
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "22:19:30  SEPTEMBER 26, 2020"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.0 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name VHDL_FILE stop_watch.vhd
	set_global_assignment -name VHDL_FILE "modCounter component/VHDL/modCounter.vhd"
	set_global_assignment -name VHDL_FILE "seven seg component/VHDL/sev_segs.vhd"
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_global_assignment -name VHDL_FILE clock_tb.vhd
	set_global_assignment -name VHDL_FILE clock_1k.vhd
	set_location_assignment PIN_AF14 -to i_50MHz
	set_location_assignment PIN_AA15 -to i_clr
	set_location_assignment PIN_AA14 -to i_st
	set_location_assignment PIN_AG16 -to o_bot0
	set_location_assignment PIN_AD17 -to o_bot1
	set_location_assignment PIN_Y17 -to o_bot2
	set_location_assignment PIN_AA20 -to o_bot3
	set_location_assignment PIN_AE23 -to o_bot4
	set_location_assignment PIN_AH17 -to o_lbot0
	set_location_assignment PIN_AE18 -to o_lbot1
	set_location_assignment PIN_Y18 -to o_lbot2
	set_location_assignment PIN_AC20 -to o_lbot3
	set_location_assignment PIN_AG23 -to o_lbot4
	set_location_assignment PIN_AG18 -to o_ltop0
	set_location_assignment PIN_AE17 -to o_ltop1
	set_location_assignment PIN_AF18 -to o_ltop2
	set_location_assignment PIN_AA19 -to o_ltop3
	set_location_assignment PIN_AF23 -to o_ltop4
	set_location_assignment PIN_AH18 -to o_mid0
	set_location_assignment PIN_V17 -to o_mid1
	set_location_assignment PIN_W16 -to o_mid2
	set_location_assignment PIN_AD20 -to o_mid3
	set_location_assignment PIN_AH22 -to o_mid4
	set_location_assignment PIN_AG17 -to o_rbot0
	set_location_assignment PIN_AE16 -to o_rbot1
	set_location_assignment PIN_AA18 -to o_rbot2
	set_location_assignment PIN_AD19 -to o_rbot3
	set_location_assignment PIN_AE22 -to o_rbot4
	set_location_assignment PIN_V18 -to o_rtop0
	set_location_assignment PIN_V16 -to o_rtop1
	set_location_assignment PIN_AB17 -to o_rtop2
	set_location_assignment PIN_W19 -to o_rtop3
	set_location_assignment PIN_AG22 -to o_rtop4
	set_location_assignment PIN_W17 -to o_top0
	set_location_assignment PIN_AF16 -to o_top1
	set_location_assignment PIN_AA21 -to o_top2
	set_location_assignment PIN_Y19 -to o_top3
	set_location_assignment PIN_AD21 -to o_top4
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
