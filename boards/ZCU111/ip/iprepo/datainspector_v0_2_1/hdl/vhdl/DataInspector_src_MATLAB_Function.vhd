-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\dmareference\DataInspector_src_MATLAB_Function.vhd
-- Created: 2019-09-09 17:10:55
-- 
-- Generated by MATLAB 9.6 and HDL Coder 3.14
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: DataInspector_src_MATLAB_Function
-- Source Path: AXI_Data_Inspector/MATLAB Function
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY DataInspector_src_MATLAB_Function IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        tuser                             :   IN    std_logic;
        tlast                             :   IN    std_logic;
        transfer                          :   IN    std_logic;
        reset_1                           :   IN    std_logic;
        empty                             :   IN    std_logic;
        push                              :   OUT   std_logic;
        pop                               :   OUT   std_logic;
        tready                            :   OUT   std_logic
        );
END DataInspector_src_MATLAB_Function;


ARCHITECTURE rtl OF DataInspector_src_MATLAB_Function IS

  -- Signals
  SIGNAL debug_state                      : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL state                            : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL state_next                       : unsigned(1 DOWNTO 0);  -- ufix2

BEGIN
  MATLAB_Function_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      state <= to_unsigned(16#0#, 2);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        state <= state_next;
      END IF;
    END IF;
  END PROCESS MATLAB_Function_process;

  MATLAB_Function_output : PROCESS (empty, reset_1, state, tlast, transfer, tuser)
  BEGIN
    state_next <= state;
    CASE state IS
      WHEN "00" =>
        push <= '0';
        pop <= '0';
        tready <= '1';
        debug_state <= state;
        IF (tuser AND transfer) = '1' THEN 
          state_next <= to_unsigned(16#1#, 2);
        ELSE 
          state_next <= to_unsigned(16#0#, 2);
        END IF;
      WHEN "01" =>
        push <= '1';
        pop <= '1';
        tready <= '1';
        debug_state <= state;
        IF tlast = '1' THEN 
          state_next <= to_unsigned(16#2#, 2);
        ELSE 
          state_next <= to_unsigned(16#1#, 2);
        END IF;
      WHEN "10" =>
        push <= '1';
        pop <= '1';
        tready <= '0';
        debug_state <= state;
        state_next <= to_unsigned(16#3#, 2);
      WHEN "11" =>
        push <= '0';
        pop <= '1';
        tready <= '0';
        debug_state <= state;
        IF (reset_1 AND empty) = '1' THEN 
          state_next <= to_unsigned(16#0#, 2);
        ELSE 
          state_next <= to_unsigned(16#3#, 2);
        END IF;
      WHEN OTHERS => 
        push <= '0';
        pop <= '0';
        tready <= '0';
        debug_state <= state;
        state_next <= to_unsigned(16#0#, 2);
    END CASE;
  END PROCESS MATLAB_Function_output;


END rtl;
