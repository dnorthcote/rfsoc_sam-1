
################################################################
# This is a generated script based on design: rfsoc_sam_new
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source rfsoc_sam_new_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu28dr-ffvg1517-2-e
   set_property BOARD_PART xilinx.com:zcu111:part0:1.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name rfsoc_sam_new

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:frequency_synth:1.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:usp_rf_data_converter:2.1\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:zynq_ultra_ps_e:3.3\
UoS:RFSoC:bandwidthselector:0.3.1\
xilinx.com:ip:axi_dma:7.1\
UoS:RFSoC:DataInspector:0.2.1\
xilinx.com:ip:axis_switch:1.1\
UoS:RFSoC:spectrum_fft:1.2\
UoS:RFSoC:psd:0.3.1\
xilinx.com:ip:window:1.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: SpectrumWindow
proc create_hier_cell_SpectrumWindow { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_SpectrumWindow() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_MM2S

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_im

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_re

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re


  # Create pins
  create_bd_pin -dir I -type clk AXI4_Lite_ACLK
  create_bd_pin -dir I -type rst AXI4_Lite_ARESETN
  create_bd_pin -dir O -type intr irq

  # Create instance: axi_dma_window, and set properties
  set axi_dma_window [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_window ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {128} \
   CONFIG.c_m_axis_mm2s_tdata_width {16} \
   CONFIG.c_mm2s_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_window

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]

  # Create instance: window, and set properties
  set window [ create_bd_cell -type ip -vlnv xilinx.com:ip:window:1.0 window ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_dma_window_M_AXIS_MM2S [get_bd_intf_pins axi_dma_window/M_AXIS_MM2S] [get_bd_intf_pins window/AXI4_Stream_Window_Slave]
  connect_bd_intf_net -intf_net axi_dma_window_M_AXI_MM2S [get_bd_intf_pins M_AXI_MM2S] [get_bd_intf_pins axi_dma_window/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_dma_window/S_AXI_LITE] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_M01_AXI [get_bd_intf_pins axi_interconnect/M01_AXI] [get_bd_intf_pins window/AXI4_Lite]
  connect_bd_intf_net -intf_net s_axis_im_1 [get_bd_intf_pins s_axis_im] [get_bd_intf_pins window/AXI4_Stream_Imag_Slave]
  connect_bd_intf_net -intf_net s_axis_re_1 [get_bd_intf_pins s_axis_re] [get_bd_intf_pins window/AXI4_Stream_Real_Slave]
  connect_bd_intf_net -intf_net window_0_AXI4_Stream_Imag_Master [get_bd_intf_pins m_axis_im] [get_bd_intf_pins window/AXI4_Stream_Imag_Master]
  connect_bd_intf_net -intf_net window_0_AXI4_Stream_Real_Master [get_bd_intf_pins m_axis_re] [get_bd_intf_pins window/AXI4_Stream_Real_Master]

  # Create port connections
  connect_bd_net -net axi_dma_window_mm2s_introut [get_bd_pins irq] [get_bd_pins axi_dma_window/mm2s_introut]
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins AXI4_Lite_ARESETN] [get_bd_pins axi_dma_window/axi_resetn] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins window/AXI4_Lite_ARESETN] [get_bd_pins window/IPCORE_RESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins AXI4_Lite_ACLK] [get_bd_pins axi_dma_window/m_axi_mm2s_aclk] [get_bd_pins axi_dma_window/s_axi_lite_aclk] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins window/AXI4_Lite_ACLK] [get_bd_pins window/IPCORE_CLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: SpectrumFFT
proc create_hier_cell_SpectrumFFT { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_SpectrumFFT() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re


  # Create pins
  create_bd_pin -dir I -type clk AXI4_Lite_ACLK
  create_bd_pin -dir I -type rst AXI4_Lite_ARESETN

  # Create instance: FFT, and set properties
  set FFT [ create_bd_cell -type ip -vlnv UoS:RFSoC:spectrum_fft:1.2 FFT ]

  # Create instance: PSD, and set properties
  set PSD [ create_bd_cell -type ip -vlnv UoS:RFSoC:psd:0.3.1 PSD ]

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]

  # Create interface connections
  connect_bd_intf_net -intf_net FFT_AXI4_Stream_Master [get_bd_intf_pins FFT/AXI4_Stream_Master] [get_bd_intf_pins PSD/AXI4_Stream_Slave]
  connect_bd_intf_net -intf_net PSD_AXI4_Stream_Master [get_bd_intf_pins m_axis] [get_bd_intf_pins PSD/AXI4_Stream_Master]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins PSD/AXI4_Lite] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins FFT/AXI4_Lite] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net s_axis_im_1 [get_bd_intf_pins s_axis_im] [get_bd_intf_pins FFT/AXI4_Stream_Imag_Slave]
  connect_bd_intf_net -intf_net s_axis_re_1 [get_bd_intf_pins s_axis_re] [get_bd_intf_pins FFT/AXI4_Stream_Real_Slave]

  # Create port connections
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins AXI4_Lite_ARESETN] [get_bd_pins FFT/AXI4_Lite_ARESETN] [get_bd_pins FFT/IPCORE_RESETN] [get_bd_pins PSD/AXI4_Lite_ARESETN] [get_bd_pins PSD/IPCORE_RESETN] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins AXI4_Lite_ACLK] [get_bd_pins FFT/AXI4_Lite_ACLK] [get_bd_pins FFT/IPCORE_CLK] [get_bd_pins PSD/AXI4_Lite_ACLK] [get_bd_pins PSD/IPCORE_CLK] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/S00_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: SpectrumADC
proc create_hier_cell_SpectrumADC { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_SpectrumADC() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_im

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_re

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_2


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN

  # Create instance: adc_switch_im, and set properties
  set adc_switch_im [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_switch_im ]
  set_property -dict [ list \
   CONFIG.HAS_TREADY {0} \
   CONFIG.NUM_SI {3} \
   CONFIG.ROUTING_MODE {1} \
 ] $adc_switch_im

  # Create instance: adc_switch_re, and set properties
  set adc_switch_re [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 adc_switch_re ]
  set_property -dict [ list \
   CONFIG.HAS_TREADY {0} \
   CONFIG.NUM_SI {3} \
   CONFIG.ROUTING_MODE {1} \
 ] $adc_switch_re

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net adc_switch_im_M00_AXIS [get_bd_intf_pins m_axis_im] [get_bd_intf_pins adc_switch_im/M00_AXIS]
  connect_bd_intf_net -intf_net adc_switch_re_M00_AXIS [get_bd_intf_pins m_axis_re] [get_bd_intf_pins adc_switch_re/M00_AXIS]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins adc_switch_im/S_AXI_CTRL] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins adc_switch_re/S_AXI_CTRL] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m00_axis [get_bd_intf_pins s_axis_re_0] [get_bd_intf_pins adc_switch_re/S00_AXIS]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m01_axis [get_bd_intf_pins s_axis_im_0] [get_bd_intf_pins adc_switch_im/S00_AXIS]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m02_axis [get_bd_intf_pins s_axis_re_1] [get_bd_intf_pins adc_switch_re/S01_AXIS]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m03_axis [get_bd_intf_pins s_axis_im_1] [get_bd_intf_pins adc_switch_im/S01_AXIS]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m10_axis [get_bd_intf_pins s_axis_re_2] [get_bd_intf_pins adc_switch_re/S02_AXIS]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m11_axis [get_bd_intf_pins s_axis_im_2] [get_bd_intf_pins adc_switch_im/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins ARESETN] [get_bd_pins adc_switch_im/aresetn] [get_bd_pins adc_switch_im/s_axi_ctrl_aresetn] [get_bd_pins adc_switch_re/aresetn] [get_bd_pins adc_switch_re/s_axi_ctrl_aresetn] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins ACLK] [get_bd_pins adc_switch_im/aclk] [get_bd_pins adc_switch_im/s_axi_ctrl_aclk] [get_bd_pins adc_switch_re/aclk] [get_bd_pins adc_switch_re/s_axi_ctrl_aclk] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/S00_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: DataInspector
