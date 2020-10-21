/*
 * File Name:         hdl_prj\ipcore\window_v1_0\include\window_addr.h
 * Description:       C Header File
 * Created:           2020-10-19 10:59:06
*/

#ifndef WINDOW_H_
#define WINDOW_H_

#define  IPCore_Reset_window       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_window      0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_window   0x8  //contains unique IP timestamp (yymmddHHMM): 2010191059
#define  enable_Data_window        0x100  //data register for Inport enable

#endif /* WINDOW_H_ */
