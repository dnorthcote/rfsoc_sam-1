-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\psd_db\psd_src_PSD_Calculation_pkg.vhd
-- Created: 2020-10-15 20:02:01
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE psd_src_PSD_Calculation_pkg IS
  TYPE vector_of_signed11 IS ARRAY (NATURAL RANGE <>) OF signed(10 DOWNTO 0);
  TYPE vector_of_signed35 IS ARRAY (NATURAL RANGE <>) OF signed(34 DOWNTO 0);
  TYPE vector_of_signed50 IS ARRAY (NATURAL RANGE <>) OF signed(49 DOWNTO 0);
  TYPE vector_of_unsigned27 IS ARRAY (NATURAL RANGE <>) OF unsigned(26 DOWNTO 0);
  TYPE vector_of_signed8 IS ARRAY (NATURAL RANGE <>) OF signed(7 DOWNTO 0);
  TYPE vector_of_unsigned8 IS ARRAY (NATURAL RANGE <>) OF unsigned(7 DOWNTO 0);
  TYPE vector_of_unsigned23 IS ARRAY (NATURAL RANGE <>) OF unsigned(22 DOWNTO 0);
  TYPE vector_of_unsigned42 IS ARRAY (NATURAL RANGE <>) OF unsigned(41 DOWNTO 0);
  TYPE vector_of_unsigned26 IS ARRAY (NATURAL RANGE <>) OF unsigned(25 DOWNTO 0);
  TYPE vector_of_signed10 IS ARRAY (NATURAL RANGE <>) OF signed(9 DOWNTO 0);
  TYPE vector_of_std_logic_vector32 IS ARRAY (NATURAL RANGE <>) OF std_logic_vector(31 DOWNTO 0);
END psd_src_PSD_Calculation_pkg;

