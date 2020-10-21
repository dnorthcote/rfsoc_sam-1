/*
 * File Name:         hdl_prj\ipcore\frequency_synth_v1_0\include\frequency_synth_addr.h
 * Description:       C Header File
 * Created:           2020-10-19 10:03:37
*/

#ifndef FREQUENCY_SYNTH_H_
#define FREQUENCY_SYNTH_H_

#define  IPCore_Reset_frequency_synth                              0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_frequency_synth                             0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_PacketSize_AXI4_Stream_F0_Master_frequency_synth   0x8  //Packet size for AXI4-Stream F0 Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream F0 Master interface is generated based on the packet size.
#define  IPCore_PacketSize_AXI4_Stream_F1_Master_frequency_synth   0xC  //Packet size for AXI4-Stream F1 Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream F1 Master interface is generated based on the packet size.
#define  IPCore_PacketSize_AXI4_Stream_F2_Master_frequency_synth   0x10  //Packet size for AXI4-Stream F2 Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream F2 Master interface is generated based on the packet size.
#define  IPCore_PacketSize_AXI4_Stream_F3_Master_frequency_synth   0x14  //Packet size for AXI4-Stream F3 Master interface, the default value is 1024. The TLAST output signal of the AXI4-Stream F3 Master interface is generated based on the packet size.
#define  IPCore_Timestamp_frequency_synth                          0x18  //contains unique IP timestamp (yymmddHHMM): 2010191003
#define  Constant_Data_frequency_synth                             0x100  //data register for Inport Constant
#define  Enable_NCO_0_Data_frequency_synth                         0x104  //data register for Inport Enable NCO 0
#define  Enable_NCO_1_Data_frequency_synth                         0x108  //data register for Inport Enable NCO 1
#define  Enable_NCO_2_Data_frequency_synth                         0x10C  //data register for Inport Enable NCO 2
#define  Enable_NCO_3_Data_frequency_synth                         0x110  //data register for Inport Enable NCO 3
#define  Gain_NCO_0_Data_frequency_synth                           0x114  //data register for Inport Gain NCO 0
#define  Gain_NCO_1_Data_frequency_synth                           0x118  //data register for Inport Gain NCO 1
#define  Gain_NCO_2_Data_frequency_synth                           0x11C  //data register for Inport Gain NCO 2
#define  Gain_NCO_3_Data_frequency_synth                           0x120  //data register for Inport Gain NCO 3
#define  Step_Size_0_Data_frequency_synth                          0x124  //data register for Inport Step Size 0
#define  Step_Size_1_Data_frequency_synth                          0x128  //data register for Inport Step Size 1
#define  Step_Size_2_Data_frequency_synth                          0x12C  //data register for Inport Step Size 2
#define  Step_Size_3_Data_frequency_synth                          0x130  //data register for Inport Step Size 3

#endif /* FREQUENCY_SYNTH_H_ */
