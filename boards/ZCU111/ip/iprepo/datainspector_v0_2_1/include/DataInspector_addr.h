/*
 * File Name:         hdl_prj\ipcore\DataInspector_v0_2\include\DataInspector_addr.h
 * Description:       C Header File
 * Created:           2019-09-09 17:10:59
*/

#ifndef DATAINSPECTOR_H_
#define DATAINSPECTOR_H_

#define  IPCore_Reset_DataInspector       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_DataInspector      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_DataInspector   0x8  //contains unique IP timestamp (yymmddHHMM): 1909091710
#define  Transfer_Data_DataInspector      0x100  //data register for Inport Transfer
#define  Reset_Data_DataInspector         0x104  //data register for Inport Reset

#endif /* DATAINSPECTOR_H_ */
