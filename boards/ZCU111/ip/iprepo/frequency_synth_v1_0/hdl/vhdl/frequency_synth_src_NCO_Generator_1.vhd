-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\frequency_synth\frequency_synth_src_NCO_Generator_1.vhd
-- Created: 2020-10-19 10:03:31
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: frequency_synth_src_NCO_Generator_1
-- Source Path: frequency_synth/Frequency Synthesis/NCO Generator 1
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.frequency_synth_src_Frequency_Synthesis_pkg.ALL;

ENTITY frequency_synth_src_NCO_Generator_1 IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        Step_Size                         :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
        Enable                            :   IN    std_logic;
        Valid_Out                         :   OUT   std_logic;
        Signal_re                         :   OUT   vector_of_std_logic_vector16(0 TO 3);  -- sfix16_En15 [4]
        Signal_im                         :   OUT   vector_of_std_logic_vector16(0 TO 3)  -- sfix16_En15 [4]
        );
END frequency_synth_src_NCO_Generator_1;


ARCHITECTURE rtl OF frequency_synth_src_NCO_Generator_1 IS

  -- Component Declarations
  COMPONENT frequency_synth_src_NCO_HDL_Optimized_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          inc                             :   IN    std_logic_vector(31 DOWNTO 0);  -- uint32
          validIn                         :   IN    std_logic;
          sine                            :   OUT   vector_of_std_logic_vector16(0 TO 3);  -- sfix16_En15 [4]
          cosine                          :   OUT   vector_of_std_logic_vector16(0 TO 3);  -- sfix16_En15 [4]
          validOut                        :   OUT   std_logic
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : frequency_synth_src_NCO_HDL_Optimized_block
    USE ENTITY work.frequency_synth_src_NCO_HDL_Optimized_block(rtl);

  -- Signals
  SIGNAL Constant_out1                    : std_logic;
  SIGNAL NCO_HDL_Optimized_out1           : vector_of_std_logic_vector16(0 TO 3);  -- ufix16 [4]
  SIGNAL NCO_HDL_Optimized_out2           : vector_of_std_logic_vector16(0 TO 3);  -- ufix16 [4]
  SIGNAL NCO_HDL_Optimized_out3           : std_logic;
  SIGNAL AND_out1                         : std_logic;

BEGIN
  u_NCO_HDL_Optimized : frequency_synth_src_NCO_HDL_Optimized_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              inc => Step_Size,  -- uint32
              validIn => Constant_out1,
              sine => NCO_HDL_Optimized_out1,  -- sfix16_En15 [4]
              cosine => NCO_HDL_Optimized_out2,  -- sfix16_En15 [4]
              validOut => NCO_HDL_Optimized_out3
              );

  Constant_out1 <= '1';

  AND_out1 <= NCO_HDL_Optimized_out3 AND Enable;

  Valid_Out <= AND_out1;

  Signal_re <= NCO_HDL_Optimized_out2;

  Signal_im <= NCO_HDL_Optimized_out1;

END rtl;

