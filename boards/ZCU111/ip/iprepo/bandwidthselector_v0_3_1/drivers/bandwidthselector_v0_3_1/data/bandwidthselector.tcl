proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "bandwidthselector" "NUM_INSTANCES" "DEVICE_ID" "C_BANDWIDTHSELECTOR_S_AXI_BASEADDR" "C_BANDWIDTHSELECTOR_S_AXI_HIGHADDR" 
    xdefine_config_file $drv_handle "bandwidthselector_g.c" "bandwidthselector" "DEVICE_ID" "C_BANDWIDTHSELECTOR_S_AXI_BASEADDR" 
    xdefine_canonical_xpars $drv_handle "xparameters.h" "bandwidthselector" "DEVICE_ID" "C_BANDWIDTHSELECTOR_S_AXI_BASEADDR" "C_BANDWIDTHSELECTOR_S_AXI_HIGHADDR" 

}