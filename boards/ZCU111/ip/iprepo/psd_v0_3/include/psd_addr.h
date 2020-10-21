/*
 * File Name:         hdl_prj\ipcore\psd_v0_3\include\psd_addr.h
 * Description:       C Header File
 * Created:           2020-10-15 20:02:06
*/

#ifndef PSD_H_
#define PSD_H_

#define  IPCore_Reset_psd            0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_psd           0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Timestamp_psd        0x8  //contains unique IP timestamp (yymmddHHMM): 2010152002
#define  output_selection_Data_psd   0x100  //data register for Inport output_selection
#define  window_Data_psd             0x104  //data register for Inport window
#define  rbw_Data_psd                0x108  //data register for Inport rbw

#endif /* PSD_H_ */
