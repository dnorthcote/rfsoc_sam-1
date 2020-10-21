#ifndef BANDWIDTHSELECTOR__H
#define BANDWIDTHSELECTOR__H
#ifdef __cplusplus
extern "C" {
#endif
/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "bandwidthselector_hw.h"
/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
#else
typedef struct {
    u16 DeviceId;
    u32 bandwidthselector_BaseAddress;
} bandwidthselector_Config;
#endif
/**
* The bandwidthselector driver instance data. The user is required to
* allocate a variable of this type for every bandwidthselector device in the system.
* A pointer to a variable of this type is then passed to the driver
* API functions.
*/
typedef struct {
    u32 bandwidthselector_BaseAddress;
    u32 IsReady;
} bandwidthselector;
/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define bandwidthselector_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define bandwidthselector_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define bandwidthselector_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define bandwidthselector_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif
/************************** Function Prototypes *****************************/
#ifndef __linux__
int bandwidthselector_Initialize(bandwidthselector *InstancePtr, u16 DeviceId);
bandwidthselector_Config* bandwidthselector_LookupConfig(u16 DeviceId);
int bandwidthselector_CfgInitialize(bandwidthselector *InstancePtr, bandwidthselector_Config *ConfigPtr);
#else
int bandwidthselector_Initialize(bandwidthselector *InstancePtr, const char* InstanceName);
int bandwidthselector_Release(bandwidthselector *InstancePtr);
#endif
/**
* Write to fir_enable gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the fir_enable instance to operate on.
* @param	Data is value to be written to gateway fir_enable.
*
* @return	None.
*
* @note    .
*
*/
void bandwidthselector_fir_enable_write(bandwidthselector *InstancePtr, u8 Data);
/**
* Read from fir_enable gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the fir_enable instance to operate on.
*
* @return	u8
*
* @note    .
*
*/
u8 bandwidthselector_fir_enable_read(bandwidthselector *InstancePtr);
/**
* Write to downsample_factor gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the downsample_factor instance to operate on.
* @param	Data is value to be written to gateway downsample_factor.
*
* @return	None.
*
* @note    .
*
*/
void bandwidthselector_downsample_factor_write(bandwidthselector *InstancePtr, u32 Data);
/**
* Read from downsample_factor gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the downsample_factor instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 bandwidthselector_downsample_factor_read(bandwidthselector *InstancePtr);
/**
* Read from event_missing gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the event_missing instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 bandwidthselector_event_missing_read(bandwidthselector *InstancePtr);
/**
* Read from event_unexpected gateway of bandwidthselector. Assignments are LSB-justified.
*
* @param	InstancePtr is the event_unexpected instance to operate on.
*
* @return	u32
*
* @note    .
*
*/
u32 bandwidthselector_event_unexpected_read(bandwidthselector *InstancePtr);
#ifdef __cplusplus
}
#endif
#endif
