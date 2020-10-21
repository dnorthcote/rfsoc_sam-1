-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\psd_db\psd_src_nfp_wire_single.vhd
-- Created: 2020-10-15 20:02:01
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: psd_src_nfp_wire_single
-- Source Path: psd_db/PSD Calculation/nfp_wire_single
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY psd_src_nfp_wire_single IS
  PORT( nfp_in                            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        nfp_out                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32
        );
END psd_src_nfp_wire_single;


ARCHITECTURE rtl OF psd_src_nfp_wire_single IS

BEGIN
  nfp_out <= nfp_in;

END rtl;