proc create_hier_cell_DataInspector { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_DataInspector() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_S2MM

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type rst IPCORE_RESETN
  create_bd_pin -dir I -type clk m_axi_s2mm_aclk
  create_bd_pin -dir O -type intr s2mm_introut

  # Create instance: axi_dma_inspector, and set properties
  set axi_dma_inspector [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_inspector ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_s2mm_data_width {128} \
   CONFIG.c_s2mm_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_inspector

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]

  # Create instance: data_inspector, and set properties
  set data_inspector [ create_bd_cell -type ip -vlnv UoS:RFSoC:DataInspector:0.2.1 data_inspector ]

  # Create interface connections
  connect_bd_intf_net -intf_net DataInspector_m_axis [get_bd_intf_pins axi_dma_inspector/S_AXIS_S2MM] [get_bd_intf_pins data_inspector/m_axis]
  connect_bd_intf_net -intf_net axi_dma_inspector_M_AXI_S2MM [get_bd_intf_pins M_AXI_S2MM] [get_bd_intf_pins axi_dma_inspector/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_dma_inspector/S_AXI_LITE] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_1_M01_AXI [get_bd_intf_pins axi_interconnect/M01_AXI] [get_bd_intf_pins data_inspector/AXI4_Lite]
  connect_bd_intf_net -intf_net psd_m_axis [get_bd_intf_pins s_axis] [get_bd_intf_pins data_inspector/s_axis]

  # Create port connections
  connect_bd_net -net axi_dma_inspector_s2mm_introut [get_bd_pins s2mm_introut] [get_bd_pins axi_dma_inspector/s2mm_introut]
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins IPCORE_RESETN] [get_bd_pins axi_dma_inspector/axi_resetn] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins data_inspector/AXI4_Lite_ARESETN] [get_bd_pins data_inspector/IPCORE_RESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins m_axi_s2mm_aclk] [get_bd_pins axi_dma_inspector/m_axi_s2mm_aclk] [get_bd_pins axi_dma_inspector/s_axi_lite_aclk] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins data_inspector/AXI4_Lite_ACLK] [get_bd_pins data_inspector/IPCORE_CLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: BandwidthSelector
proc create_hier_cell_BandwidthSelector { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_BandwidthSelector() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_CONFIG

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_RELOAD

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_im

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_re

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir O -from 1 -to 0 irq

  # Create instance: BWSelector, and set properties
  set BWSelector [ create_bd_cell -type ip -vlnv UoS:RFSoC:bandwidthselector:0.3.1 BWSelector ]

  # Create instance: axi_dma_config, and set properties
  set axi_dma_config [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_config ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {128} \
   CONFIG.c_m_axis_mm2s_tdata_width {8} \
   CONFIG.c_mm2s_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_config

  # Create instance: axi_dma_reload, and set properties
  set axi_dma_reload [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_dma_reload ]
  set_property -dict [ list \
   CONFIG.c_addr_width {32} \
   CONFIG.c_include_mm2s {1} \
   CONFIG.c_include_s2mm {0} \
   CONFIG.c_include_sg {0} \
   CONFIG.c_m_axi_mm2s_data_width {128} \
   CONFIG.c_m_axis_mm2s_tdata_width {16} \
   CONFIG.c_mm2s_burst_size {256} \
   CONFIG.c_sg_include_stscntrl_strm {0} \
   CONFIG.c_sg_length_width {26} \
 ] $axi_dma_reload

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins M_AXI_CONFIG] [get_bd_intf_pins axi_dma_config/M_AXI_MM2S]
  connect_bd_intf_net -intf_net adc_switch_im_M00_AXIS [get_bd_intf_pins s_axis_im] [get_bd_intf_pins BWSelector/s_axis_im]
  connect_bd_intf_net -intf_net adc_switch_re_M00_AXIS [get_bd_intf_pins s_axis_re] [get_bd_intf_pins BWSelector/s_axis_re]
  connect_bd_intf_net -intf_net axi_dma_config_M_AXIS_MM2S [get_bd_intf_pins BWSelector/s_axis_config] [get_bd_intf_pins axi_dma_config/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_reload_M_AXIS_MM2S [get_bd_intf_pins BWSelector/s_axis_reload] [get_bd_intf_pins axi_dma_reload/M_AXIS_MM2S]
  connect_bd_intf_net -intf_net axi_dma_reload_M_AXI_MM2S [get_bd_intf_pins M_AXI_RELOAD] [get_bd_intf_pins axi_dma_reload/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI1 [get_bd_intf_pins axi_dma_config/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI1 [get_bd_intf_pins axi_dma_reload/S_AXI_LITE] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins BWSelector/bandwidthselector_s_axi] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net bandwidthselector_m_axis_im [get_bd_intf_pins m_axis_im] [get_bd_intf_pins BWSelector/m_axis_im]
  connect_bd_intf_net -intf_net bandwidthselector_m_axis_re [get_bd_intf_pins m_axis_re] [get_bd_intf_pins BWSelector/m_axis_re]

  # Create port connections
  connect_bd_net -net axi_dma_config_mm2s_introut [get_bd_pins axi_dma_config/mm2s_introut] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net axi_dma_reload_mm2s_introut [get_bd_pins axi_dma_reload/mm2s_introut] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins ARESETN] [get_bd_pins BWSelector/bandwidthselector_aresetn] [get_bd_pins axi_dma_config/axi_resetn] [get_bd_pins axi_dma_reload/axi_resetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins ACLK] [get_bd_pins BWSelector/clk] [get_bd_pins axi_dma_config/m_axi_mm2s_aclk] [get_bd_pins axi_dma_config/s_axi_lite_aclk] [get_bd_pins axi_dma_reload/m_axi_mm2s_aclk] [get_bd_pins axi_dma_reload/s_axi_lite_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK]
  connect_bd_net -net xlconcat_0_dout1 [get_bd_pins irq] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: SpectrumAnalyser
proc create_hier_cell_SpectrumAnalyser { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_SpectrumAnalyser() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_CONFIG

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M_AXI_SAM

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_im_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_re_2


  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir O -from 3 -to 0 irq

  # Create instance: BandwidthSelector
  create_hier_cell_BandwidthSelector $hier_obj BandwidthSelector

  # Create instance: DataInspector
  create_hier_cell_DataInspector $hier_obj DataInspector

  # Create instance: SpectrumADC
  create_hier_cell_SpectrumADC $hier_obj SpectrumADC

  # Create instance: SpectrumFFT
  create_hier_cell_SpectrumFFT $hier_obj SpectrumFFT

  # Create instance: SpectrumWindow
  create_hier_cell_SpectrumWindow $hier_obj SpectrumWindow

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {5} \
 ] $axi_interconnect

  # Create instance: axi_interconnect_hp, and set properties
  set axi_interconnect_hp [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_hp ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
   CONFIG.NUM_SI {3} \
 ] $axi_interconnect_hp

  # Create instance: xlconcat, and set properties
  set xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins BandwidthSelector/M_AXI_CONFIG] [get_bd_intf_pins axi_interconnect_hp/S00_AXI]
  connect_bd_intf_net -intf_net adc_switch_im_M00_AXIS [get_bd_intf_pins BandwidthSelector/s_axis_im] [get_bd_intf_pins SpectrumADC/m_axis_im]
  connect_bd_intf_net -intf_net adc_switch_re_M00_AXIS [get_bd_intf_pins BandwidthSelector/s_axis_re] [get_bd_intf_pins SpectrumADC/m_axis_re]
  connect_bd_intf_net -intf_net axi_dma_inspector_M_AXI_S2MM [get_bd_intf_pins M_AXI_SAM] [get_bd_intf_pins DataInspector/M_AXI_S2MM]
  connect_bd_intf_net -intf_net axi_dma_reload_M_AXI_MM2S [get_bd_intf_pins BandwidthSelector/M_AXI_RELOAD] [get_bd_intf_pins axi_interconnect_hp/S01_AXI]
  connect_bd_intf_net -intf_net axi_dma_window_M_AXI_MM2S [get_bd_intf_pins SpectrumWindow/M_AXI_MM2S] [get_bd_intf_pins axi_interconnect_hp/S02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins SpectrumADC/S_AXI] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins BandwidthSelector/S_AXI] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_pins SpectrumWindow/S_AXI] [get_bd_intf_pins axi_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M03_AXI [get_bd_intf_pins SpectrumFFT/S00_AXI] [get_bd_intf_pins axi_interconnect/M03_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M04_AXI [get_bd_intf_pins DataInspector/S00_AXI] [get_bd_intf_pins axi_interconnect/M04_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_hp_M00_AXI [get_bd_intf_pins M_AXI_CONFIG] [get_bd_intf_pins axi_interconnect_hp/M00_AXI]
  connect_bd_intf_net -intf_net bandwidthselector_m_axis_im [get_bd_intf_pins BandwidthSelector/m_axis_im] [get_bd_intf_pins SpectrumWindow/s_axis_im]
  connect_bd_intf_net -intf_net bandwidthselector_m_axis_re [get_bd_intf_pins BandwidthSelector/m_axis_re] [get_bd_intf_pins SpectrumWindow/s_axis_re]
  connect_bd_intf_net -intf_net ps8_axi_periph_M03_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net psd_m_axis [get_bd_intf_pins DataInspector/s_axis] [get_bd_intf_pins SpectrumFFT/m_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m00_axis [get_bd_intf_pins s_axis_re_0] [get_bd_intf_pins SpectrumADC/s_axis_re_0]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m01_axis [get_bd_intf_pins s_axis_im_0] [get_bd_intf_pins SpectrumADC/s_axis_im_0]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m02_axis [get_bd_intf_pins s_axis_re_1] [get_bd_intf_pins SpectrumADC/s_axis_re_1]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m03_axis [get_bd_intf_pins s_axis_im_1] [get_bd_intf_pins SpectrumADC/s_axis_im_1]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m10_axis [get_bd_intf_pins s_axis_re_2] [get_bd_intf_pins SpectrumADC/s_axis_re_2]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m11_axis [get_bd_intf_pins s_axis_im_2] [get_bd_intf_pins SpectrumADC/s_axis_im_2]
  connect_bd_intf_net -intf_net window_m_axis_im [get_bd_intf_pins SpectrumFFT/s_axis_im] [get_bd_intf_pins SpectrumWindow/m_axis_im]
  connect_bd_intf_net -intf_net window_m_axis_re [get_bd_intf_pins SpectrumFFT/s_axis_re] [get_bd_intf_pins SpectrumWindow/m_axis_re]

  # Create port connections
  connect_bd_net -net axi_dma_inspector_s2mm_introut [get_bd_pins DataInspector/s2mm_introut] [get_bd_pins xlconcat/In2]
  connect_bd_net -net axi_dma_window_mm2s_introut [get_bd_pins SpectrumWindow/irq] [get_bd_pins xlconcat/In1]
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins ARESETN] [get_bd_pins BandwidthSelector/ARESETN] [get_bd_pins DataInspector/IPCORE_RESETN] [get_bd_pins SpectrumADC/ARESETN] [get_bd_pins SpectrumFFT/AXI4_Lite_ARESETN] [get_bd_pins SpectrumWindow/AXI4_Lite_ARESETN] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins axi_interconnect/M03_ARESETN] [get_bd_pins axi_interconnect/M04_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins axi_interconnect_hp/ARESETN] [get_bd_pins axi_interconnect_hp/M00_ARESETN] [get_bd_pins axi_interconnect_hp/S00_ARESETN] [get_bd_pins axi_interconnect_hp/S01_ARESETN] [get_bd_pins axi_interconnect_hp/S02_ARESETN]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc0 [get_bd_pins ACLK] [get_bd_pins BandwidthSelector/ACLK] [get_bd_pins DataInspector/m_axi_s2mm_aclk] [get_bd_pins SpectrumADC/ACLK] [get_bd_pins SpectrumFFT/AXI4_Lite_ACLK] [get_bd_pins SpectrumWindow/AXI4_Lite_ACLK] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/M02_ACLK] [get_bd_pins axi_interconnect/M03_ACLK] [get_bd_pins axi_interconnect/M04_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins axi_interconnect_hp/ACLK] [get_bd_pins axi_interconnect_hp/M00_ACLK] [get_bd_pins axi_interconnect_hp/S00_ACLK] [get_bd_pins axi_interconnect_hp/S01_ACLK] [get_bd_pins axi_interconnect_hp/S02_ACLK]
  connect_bd_net -net xlconcat_0_dout1 [get_bd_pins BandwidthSelector/irq] [get_bd_pins xlconcat/In0]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins irq] [get_bd_pins xlconcat/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set adc0_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc0_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $adc0_clk

  set adc1_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 adc1_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $adc1_clk

  set dac1_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 dac1_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {409600000.0} \
   ] $dac1_clk

  set sysref_in [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_usp_rf_data_converter:diff_pins_rtl:1.0 sysref_in ]

  set vin0_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_01 ]

  set vin0_23 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin0_23 ]

  set vin1_01 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vin1_01 ]

  set vout10 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout10 ]

  set vout12 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:diff_analog_io_rtl:1.0 vout12 ]


  # Create ports

  # Create instance: SpectrumAnalyser
  create_hier_cell_SpectrumAnalyser [current_bd_instance .] SpectrumAnalyser

  # Create instance: axi_intc, and set properties
  set axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc ]

  # Create instance: clk_wiz_adc0, and set properties
  set clk_wiz_adc0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_adc0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {78.12} \
   CONFIG.CLKOUT1_JITTER {94.730} \
   CONFIG.CLKOUT1_PHASE_ERROR {86.249} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {256} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {9.250} \
   CONFIG.MMCM_CLKIN1_PERIOD {7.813} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {4.625} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.RESET_PORT {reset} \
   CONFIG.RESET_TYPE {ACTIVE_HIGH} \
   CONFIG.USE_RESET {false} \
 ] $clk_wiz_adc0

  # Create instance: frequency_synth, and set properties
  set frequency_synth [ create_bd_cell -type ip -vlnv xilinx.com:ip:frequency_synth:1.0 frequency_synth ]

  # Create instance: proc_sys_reset_adc0, and set properties
  set proc_sys_reset_adc0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_adc0 ]

  # Create instance: proc_sys_reset_dac1, and set properties
  set proc_sys_reset_dac1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_dac1 ]

  # Create instance: ps8_axi_periph, and set properties
  set ps8_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 ps8_axi_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
 ] $ps8_axi_periph

  # Create instance: rst_ps8_99M, and set properties
  set rst_ps8_99M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_ps8_99M ]

  # Create instance: s_axi_interconnect_hp0, and set properties
  set s_axi_interconnect_hp0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 s_axi_interconnect_hp0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $s_axi_interconnect_hp0

  # Create instance: s_axi_interconnect_hp2, and set properties
  set s_axi_interconnect_hp2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 s_axi_interconnect_hp2 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {1} \
 ] $s_axi_interconnect_hp2

  # Create instance: usp_rf_data_converter_0, and set properties
  set usp_rf_data_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:usp_rf_data_converter:2.1 usp_rf_data_converter_0 ]
  set_property -dict [ list \
   CONFIG.ADC0_Fabric_Freq {256.000} \
   CONFIG.ADC0_Outclk_Freq {128.000} \
   CONFIG.ADC0_PLL_Enable {true} \
   CONFIG.ADC0_Refclk_Freq {409.600} \
   CONFIG.ADC0_Sampling_Rate {2.048} \
   CONFIG.ADC1_Enable {1} \
   CONFIG.ADC1_Fabric_Freq {256.000} \
   CONFIG.ADC1_Outclk_Freq {128.000} \
   CONFIG.ADC1_PLL_Enable {true} \
   CONFIG.ADC1_Refclk_Freq {409.600} \
   CONFIG.ADC1_Sampling_Rate {2.048} \
   CONFIG.ADC_Data_Type00 {1} \
   CONFIG.ADC_Data_Type01 {1} \
   CONFIG.ADC_Data_Type02 {1} \
   CONFIG.ADC_Data_Type03 {1} \
   CONFIG.ADC_Data_Type10 {1} \
   CONFIG.ADC_Data_Type11 {1} \
   CONFIG.ADC_Data_Width00 {1} \
   CONFIG.ADC_Data_Width01 {1} \
   CONFIG.ADC_Data_Width02 {1} \
   CONFIG.ADC_Data_Width03 {1} \
   CONFIG.ADC_Data_Width10 {1} \
   CONFIG.ADC_Data_Width11 {1} \
   CONFIG.ADC_Decimation_Mode00 {8} \
   CONFIG.ADC_Decimation_Mode01 {8} \
   CONFIG.ADC_Decimation_Mode02 {8} \
   CONFIG.ADC_Decimation_Mode03 {8} \
   CONFIG.ADC_Decimation_Mode10 {8} \
   CONFIG.ADC_Decimation_Mode11 {8} \
   CONFIG.ADC_Mixer_Mode00 {0} \
   CONFIG.ADC_Mixer_Mode01 {0} \
   CONFIG.ADC_Mixer_Mode02 {0} \
   CONFIG.ADC_Mixer_Mode03 {0} \
   CONFIG.ADC_Mixer_Mode10 {0} \
   CONFIG.ADC_Mixer_Mode11 {0} \
   CONFIG.ADC_Mixer_Type00 {2} \
   CONFIG.ADC_Mixer_Type01 {2} \
   CONFIG.ADC_Mixer_Type02 {2} \
   CONFIG.ADC_Mixer_Type03 {2} \
   CONFIG.ADC_Mixer_Type10 {2} \
   CONFIG.ADC_Mixer_Type11 {2} \
   CONFIG.ADC_Slice02_Enable {true} \
   CONFIG.ADC_Slice03_Enable {true} \
   CONFIG.ADC_Slice10_Enable {true} \
   CONFIG.ADC_Slice11_Enable {true} \
   CONFIG.DAC1_Band {3} \
   CONFIG.DAC1_Enable {1} \
   CONFIG.DAC1_Fabric_Freq {256.000} \
   CONFIG.DAC1_Outclk_Freq {256.000} \
   CONFIG.DAC1_PLL_Enable {true} \
   CONFIG.DAC1_Refclk_Freq {409.600} \
   CONFIG.DAC1_Sampling_Rate {2.048} \
   CONFIG.DAC_Data_Type12 {0} \
   CONFIG.DAC_Data_Width10 {8} \
   CONFIG.DAC_Data_Width11 {8} \
   CONFIG.DAC_Data_Width12 {8} \
   CONFIG.DAC_Data_Width13 {8} \
   CONFIG.DAC_Interpolation_Mode10 {2} \
   CONFIG.DAC_Interpolation_Mode11 {2} \
   CONFIG.DAC_Interpolation_Mode12 {2} \
   CONFIG.DAC_Interpolation_Mode13 {2} \
   CONFIG.DAC_Mixer_Mode10 {0} \
   CONFIG.DAC_Mixer_Mode11 {0} \
   CONFIG.DAC_Mixer_Mode12 {0} \
   CONFIG.DAC_Mixer_Mode13 {0} \
   CONFIG.DAC_Mixer_Type10 {2} \
   CONFIG.DAC_Mixer_Type11 {2} \
   CONFIG.DAC_Mixer_Type12 {2} \
   CONFIG.DAC_Mixer_Type13 {2} \
   CONFIG.DAC_Slice10_Enable {true} \
   CONFIG.DAC_Slice12_Enable {true} \
 ] $usp_rf_data_converter_0

  # Create instance: xlconcat, and set properties
  set xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat ]

  # Create instance: zynq_ultra_ps_e, and set properties
  set zynq_ultra_ps_e [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps_e ]
  set_property -dict [ list \
   CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \
   CONFIG.PSU_DDR_RAM_HIGHADDR {0xFFFFFFFF} \
   CONFIG.PSU_DDR_RAM_HIGHADDR_OFFSET {0x800000000} \
   CONFIG.PSU_DDR_RAM_LOWADDR_OFFSET {0x80000000} \
   CONFIG.PSU_DYNAMIC_DDR_CONFIG_EN {0} \
   CONFIG.PSU_MIO_0_DIRECTION {out} \
   CONFIG.PSU_MIO_0_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_0_POLARITY {Default} \
   CONFIG.PSU_MIO_10_DIRECTION {inout} \
   CONFIG.PSU_MIO_10_POLARITY {Default} \
   CONFIG.PSU_MIO_11_DIRECTION {inout} \
   CONFIG.PSU_MIO_11_POLARITY {Default} \
   CONFIG.PSU_MIO_12_DIRECTION {out} \
   CONFIG.PSU_MIO_12_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_12_POLARITY {Default} \
   CONFIG.PSU_MIO_13_DIRECTION {inout} \
   CONFIG.PSU_MIO_13_POLARITY {Default} \
   CONFIG.PSU_MIO_14_DIRECTION {inout} \
   CONFIG.PSU_MIO_14_POLARITY {Default} \
   CONFIG.PSU_MIO_15_DIRECTION {inout} \
   CONFIG.PSU_MIO_15_POLARITY {Default} \
   CONFIG.PSU_MIO_16_DIRECTION {inout} \
   CONFIG.PSU_MIO_16_POLARITY {Default} \
   CONFIG.PSU_MIO_17_DIRECTION {inout} \
   CONFIG.PSU_MIO_17_POLARITY {Default} \
   CONFIG.PSU_MIO_18_DIRECTION {in} \
   CONFIG.PSU_MIO_18_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_18_POLARITY {Default} \
   CONFIG.PSU_MIO_18_SLEW {fast} \
   CONFIG.PSU_MIO_19_DIRECTION {out} \
   CONFIG.PSU_MIO_19_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_19_POLARITY {Default} \
   CONFIG.PSU_MIO_1_DIRECTION {inout} \
   CONFIG.PSU_MIO_1_POLARITY {Default} \
   CONFIG.PSU_MIO_20_DIRECTION {inout} \
   CONFIG.PSU_MIO_20_POLARITY {Default} \
   CONFIG.PSU_MIO_21_DIRECTION {inout} \
   CONFIG.PSU_MIO_21_POLARITY {Default} \
   CONFIG.PSU_MIO_22_DIRECTION {inout} \
   CONFIG.PSU_MIO_22_POLARITY {Default} \
   CONFIG.PSU_MIO_23_DIRECTION {inout} \
   CONFIG.PSU_MIO_23_POLARITY {Default} \
   CONFIG.PSU_MIO_24_DIRECTION {inout} \
   CONFIG.PSU_MIO_24_POLARITY {Default} \
   CONFIG.PSU_MIO_25_DIRECTION {inout} \
   CONFIG.PSU_MIO_25_POLARITY {Default} \
   CONFIG.PSU_MIO_26_DIRECTION {inout} \
   CONFIG.PSU_MIO_26_POLARITY {Default} \
   CONFIG.PSU_MIO_27_DIRECTION {out} \
   CONFIG.PSU_MIO_27_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_27_POLARITY {Default} \
   CONFIG.PSU_MIO_28_DIRECTION {in} \
   CONFIG.PSU_MIO_28_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_28_POLARITY {Default} \
   CONFIG.PSU_MIO_28_SLEW {fast} \
   CONFIG.PSU_MIO_29_DIRECTION {out} \
   CONFIG.PSU_MIO_29_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_29_POLARITY {Default} \
   CONFIG.PSU_MIO_2_DIRECTION {inout} \
   CONFIG.PSU_MIO_2_POLARITY {Default} \
   CONFIG.PSU_MIO_30_DIRECTION {in} \
   CONFIG.PSU_MIO_30_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_30_POLARITY {Default} \
   CONFIG.PSU_MIO_30_SLEW {fast} \
   CONFIG.PSU_MIO_31_DIRECTION {inout} \
   CONFIG.PSU_MIO_31_POLARITY {Default} \
   CONFIG.PSU_MIO_32_DIRECTION {out} \
   CONFIG.PSU_MIO_32_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_32_POLARITY {Default} \
   CONFIG.PSU_MIO_33_DIRECTION {out} \
   CONFIG.PSU_MIO_33_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_33_POLARITY {Default} \
   CONFIG.PSU_MIO_34_DIRECTION {out} \
   CONFIG.PSU_MIO_34_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_34_POLARITY {Default} \
   CONFIG.PSU_MIO_35_DIRECTION {out} \
   CONFIG.PSU_MIO_35_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_35_POLARITY {Default} \
   CONFIG.PSU_MIO_36_DIRECTION {out} \
   CONFIG.PSU_MIO_36_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_36_POLARITY {Default} \
   CONFIG.PSU_MIO_37_DIRECTION {out} \
   CONFIG.PSU_MIO_37_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_37_POLARITY {Default} \
   CONFIG.PSU_MIO_38_DIRECTION {inout} \
   CONFIG.PSU_MIO_38_POLARITY {Default} \
   CONFIG.PSU_MIO_39_DIRECTION {inout} \
   CONFIG.PSU_MIO_39_POLARITY {Default} \
   CONFIG.PSU_MIO_3_DIRECTION {inout} \
   CONFIG.PSU_MIO_3_POLARITY {Default} \
   CONFIG.PSU_MIO_40_DIRECTION {inout} \
   CONFIG.PSU_MIO_40_POLARITY {Default} \
   CONFIG.PSU_MIO_41_DIRECTION {inout} \
   CONFIG.PSU_MIO_41_POLARITY {Default} \
   CONFIG.PSU_MIO_42_DIRECTION {inout} \
   CONFIG.PSU_MIO_42_POLARITY {Default} \
   CONFIG.PSU_MIO_43_DIRECTION {inout} \
   CONFIG.PSU_MIO_43_POLARITY {Default} \
   CONFIG.PSU_MIO_44_DIRECTION {inout} \
   CONFIG.PSU_MIO_44_POLARITY {Default} \
   CONFIG.PSU_MIO_45_DIRECTION {in} \
   CONFIG.PSU_MIO_45_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_45_POLARITY {Default} \
   CONFIG.PSU_MIO_45_SLEW {fast} \
   CONFIG.PSU_MIO_46_DIRECTION {inout} \
   CONFIG.PSU_MIO_46_POLARITY {Default} \
   CONFIG.PSU_MIO_47_DIRECTION {inout} \
   CONFIG.PSU_MIO_47_POLARITY {Default} \
   CONFIG.PSU_MIO_48_DIRECTION {inout} \
   CONFIG.PSU_MIO_48_POLARITY {Default} \
   CONFIG.PSU_MIO_49_DIRECTION {inout} \
   CONFIG.PSU_MIO_49_POLARITY {Default} \
   CONFIG.PSU_MIO_4_DIRECTION {inout} \
   CONFIG.PSU_MIO_4_POLARITY {Default} \
   CONFIG.PSU_MIO_50_DIRECTION {inout} \
   CONFIG.PSU_MIO_50_POLARITY {Default} \
   CONFIG.PSU_MIO_51_DIRECTION {out} \
   CONFIG.PSU_MIO_51_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_51_POLARITY {Default} \
   CONFIG.PSU_MIO_52_DIRECTION {in} \
   CONFIG.PSU_MIO_52_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_52_POLARITY {Default} \
   CONFIG.PSU_MIO_52_SLEW {fast} \
   CONFIG.PSU_MIO_53_DIRECTION {in} \
   CONFIG.PSU_MIO_53_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_53_POLARITY {Default} \
   CONFIG.PSU_MIO_53_SLEW {fast} \
   CONFIG.PSU_MIO_54_DIRECTION {inout} \
   CONFIG.PSU_MIO_54_POLARITY {Default} \
   CONFIG.PSU_MIO_55_DIRECTION {in} \
   CONFIG.PSU_MIO_55_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_55_POLARITY {Default} \
   CONFIG.PSU_MIO_55_SLEW {fast} \
   CONFIG.PSU_MIO_56_DIRECTION {inout} \
   CONFIG.PSU_MIO_56_POLARITY {Default} \
   CONFIG.PSU_MIO_57_DIRECTION {inout} \
   CONFIG.PSU_MIO_57_POLARITY {Default} \
   CONFIG.PSU_MIO_58_DIRECTION {out} \
   CONFIG.PSU_MIO_58_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_58_POLARITY {Default} \
   CONFIG.PSU_MIO_59_DIRECTION {inout} \
   CONFIG.PSU_MIO_59_POLARITY {Default} \
   CONFIG.PSU_MIO_5_DIRECTION {out} \
   CONFIG.PSU_MIO_5_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_5_POLARITY {Default} \
   CONFIG.PSU_MIO_60_DIRECTION {inout} \
   CONFIG.PSU_MIO_60_POLARITY {Default} \
   CONFIG.PSU_MIO_61_DIRECTION {inout} \
   CONFIG.PSU_MIO_61_POLARITY {Default} \
   CONFIG.PSU_MIO_62_DIRECTION {inout} \
   CONFIG.PSU_MIO_62_POLARITY {Default} \
   CONFIG.PSU_MIO_63_DIRECTION {inout} \
   CONFIG.PSU_MIO_63_POLARITY {Default} \
   CONFIG.PSU_MIO_64_DIRECTION {out} \
   CONFIG.PSU_MIO_64_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_64_POLARITY {Default} \
   CONFIG.PSU_MIO_65_DIRECTION {out} \
   CONFIG.PSU_MIO_65_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_65_POLARITY {Default} \
   CONFIG.PSU_MIO_66_DIRECTION {out} \
   CONFIG.PSU_MIO_66_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_66_POLARITY {Default} \
   CONFIG.PSU_MIO_67_DIRECTION {out} \
   CONFIG.PSU_MIO_67_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_67_POLARITY {Default} \
   CONFIG.PSU_MIO_68_DIRECTION {out} \
   CONFIG.PSU_MIO_68_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_68_POLARITY {Default} \
   CONFIG.PSU_MIO_69_DIRECTION {out} \
   CONFIG.PSU_MIO_69_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_69_POLARITY {Default} \
   CONFIG.PSU_MIO_6_DIRECTION {out} \
   CONFIG.PSU_MIO_6_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_6_POLARITY {Default} \
   CONFIG.PSU_MIO_70_DIRECTION {in} \
   CONFIG.PSU_MIO_70_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_70_POLARITY {Default} \
   CONFIG.PSU_MIO_70_SLEW {fast} \
   CONFIG.PSU_MIO_71_DIRECTION {in} \
   CONFIG.PSU_MIO_71_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_71_POLARITY {Default} \
   CONFIG.PSU_MIO_71_SLEW {fast} \
   CONFIG.PSU_MIO_72_DIRECTION {in} \
   CONFIG.PSU_MIO_72_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_72_POLARITY {Default} \
   CONFIG.PSU_MIO_72_SLEW {fast} \
   CONFIG.PSU_MIO_73_DIRECTION {in} \
   CONFIG.PSU_MIO_73_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_73_POLARITY {Default} \
   CONFIG.PSU_MIO_73_SLEW {fast} \
   CONFIG.PSU_MIO_74_DIRECTION {in} \
   CONFIG.PSU_MIO_74_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_74_POLARITY {Default} \
   CONFIG.PSU_MIO_74_SLEW {fast} \
   CONFIG.PSU_MIO_75_DIRECTION {in} \
   CONFIG.PSU_MIO_75_DRIVE_STRENGTH {12} \
   CONFIG.PSU_MIO_75_POLARITY {Default} \
   CONFIG.PSU_MIO_75_SLEW {fast} \
   CONFIG.PSU_MIO_76_DIRECTION {out} \
   CONFIG.PSU_MIO_76_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_76_POLARITY {Default} \
   CONFIG.PSU_MIO_77_DIRECTION {inout} \
   CONFIG.PSU_MIO_77_POLARITY {Default} \
   CONFIG.PSU_MIO_7_DIRECTION {out} \
   CONFIG.PSU_MIO_7_INPUT_TYPE {cmos} \
   CONFIG.PSU_MIO_7_POLARITY {Default} \
   CONFIG.PSU_MIO_8_DIRECTION {inout} \
   CONFIG.PSU_MIO_8_POLARITY {Default} \
   CONFIG.PSU_MIO_9_DIRECTION {inout} \
   CONFIG.PSU_MIO_9_POLARITY {Default} \
   CONFIG.PSU_MIO_TREE_PERIPHERALS {Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Feedback Clk#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#Quad SPI Flash#GPIO0 MIO#I2C 0#I2C 0#I2C 1#I2C 1#UART 0#UART 0#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO0 MIO#GPIO1 MIO#DPAUX#DPAUX#DPAUX#DPAUX#GPIO1 MIO#PMU GPO 0#PMU GPO 1#PMU GPO 2#PMU GPO 3#PMU GPO 4#PMU GPO 5#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#GPIO1 MIO#GPIO1 MIO#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#SD 1#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#USB 0#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#Gem 3#MDIO 3#MDIO 3} \
   CONFIG.PSU_MIO_TREE_SIGNALS {sclk_out#miso_mo1#mo2#mo3#mosi_mi0#n_ss_out#clk_for_lpbk#n_ss_out_upper#mo_upper[0]#mo_upper[1]#mo_upper[2]#mo_upper[3]#sclk_out_upper#gpio0[13]#scl_out#sda_out#scl_out#sda_out#rxd#txd#gpio0[20]#gpio0[21]#gpio0[22]#gpio0[23]#gpio0[24]#gpio0[25]#gpio1[26]#dp_aux_data_out#dp_hot_plug_detect#dp_aux_data_oe#dp_aux_data_in#gpio1[31]#gpo[0]#gpo[1]#gpo[2]#gpo[3]#gpo[4]#gpo[5]#gpio1[38]#sdio1_data_out[4]#sdio1_data_out[5]#sdio1_data_out[6]#sdio1_data_out[7]#gpio1[43]#gpio1[44]#sdio1_cd_n#sdio1_data_out[0]#sdio1_data_out[1]#sdio1_data_out[2]#sdio1_data_out[3]#sdio1_cmd_out#sdio1_clk_out#ulpi_clk_in#ulpi_dir#ulpi_tx_data[2]#ulpi_nxt#ulpi_tx_data[0]#ulpi_tx_data[1]#ulpi_stp#ulpi_tx_data[3]#ulpi_tx_data[4]#ulpi_tx_data[5]#ulpi_tx_data[6]#ulpi_tx_data[7]#rgmii_tx_clk#rgmii_txd[0]#rgmii_txd[1]#rgmii_txd[2]#rgmii_txd[3]#rgmii_tx_ctl#rgmii_rx_clk#rgmii_rxd[0]#rgmii_rxd[1]#rgmii_rxd[2]#rgmii_rxd[3]#rgmii_rx_ctl#gem3_mdc#gem3_mdio_out} \
   CONFIG.PSU_SD1_INTERNAL_BUS_WIDTH {8} \
   CONFIG.PSU_USB3__DUAL_CLOCK_ENABLE {1} \
   CONFIG.PSU__ACT_DDR_FREQ_MHZ {1066.656006} \
   CONFIG.PSU__CAN1__GRP_CLK__ENABLE {0} \
   CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__ACT_FREQMHZ {1199.988037} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__DIVISOR0 {1} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \
   CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FBDIV {72} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__APLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__APLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \
   CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FBDIV {64} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__DPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__DPLL_TO_LPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__ACT_FREQMHZ {24.999750} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_AUDIO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__ACT_FREQMHZ {26.785446} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR0 {14} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__ACT_FREQMHZ {299.997009} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \
   CONFIG.PSU__CRF_APB__DP_VIDEO__FRAC_ENABLED {0} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__ACT_FREQMHZ {599.994019} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \
   CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__DIVISOR0 {5} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__ACT_FREQMHZ {533.328003} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \
   CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRF_APB__VPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRF_APB__VPLL_TO_LPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__AFI6_REF_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__ACT_FREQMHZ {49.999500} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR0 {30} \
   CONFIG.PSU__CRL_APB__AMS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__DLL_REF_CTRL__ACT_FREQMHZ {1499.984985} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__GEM_TSU_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FBDIV {90} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__IOPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__IOPLL_TO_FPD_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__ACT_FREQMHZ {499.994995} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__DIVISOR0 {3} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \
   CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__NAND_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL2_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR0 {4} \
   CONFIG.PSU__CRL_APB__PL3_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__ACT_FREQMHZ {124.998749} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR0 {12} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \
   CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__DIV2 {1} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FBDIV {45} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__FRACDATA {0.000000} \
   CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \
   CONFIG.PSU__CRL_APB__RPLL_FRAC_CFG__ENABLED {0} \
   CONFIG.PSU__CRL_APB__RPLL_TO_FPD_CTRL__DIVISOR0 {2} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SDIO0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__ACT_FREQMHZ {187.498123} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR0 {8} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \
   CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR0 {7} \
   CONFIG.PSU__CRL_APB__SPI1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR0 {15} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \
   CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__ACT_FREQMHZ {249.997498} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \
   CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR0 {6} \
   CONFIG.PSU__CRL_APB__USB1_BUS_REF_CTRL__DIVISOR1 {1} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__ACT_FREQMHZ {19.999800} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR0 {25} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__DIVISOR1 {3} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \
   CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \
   CONFIG.PSU__CRL_APB__USB3__ENABLE {1} \
   CONFIG.PSU__CSUPMU__PERIPHERAL__VALID {1} \
   CONFIG.PSU__DDRC__ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \
   CONFIG.PSU__DDRC__BG_ADDR_COUNT {1} \
   CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \
   CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \
   CONFIG.PSU__DDRC__CL {15} \
   CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \
   CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \
   CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \
   CONFIG.PSU__DDRC__CWL {14} \
   CONFIG.PSU__DDRC__DDR3L_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \
   CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \
   CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \
   CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \
   CONFIG.PSU__DDRC__DEEP_PWR_DOWN_EN {0} \
   CONFIG.PSU__DDRC__DEVICE_CAPACITY {8192 MBits} \
   CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \
   CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \
   CONFIG.PSU__DDRC__DQMAP_0_3 {0} \
   CONFIG.PSU__DDRC__DQMAP_12_15 {0} \
   CONFIG.PSU__DDRC__DQMAP_16_19 {0} \
   CONFIG.PSU__DDRC__DQMAP_20_23 {0} \
   CONFIG.PSU__DDRC__DQMAP_24_27 {0} \
   CONFIG.PSU__DDRC__DQMAP_28_31 {0} \
   CONFIG.PSU__DDRC__DQMAP_32_35 {0} \
   CONFIG.PSU__DDRC__DQMAP_36_39 {0} \
   CONFIG.PSU__DDRC__DQMAP_40_43 {0} \
   CONFIG.PSU__DDRC__DQMAP_44_47 {0} \
   CONFIG.PSU__DDRC__DQMAP_48_51 {0} \
   CONFIG.PSU__DDRC__DQMAP_4_7 {0} \
   CONFIG.PSU__DDRC__DQMAP_52_55 {0} \
   CONFIG.PSU__DDRC__DQMAP_56_59 {0} \
   CONFIG.PSU__DDRC__DQMAP_60_63 {0} \
   CONFIG.PSU__DDRC__DQMAP_64_67 {0} \
   CONFIG.PSU__DDRC__DQMAP_68_71 {0} \
   CONFIG.PSU__DDRC__DQMAP_8_11 {0} \
   CONFIG.PSU__DDRC__DRAM_WIDTH {16 Bits} \
   CONFIG.PSU__DDRC__ECC {Disabled} \
   CONFIG.PSU__DDRC__ENABLE_LP4_HAS_ECC_COMP {0} \
   CONFIG.PSU__DDRC__ENABLE_LP4_SLOWBOOT {0} \
   CONFIG.PSU__DDRC__FGRM {1X} \
   CONFIG.PSU__DDRC__LPDDR3_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LPDDR4_T_REF_RANGE {NA} \
   CONFIG.PSU__DDRC__LP_ASR {manual normal} \
   CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \
   CONFIG.PSU__DDRC__PARITY_ENABLE {0} \
   CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \
   CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \
   CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \
   CONFIG.PSU__DDRC__ROW_ADDR_COUNT {16} \
   CONFIG.PSU__DDRC__SB_TARGET {15-15-15} \
   CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \
   CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \
   CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \
   CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \
   CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \
   CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \
   CONFIG.PSU__DDRC__T_FAW {30.0} \
   CONFIG.PSU__DDRC__T_RAS_MIN {33} \
   CONFIG.PSU__DDRC__T_RC {47.06} \
   CONFIG.PSU__DDRC__T_RCD {15} \
   CONFIG.PSU__DDRC__T_RP {15} \
   CONFIG.PSU__DDRC__VENDOR_PART {OTHERS} \
   CONFIG.PSU__DDRC__VREF {1} \
   CONFIG.PSU__DDR_HIGH_ADDRESS_GUI_ENABLE {1} \
   CONFIG.PSU__DDR__INTERFACE__FREQMHZ {533.500} \
   CONFIG.PSU__DISPLAYPORT__LANE0__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE0__IO {GT Lane1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__ENABLE {1} \
   CONFIG.PSU__DISPLAYPORT__LANE1__IO {GT Lane0} \
   CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DLL__ISUSED {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \
   CONFIG.PSU__DP__LANE_SEL {Dual Lower} \
   CONFIG.PSU__DP__REF_CLK_FREQ {27} \
   CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk1} \
   CONFIG.PSU__ENET3__FIFO__ENABLE {0} \
   CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \
   CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \
   CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \
   CONFIG.PSU__ENET3__PTP__ENABLE {0} \
   CONFIG.PSU__ENET3__TSU__ENABLE {0} \
   CONFIG.PSU__FPDMASTERS_COHERENCY {0} \
   CONFIG.PSU__FPD_SLCR__WDT1__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT1__FREQMHZ {99.999001} \
   CONFIG.PSU__FPD_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__FPGA_PL0_ENABLE {1} \
   CONFIG.PSU__GEM3_COHERENCY {0} \
   CONFIG.PSU__GEM3_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__GEM__TSU__ENABLE {0} \
   CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \
   CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \
   CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__GT__LINK_SPEED {HBR} \
   CONFIG.PSU__GT__PRE_EMPH_LVL_4 {0} \
   CONFIG.PSU__GT__VLT_SWNG_LVL_4 {0} \
   CONFIG.PSU__HIGH_ADDRESS__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \
   CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \
   CONFIG.PSU__IOU_SLCR__TTC0__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC0__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC1__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC2__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__TTC3__FREQMHZ {100.000000} \
   CONFIG.PSU__IOU_SLCR__WDT0__ACT_FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT0__FREQMHZ {99.999001} \
   CONFIG.PSU__IOU_SLCR__WDT_CLK_SEL__SELECT {APB} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__ACT_FREQMHZ {100.000000} \
   CONFIG.PSU__LPD_SLCR__CSUPMU__FREQMHZ {100.000000} \
   CONFIG.PSU__MAXIGP0__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP1__DATA_WIDTH {128} \
   CONFIG.PSU__MAXIGP2__DATA_WIDTH {32} \
   CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \
   CONFIG.PSU__PL_CLK0_BUF {TRUE} \
   CONFIG.PSU__PMU_COHERENCY {0} \
   CONFIG.PSU__PMU__AIBACK__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPI__ENABLE {0} \
   CONFIG.PSU__PMU__EMIO_GPO__ENABLE {0} \
   CONFIG.PSU__PMU__GPI0__ENABLE {0} \
   CONFIG.PSU__PMU__GPI1__ENABLE {0} \
   CONFIG.PSU__PMU__GPI2__ENABLE {0} \
   CONFIG.PSU__PMU__GPI3__ENABLE {0} \
   CONFIG.PSU__PMU__GPI4__ENABLE {0} \
   CONFIG.PSU__PMU__GPI5__ENABLE {0} \
   CONFIG.PSU__PMU__GPO0__ENABLE {1} \
   CONFIG.PSU__PMU__GPO0__IO {MIO 32} \
   CONFIG.PSU__PMU__GPO1__ENABLE {1} \
   CONFIG.PSU__PMU__GPO1__IO {MIO 33} \
   CONFIG.PSU__PMU__GPO2__ENABLE {1} \
   CONFIG.PSU__PMU__GPO2__IO {MIO 34} \
   CONFIG.PSU__PMU__GPO2__POLARITY {low} \
   CONFIG.PSU__PMU__GPO3__ENABLE {1} \
   CONFIG.PSU__PMU__GPO3__IO {MIO 35} \
   CONFIG.PSU__PMU__GPO3__POLARITY {low} \
   CONFIG.PSU__PMU__GPO4__ENABLE {1} \
   CONFIG.PSU__PMU__GPO4__IO {MIO 36} \
   CONFIG.PSU__PMU__GPO4__POLARITY {low} \
   CONFIG.PSU__PMU__GPO5__ENABLE {1} \
   CONFIG.PSU__PMU__GPO5__IO {MIO 37} \
   CONFIG.PSU__PMU__GPO5__POLARITY {low} \
   CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__PMU__PLERROR__ENABLE {0} \
   CONFIG.PSU__PRESET_APPLIED {1} \
   CONFIG.PSU__PROTECTION__MASTERS {USB1:NonSecure;0|USB0:NonSecure;1|S_AXI_LPD:NA;0|S_AXI_HPC1_FPD:NA;0|S_AXI_HPC0_FPD:NA;0|S_AXI_HP3_FPD:NA;0|S_AXI_HP2_FPD:NA;1|S_AXI_HP1_FPD:NA;0|S_AXI_HP0_FPD:NA;1|S_AXI_ACP:NA;0|S_AXI_ACE:NA;0|SD1:NonSecure;1|SD0:NonSecure;0|SATA1:NonSecure;1|SATA0:NonSecure;1|RPU1:Secure;1|RPU0:Secure;1|QSPI:NonSecure;1|PMU:NA;1|PCIe:NonSecure;0|NAND:NonSecure;0|LDMA:NonSecure;1|GPU:NonSecure;1|GEM3:NonSecure;1|GEM2:NonSecure;0|GEM1:NonSecure;0|GEM0:NonSecure;0|FDMA:NonSecure;1|DP:NonSecure;1|DAP:NA;1|Coresight:NA;1|CSU:NA;1|APU:NA;1} \
   CONFIG.PSU__PROTECTION__SLAVES {LPD;USB3_1_XHCI;FE300000;FE3FFFFF;0|LPD;USB3_1;FF9E0000;FF9EFFFF;0|LPD;USB3_0_XHCI;FE200000;FE2FFFFF;1|LPD;USB3_0;FF9D0000;FF9DFFFF;1|LPD;UART1;FF010000;FF01FFFF;0|LPD;UART0;FF000000;FF00FFFF;1|LPD;TTC3;FF140000;FF14FFFF;1|LPD;TTC2;FF130000;FF13FFFF;1|LPD;TTC1;FF120000;FF12FFFF;1|LPD;TTC0;FF110000;FF11FFFF;1|FPD;SWDT1;FD4D0000;FD4DFFFF;1|LPD;SWDT0;FF150000;FF15FFFF;1|LPD;SPI1;FF050000;FF05FFFF;0|LPD;SPI0;FF040000;FF04FFFF;0|FPD;SMMU_REG;FD5F0000;FD5FFFFF;1|FPD;SMMU;FD800000;FDFFFFFF;1|FPD;SIOU;FD3D0000;FD3DFFFF;1|FPD;SERDES;FD400000;FD47FFFF;1|LPD;SD1;FF170000;FF17FFFF;1|LPD;SD0;FF160000;FF16FFFF;0|FPD;SATA;FD0C0000;FD0CFFFF;1|LPD;RTC;FFA60000;FFA6FFFF;1|LPD;RSA_CORE;FFCE0000;FFCEFFFF;1|LPD;RPU;FF9A0000;FF9AFFFF;1|LPD;R5_TCM_RAM_GLOBAL;FFE00000;FFE3FFFF;1|LPD;R5_1_Instruction_Cache;FFEC0000;FFECFFFF;1|LPD;R5_1_Data_Cache;FFED0000;FFEDFFFF;1|LPD;R5_1_BTCM_GLOBAL;FFEB0000;FFEBFFFF;1|LPD;R5_1_ATCM_GLOBAL;FFE90000;FFE9FFFF;1|LPD;R5_0_Instruction_Cache;FFE40000;FFE4FFFF;1|LPD;R5_0_Data_Cache;FFE50000;FFE5FFFF;1|LPD;R5_0_BTCM_GLOBAL;FFE20000;FFE2FFFF;1|LPD;R5_0_ATCM_GLOBAL;FFE00000;FFE0FFFF;1|LPD;QSPI_Linear_Address;C0000000;DFFFFFFF;1|LPD;QSPI;FF0F0000;FF0FFFFF;1|LPD;PMU_RAM;FFDC0000;FFDDFFFF;1|LPD;PMU_GLOBAL;FFD80000;FFDBFFFF;1|FPD;PCIE_MAIN;FD0E0000;FD0EFFFF;0|FPD;PCIE_LOW;E0000000;EFFFFFFF;0|FPD;PCIE_HIGH2;8000000000;BFFFFFFFFF;0|FPD;PCIE_HIGH1;600000000;7FFFFFFFF;0|FPD;PCIE_DMA;FD0F0000;FD0FFFFF;0|FPD;PCIE_ATTRIB;FD480000;FD48FFFF;0|LPD;OCM_XMPU_CFG;FFA70000;FFA7FFFF;1|LPD;OCM_SLCR;FF960000;FF96FFFF;1|OCM;OCM;FFFC0000;FFFFFFFF;1|LPD;NAND;FF100000;FF10FFFF;0|LPD;MBISTJTAG;FFCF0000;FFCFFFFF;1|LPD;LPD_XPPU_SINK;FF9C0000;FF9CFFFF;1|LPD;LPD_XPPU;FF980000;FF98FFFF;1|LPD;LPD_SLCR_SECURE;FF4B0000;FF4DFFFF;1|LPD;LPD_SLCR;FF410000;FF4AFFFF;1|LPD;LPD_GPV;FE100000;FE1FFFFF;1|LPD;LPD_DMA_7;FFAF0000;FFAFFFFF;1|LPD;LPD_DMA_6;FFAE0000;FFAEFFFF;1|LPD;LPD_DMA_5;FFAD0000;FFADFFFF;1|LPD;LPD_DMA_4;FFAC0000;FFACFFFF;1|LPD;LPD_DMA_3;FFAB0000;FFABFFFF;1|LPD;LPD_DMA_2;FFAA0000;FFAAFFFF;1|LPD;LPD_DMA_1;FFA90000;FFA9FFFF;1|LPD;LPD_DMA_0;FFA80000;FFA8FFFF;1|LPD;IPI_CTRL;FF380000;FF3FFFFF;1|LPD;IOU_SLCR;FF180000;FF23FFFF;1|LPD;IOU_SECURE_SLCR;FF240000;FF24FFFF;1|LPD;IOU_SCNTRS;FF260000;FF26FFFF;1|LPD;IOU_SCNTR;FF250000;FF25FFFF;1|LPD;IOU_GPV;FE000000;FE0FFFFF;1|LPD;I2C1;FF030000;FF03FFFF;1|LPD;I2C0;FF020000;FF02FFFF;1|FPD;GPU;FD4B0000;FD4BFFFF;0|LPD;GPIO;FF0A0000;FF0AFFFF;1|LPD;GEM3;FF0E0000;FF0EFFFF;1|LPD;GEM2;FF0D0000;FF0DFFFF;0|LPD;GEM1;FF0C0000;FF0CFFFF;0|LPD;GEM0;FF0B0000;FF0BFFFF;0|FPD;FPD_XMPU_SINK;FD4F0000;FD4FFFFF;1|FPD;FPD_XMPU_CFG;FD5D0000;FD5DFFFF;1|FPD;FPD_SLCR_SECURE;FD690000;FD6CFFFF;1|FPD;FPD_SLCR;FD610000;FD68FFFF;1|FPD;FPD_GPV;FD700000;FD7FFFFF;1|FPD;FPD_DMA_CH7;FD570000;FD57FFFF;1|FPD;FPD_DMA_CH6;FD560000;FD56FFFF;1|FPD;FPD_DMA_CH5;FD550000;FD55FFFF;1|FPD;FPD_DMA_CH4;FD540000;FD54FFFF;1|FPD;FPD_DMA_CH3;FD530000;FD53FFFF;1|FPD;FPD_DMA_CH2;FD520000;FD52FFFF;1|FPD;FPD_DMA_CH1;FD510000;FD51FFFF;1|FPD;FPD_DMA_CH0;FD500000;FD50FFFF;1|LPD;EFUSE;FFCC0000;FFCCFFFF;1|FPD;Display Port;FD4A0000;FD4AFFFF;1|FPD;DPDMA;FD4C0000;FD4CFFFF;1|FPD;DDR_XMPU5_CFG;FD050000;FD05FFFF;1|FPD;DDR_XMPU4_CFG;FD040000;FD04FFFF;1|FPD;DDR_XMPU3_CFG;FD030000;FD03FFFF;1|FPD;DDR_XMPU2_CFG;FD020000;FD02FFFF;1|FPD;DDR_XMPU1_CFG;FD010000;FD01FFFF;1|FPD;DDR_XMPU0_CFG;FD000000;FD00FFFF;1|FPD;DDR_QOS_CTRL;FD090000;FD09FFFF;1|FPD;DDR_PHY;FD080000;FD08FFFF;1|DDR;DDR_LOW;0;7FFFFFFF;1|DDR;DDR_HIGH;800000000;87FFFFFFF;1|FPD;DDDR_CTRL;FD070000;FD070FFF;1|LPD;Coresight;FE800000;FEFFFFFF;1|LPD;CSU_DMA;FFC80000;FFC9FFFF;1|LPD;CSU;FFCA0000;FFCAFFFF;0|LPD;CRL_APB;FF5E0000;FF85FFFF;1|FPD;CRF_APB;FD1A0000;FD2DFFFF;1|FPD;CCI_REG;FD5E0000;FD5EFFFF;1|FPD;CCI_GPV;FD6E0000;FD6EFFFF;1|LPD;CAN1;FF070000;FF07FFFF;0|LPD;CAN0;FF060000;FF06FFFF;0|FPD;APU;FD5C0000;FD5CFFFF;1|LPD;APM_INTC_IOU;FFA20000;FFA2FFFF;1|LPD;APM_FPD_LPD;FFA30000;FFA3FFFF;1|FPD;APM_5;FD490000;FD49FFFF;1|FPD;APM_0;FD0B0000;FD0BFFFF;1|LPD;APM2;FFA10000;FFA1FFFF;1|LPD;APM1;FFA00000;FFA0FFFF;1|LPD;AMS;FFA50000;FFA5FFFF;1|FPD;AFI_5;FD3B0000;FD3BFFFF;1|FPD;AFI_4;FD3A0000;FD3AFFFF;1|FPD;AFI_3;FD390000;FD39FFFF;1|FPD;AFI_2;FD380000;FD38FFFF;1|FPD;AFI_1;FD370000;FD37FFFF;1|FPD;AFI_0;FD360000;FD36FFFF;1|LPD;AFIFM6;FF9B0000;FF9BFFFF;1|FPD;ACPU_GIC;F9010000;F907FFFF;1} \
   CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \
   CONFIG.PSU__QSPI_COHERENCY {0} \
   CONFIG.PSU__QSPI_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \
   CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \
   CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \
   CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \
   CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \
   CONFIG.PSU__SATA__LANE0__ENABLE {0} \
   CONFIG.PSU__SATA__LANE1__ENABLE {1} \
   CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \
   CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SATA__REF_CLK_FREQ {125} \
   CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk3} \
   CONFIG.PSU__SAXIGP2__DATA_WIDTH {128} \
   CONFIG.PSU__SAXIGP4__DATA_WIDTH {128} \
   CONFIG.PSU__SD1_COHERENCY {0} \
   CONFIG.PSU__SD1_ROUTE_THROUGH_FPD {0} \
   CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \
   CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \
   CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \
   CONFIG.PSU__SD1__GRP_POW__ENABLE {0} \
   CONFIG.PSU__SD1__GRP_WP__ENABLE {0} \
   CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \
   CONFIG.PSU__SD1__RESET__ENABLE {0} \
   CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \
   CONFIG.PSU__SWDT0__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT0__RESET__ENABLE {0} \
   CONFIG.PSU__SWDT1__CLOCK__ENABLE {0} \
   CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__SWDT1__RESET__ENABLE {0} \
   CONFIG.PSU__TSU__BUFG_PORT_PAIR {0} \
   CONFIG.PSU__TTC0__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC0__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC1__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC1__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC2__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC2__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__TTC3__CLOCK__ENABLE {0} \
   CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__TTC3__WAVEOUT__ENABLE {0} \
   CONFIG.PSU__UART0__BAUD_RATE {115200} \
   CONFIG.PSU__UART0__MODEM__ENABLE {0} \
   CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \
   CONFIG.PSU__UART1__BAUD_RATE {<Select>} \
   CONFIG.PSU__UART1__MODEM__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__ENABLE {0} \
   CONFIG.PSU__UART1__PERIPHERAL__IO {<Select>} \
   CONFIG.PSU__USB0_COHERENCY {0} \
   CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \
   CONFIG.PSU__USB0__REF_CLK_FREQ {26} \
   CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \
   CONFIG.PSU__USB0__RESET__ENABLE {0} \
   CONFIG.PSU__USB1__RESET__ENABLE {0} \
   CONFIG.PSU__USB2_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__EMIO__ENABLE {0} \
   CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \
   CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \
   CONFIG.PSU__USB__RESET__MODE {Boot Pin} \
   CONFIG.PSU__USB__RESET__POLARITY {Active Low} \
   CONFIG.PSU__USE__IRQ0 {1} \
   CONFIG.PSU__USE__M_AXI_GP0 {1} \
   CONFIG.PSU__USE__M_AXI_GP1 {0} \
   CONFIG.PSU__USE__M_AXI_GP2 {0} \
   CONFIG.PSU__USE__S_AXI_GP2 {1} \
   CONFIG.PSU__USE__S_AXI_GP4 {1} \
   CONFIG.SUBPRESET1 {Custom} \
 ] $zynq_ultra_ps_e

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins SpectrumAnalyser/M_AXI_CONFIG] [get_bd_intf_pins s_axi_interconnect_hp0/S00_AXI]
  connect_bd_intf_net -intf_net S00_AXI_2 [get_bd_intf_pins SpectrumAnalyser/M_AXI_SAM] [get_bd_intf_pins s_axi_interconnect_hp2/S00_AXI]
  connect_bd_intf_net -intf_net adc0_clk_1 [get_bd_intf_ports adc0_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc0_clk]
  connect_bd_intf_net -intf_net adc1_clk_1 [get_bd_intf_ports adc1_clk] [get_bd_intf_pins usp_rf_data_converter_0/adc1_clk]
  connect_bd_intf_net -intf_net dac1_clk_1 [get_bd_intf_ports dac1_clk] [get_bd_intf_pins usp_rf_data_converter_0/dac1_clk]
  connect_bd_intf_net -intf_net frequency_synth_AXI4_Stream_F0_Master [get_bd_intf_pins frequency_synth/AXI4_Stream_F0_Master] [get_bd_intf_pins usp_rf_data_converter_0/s10_axis]
  connect_bd_intf_net -intf_net frequency_synth_AXI4_Stream_F1_Master [get_bd_intf_pins frequency_synth/AXI4_Stream_F1_Master] [get_bd_intf_pins usp_rf_data_converter_0/s11_axis]
  connect_bd_intf_net -intf_net frequency_synth_AXI4_Stream_F2_Master [get_bd_intf_pins frequency_synth/AXI4_Stream_F2_Master] [get_bd_intf_pins usp_rf_data_converter_0/s12_axis]
  connect_bd_intf_net -intf_net frequency_synth_AXI4_Stream_F3_Master [get_bd_intf_pins frequency_synth/AXI4_Stream_F3_Master] [get_bd_intf_pins usp_rf_data_converter_0/s13_axis]
  connect_bd_intf_net -intf_net ps8_axi_periph_M00_AXI [get_bd_intf_pins ps8_axi_periph/M00_AXI] [get_bd_intf_pins usp_rf_data_converter_0/s_axi]
  connect_bd_intf_net -intf_net ps8_axi_periph_M01_AXI [get_bd_intf_pins axi_intc/s_axi] [get_bd_intf_pins ps8_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net ps8_axi_periph_M02_AXI [get_bd_intf_pins frequency_synth/AXI4_Lite] [get_bd_intf_pins ps8_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net ps8_axi_periph_M03_AXI [get_bd_intf_pins SpectrumAnalyser/S_AXI] [get_bd_intf_pins ps8_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net s_axi_interconnect_hp0_M00_AXI [get_bd_intf_pins s_axi_interconnect_hp0/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP0_FPD]
  connect_bd_intf_net -intf_net s_axi_interconnect_hp2_M00_AXI [get_bd_intf_pins s_axi_interconnect_hp2/M00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP2_FPD]
  connect_bd_intf_net -intf_net sysref_in_1 [get_bd_intf_ports sysref_in] [get_bd_intf_pins usp_rf_data_converter_0/sysref_in]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m00_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_re_0] [get_bd_intf_pins usp_rf_data_converter_0/m00_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m01_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_im_0] [get_bd_intf_pins usp_rf_data_converter_0/m01_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m02_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_re_1] [get_bd_intf_pins usp_rf_data_converter_0/m02_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m03_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_im_1] [get_bd_intf_pins usp_rf_data_converter_0/m03_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m10_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_re_2] [get_bd_intf_pins usp_rf_data_converter_0/m10_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_m11_axis [get_bd_intf_pins SpectrumAnalyser/s_axis_im_2] [get_bd_intf_pins usp_rf_data_converter_0/m11_axis]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_vout10 [get_bd_intf_ports vout10] [get_bd_intf_pins usp_rf_data_converter_0/vout10]
  connect_bd_intf_net -intf_net usp_rf_data_converter_0_vout12 [get_bd_intf_ports vout12] [get_bd_intf_pins usp_rf_data_converter_0/vout12]
  connect_bd_intf_net -intf_net vin0_01_1 [get_bd_intf_ports vin0_01] [get_bd_intf_pins usp_rf_data_converter_0/vin0_01]
  connect_bd_intf_net -intf_net vin0_23_1 [get_bd_intf_ports vin0_23] [get_bd_intf_pins usp_rf_data_converter_0/vin0_23]
  connect_bd_intf_net -intf_net vin1_01_1 [get_bd_intf_ports vin1_01] [get_bd_intf_pins usp_rf_data_converter_0/vin1_01]
  connect_bd_intf_net -intf_net zynq_ultra_ps_e_M_AXI_HPM0_FPD [get_bd_intf_pins ps8_axi_periph/S00_AXI] [get_bd_intf_pins zynq_ultra_ps_e/M_AXI_HPM0_FPD]

  # Create port connections
  connect_bd_net -net axi_intc_irq [get_bd_pins axi_intc/irq] [get_bd_pins zynq_ultra_ps_e/pl_ps_irq0]
  connect_bd_net -net clk_wiz_adc0_clk_out1 [get_bd_pins SpectrumAnalyser/ACLK] [get_bd_pins clk_wiz_adc0/clk_out1] [get_bd_pins proc_sys_reset_adc0/slowest_sync_clk] [get_bd_pins ps8_axi_periph/M03_ACLK] [get_bd_pins s_axi_interconnect_hp0/ACLK] [get_bd_pins s_axi_interconnect_hp0/M00_ACLK] [get_bd_pins s_axi_interconnect_hp0/S00_ACLK] [get_bd_pins s_axi_interconnect_hp2/ACLK] [get_bd_pins s_axi_interconnect_hp2/M00_ACLK] [get_bd_pins s_axi_interconnect_hp2/S00_ACLK] [get_bd_pins usp_rf_data_converter_0/m0_axis_aclk] [get_bd_pins usp_rf_data_converter_0/m1_axis_aclk] [get_bd_pins zynq_ultra_ps_e/saxihp0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e/saxihp2_fpd_aclk]
  connect_bd_net -net clk_wiz_adc0_locked [get_bd_pins clk_wiz_adc0/locked] [get_bd_pins proc_sys_reset_adc0/dcm_locked]
  connect_bd_net -net proc_sys_reset_adc0_peripheral_aresetn [get_bd_pins SpectrumAnalyser/ARESETN] [get_bd_pins proc_sys_reset_adc0/peripheral_aresetn] [get_bd_pins ps8_axi_periph/M03_ARESETN] [get_bd_pins s_axi_interconnect_hp0/ARESETN] [get_bd_pins s_axi_interconnect_hp0/M00_ARESETN] [get_bd_pins s_axi_interconnect_hp0/S00_ARESETN] [get_bd_pins s_axi_interconnect_hp2/ARESETN] [get_bd_pins s_axi_interconnect_hp2/M00_ARESETN] [get_bd_pins s_axi_interconnect_hp2/S00_ARESETN] [get_bd_pins usp_rf_data_converter_0/m0_axis_aresetn] [get_bd_pins usp_rf_data_converter_0/m1_axis_aresetn]
  connect_bd_net -net proc_sys_reset_dac1_peripheral_aresetn [get_bd_pins frequency_synth/AXI4_Lite_ARESETN] [get_bd_pins frequency_synth/IPCORE_RESETN] [get_bd_pins proc_sys_reset_dac1/peripheral_aresetn] [get_bd_pins ps8_axi_periph/M02_ARESETN] [get_bd_pins usp_rf_data_converter_0/s1_axis_aresetn]
  connect_bd_net -net rst_ps8_99M_peripheral_aresetn [get_bd_pins axi_intc/s_axi_aresetn] [get_bd_pins ps8_axi_periph/ARESETN] [get_bd_pins ps8_axi_periph/M00_ARESETN] [get_bd_pins ps8_axi_periph/M01_ARESETN] [get_bd_pins ps8_axi_periph/S00_ARESETN] [get_bd_pins rst_ps8_99M/peripheral_aresetn] [get_bd_pins usp_rf_data_converter_0/s_axi_aresetn]
  connect_bd_net -net usp_rf_data_converter_0_clk_adc1 [get_bd_pins clk_wiz_adc0/clk_in1] [get_bd_pins usp_rf_data_converter_0/clk_adc0]
  connect_bd_net -net usp_rf_data_converter_0_clk_dac1 [get_bd_pins frequency_synth/AXI4_Lite_ACLK] [get_bd_pins frequency_synth/IPCORE_CLK] [get_bd_pins proc_sys_reset_dac1/slowest_sync_clk] [get_bd_pins ps8_axi_periph/M02_ACLK] [get_bd_pins usp_rf_data_converter_0/clk_dac1] [get_bd_pins usp_rf_data_converter_0/s1_axis_aclk]
  connect_bd_net -net usp_rf_data_converter_0_irq [get_bd_pins usp_rf_data_converter_0/irq] [get_bd_pins xlconcat/In0]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc/intr] [get_bd_pins xlconcat/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_pins SpectrumAnalyser/irq] [get_bd_pins xlconcat/In1]
  connect_bd_net -net zynq_ultra_ps_e_pl_clk0 [get_bd_pins axi_intc/s_axi_aclk] [get_bd_pins ps8_axi_periph/ACLK] [get_bd_pins ps8_axi_periph/M00_ACLK] [get_bd_pins ps8_axi_periph/M01_ACLK] [get_bd_pins ps8_axi_periph/S00_ACLK] [get_bd_pins rst_ps8_99M/slowest_sync_clk] [get_bd_pins usp_rf_data_converter_0/s_axi_aclk] [get_bd_pins zynq_ultra_ps_e/maxihpm0_fpd_aclk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
  connect_bd_net -net zynq_ultra_ps_e_pl_resetn0 [get_bd_pins proc_sys_reset_adc0/ext_reset_in] [get_bd_pins proc_sys_reset_dac1/ext_reset_in] [get_bd_pins rst_ps8_99M/ext_reset_in] [get_bd_pins zynq_ultra_ps_e/pl_resetn0]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0xA0050000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/DataInspector/data_inspector/AXI4_Lite/reg0] SEG_DataInspector_reg0
  create_bd_addr_seg -range 0x00001000 -offset 0xA0046000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumADC/adc_switch_im/S_AXI_CTRL/Reg] SEG_adc_switch_im_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0047000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumADC/adc_switch_re/S_AXI_CTRL/Reg] SEG_adc_switch_re_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0043000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/BandwidthSelector/axi_dma_config/S_AXI_LITE/Reg] SEG_axi_dma_config_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0045000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/DataInspector/axi_dma_inspector/S_AXI_LITE/Reg] SEG_axi_dma_inspector_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0044000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/BandwidthSelector/axi_dma_reload/S_AXI_LITE/Reg] SEG_axi_dma_reload_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0048000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumWindow/axi_dma_window/S_AXI_LITE/Reg] SEG_axi_dma_window_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0040000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs axi_intc/S_AXI/Reg] SEG_axi_intc_0_Reg
  create_bd_addr_seg -range 0x00001000 -offset 0xA0042000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/BandwidthSelector/BWSelector/bandwidthselector_s_axi/reg0] SEG_bandwidthselector_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0xA0090000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs frequency_synth/AXI4_Lite/reg0] SEG_frequency_synth_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0xA0060000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumFFT/PSD/AXI4_Lite/reg0] SEG_psd_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0xA0070000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumFFT/FFT/AXI4_Lite/reg0] SEG_spectrum_fft_reg0
  create_bd_addr_seg -range 0x00040000 -offset 0xA0000000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs usp_rf_data_converter_0/s_axi/Reg] SEG_usp_rf_data_converter_0_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xA0080000 [get_bd_addr_spaces zynq_ultra_ps_e/Data] [get_bd_addr_segs SpectrumAnalyser/SpectrumWindow/window/AXI4_Lite/reg0] SEG_window_reg0
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_config/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_config/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_config/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_HP0_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_reload/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_reload/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces SpectrumAnalyser/BandwidthSelector/axi_dma_reload/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_HP0_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces SpectrumAnalyser/DataInspector/axi_dma_inspector/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP4/HP2_DDR_LOW] SEG_zynq_ultra_ps_e_HP2_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces SpectrumAnalyser/DataInspector/axi_dma_inspector/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP4/HP2_LPS_OCM] SEG_zynq_ultra_ps_e_HP2_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces SpectrumAnalyser/DataInspector/axi_dma_inspector/Data_S2MM] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP4/HP2_QSPI] SEG_zynq_ultra_ps_e_HP2_QSPI
  create_bd_addr_seg -range 0x80000000 -offset 0x00000000 [get_bd_addr_spaces SpectrumAnalyser/SpectrumWindow/axi_dma_window/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_DDR_LOW] SEG_zynq_ultra_ps_e_HP0_DDR_LOW
  create_bd_addr_seg -range 0x01000000 -offset 0xFF000000 [get_bd_addr_spaces SpectrumAnalyser/SpectrumWindow/axi_dma_window/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_LPS_OCM] SEG_zynq_ultra_ps_e_HP0_LPS_OCM
  create_bd_addr_seg -range 0x20000000 -offset 0xC0000000 [get_bd_addr_spaces SpectrumAnalyser/SpectrumWindow/axi_dma_window/Data_MM2S] [get_bd_addr_segs zynq_ultra_ps_e/SAXIGP2/HP0_QSPI] SEG_zynq_ultra_ps_e_HP0_QSPI


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


