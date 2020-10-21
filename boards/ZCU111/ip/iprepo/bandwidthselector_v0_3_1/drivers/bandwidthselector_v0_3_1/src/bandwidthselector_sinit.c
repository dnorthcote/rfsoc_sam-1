/**
* @file bandwidthselector_sinit.c
*
* The implementation of the bandwidthselector driver's static initialzation
* functionality.
*
* @note
*
* None
*
*/
#ifndef __linux__
#include "xstatus.h"
#include "xparameters.h"
#include "bandwidthselector.h"
extern bandwidthselector_Config bandwidthselector_ConfigTable[];
/**
* Lookup the device configuration based on the unique device ID.  The table
* ConfigTable contains the configuration info for each device in the system.
*
* @param DeviceId is the device identifier to lookup.
*
* @return
*     - A pointer of data type bandwidthselector_Config which
*    points to the device configuration if DeviceID is found.
*    - NULL if DeviceID is not found.
*
* @note    None.
*
*/
bandwidthselector_Config *bandwidthselector_LookupConfig(u16 DeviceId) {
    bandwidthselector_Config *ConfigPtr = NULL;
    int Index;
    for (Index = 0; Index < XPAR_BANDWIDTHSELECTOR_NUM_INSTANCES; Index++) {
        if (bandwidthselector_ConfigTable[Index].DeviceId == DeviceId) {
            ConfigPtr = &bandwidthselector_ConfigTable[Index];
            break;
        }
    }
    return ConfigPtr;
}
int bandwidthselector_Initialize(bandwidthselector *InstancePtr, u16 DeviceId) {
    bandwidthselector_Config *ConfigPtr;
    Xil_AssertNonvoid(InstancePtr != NULL);
    ConfigPtr = bandwidthselector_LookupConfig(DeviceId);
    if (ConfigPtr == NULL) {
        InstancePtr->IsReady = 0;
        return (XST_DEVICE_NOT_FOUND);
    }
    return bandwidthselector_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif
