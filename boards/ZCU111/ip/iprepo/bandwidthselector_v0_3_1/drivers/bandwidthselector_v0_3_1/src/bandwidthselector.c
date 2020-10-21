#include "bandwidthselector.h"
#ifndef __linux__
int bandwidthselector_CfgInitialize(bandwidthselector *InstancePtr, bandwidthselector_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->bandwidthselector_BaseAddress = ConfigPtr->bandwidthselector_BaseAddress;

    InstancePtr->IsReady = 1;
    return XST_SUCCESS;
}
#endif
void bandwidthselector_fir_enable_write(bandwidthselector *InstancePtr, u8 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    bandwidthselector_WriteReg(InstancePtr->bandwidthselector_BaseAddress, 0, Data);
}
u8 bandwidthselector_fir_enable_read(bandwidthselector *InstancePtr) {

    u8 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = bandwidthselector_ReadReg(InstancePtr->bandwidthselector_BaseAddress, 0);
    return Data;
}
void bandwidthselector_downsample_factor_write(bandwidthselector *InstancePtr, u32 Data) {

    Xil_AssertVoid(InstancePtr != NULL);

    bandwidthselector_WriteReg(InstancePtr->bandwidthselector_BaseAddress, 4, Data);
}
u32 bandwidthselector_downsample_factor_read(bandwidthselector *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = bandwidthselector_ReadReg(InstancePtr->bandwidthselector_BaseAddress, 4);
    return Data;
}
u32 bandwidthselector_event_missing_read(bandwidthselector *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = bandwidthselector_ReadReg(InstancePtr->bandwidthselector_BaseAddress, 8);
    return Data;
}
u32 bandwidthselector_event_unexpected_read(bandwidthselector *InstancePtr) {

    u32 Data;
    Xil_AssertVoid(InstancePtr != NULL);

    Data = bandwidthselector_ReadReg(InstancePtr->bandwidthselector_BaseAddress, 12);
    return Data;
}
