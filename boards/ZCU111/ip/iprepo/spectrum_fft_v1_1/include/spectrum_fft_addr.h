/*
 * File Name:         hdl_prj\ipcore\spectrum_fft_v1_1\include\spectrum_fft_addr.h
 * Description:       C Header File
 * Created:           2020-10-15 22:09:53
*/

#ifndef SPECTRUM_FFT_H_
#define SPECTRUM_FFT_H_

#define  IPCore_Reset_spectrum_fft       0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Timestamp_spectrum_fft   0x8  //contains unique IP timestamp (yymmddHHMM): 2010152209
#define  reset_Data_spectrum_fft         0x100  //data register for Inport reset

#endif /* SPECTRUM_FFT_H_ */
