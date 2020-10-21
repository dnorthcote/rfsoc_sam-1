-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simple_window\window_axi4_stream_real_slave.vhd
-- Created: 2020-10-19 10:59:06
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: window_axi4_stream_real_slave
-- Source Path: window/window_axi4_stream_real_slave
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY window_axi4_stream_real_slave IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        AXI4_Stream_Real_Slave_TDATA      :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Stream_Real_Slave_TVALID     :   IN    std_logic;  -- ufix1
        AXI4_Stream_Real_Slave_TREADY     :   OUT   std_logic;  -- ufix1
        user_data                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- ufix16
        user_valid                        :   OUT   std_logic  -- ufix1
        );
END window_axi4_stream_real_slave;


ARCHITECTURE rtl OF window_axi4_stream_real_slave IS

  -- Component Declarations
  COMPONENT window_fifo_data_block
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          In_rsvd                         :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          Push                            :   IN    std_logic;  -- ufix1
          Pop                             :   IN    std_logic;  -- ufix1
          Out_rsvd                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- ufix16
          Empty                           :   OUT   std_logic;  -- ufix1
          Full                            :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : window_fifo_data_block
    USE ENTITY work.window_fifo_data_block(rtl);

  -- Signals
  SIGNAL const_1                          : std_logic;  -- ufix1
  SIGNAL fifo_rd_ack                      : std_logic;  -- ufix1
  SIGNAL stream_in_user_data              : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_empty                       : std_logic;  -- ufix1
  SIGNAL fifo_full                        : std_logic;  -- ufix1
  SIGNAL fifo_empty_neg                   : std_logic;  -- ufix1
  SIGNAL stream_in_user_valid             : std_logic;  -- ufix1

BEGIN
  u_window_fifo_data_inst : window_fifo_data_block
    PORT MAP( clk => clk,
              reset => reset,
              enb => enb,
              In_rsvd => AXI4_Stream_Real_Slave_TDATA,  -- ufix16
              Push => AXI4_Stream_Real_Slave_TVALID,  -- ufix1
              Pop => fifo_rd_ack,  -- ufix1
              Out_rsvd => stream_in_user_data,  -- ufix16
              Empty => fifo_empty,  -- ufix1
              Full => fifo_full  -- ufix1
              );

  const_1 <= '1';

  intdelay_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fifo_rd_ack <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        fifo_rd_ack <= const_1;
      END IF;
    END IF;
  END PROCESS intdelay_process;


  AXI4_Stream_Real_Slave_TREADY <=  NOT fifo_full;

  fifo_empty_neg <=  NOT fifo_empty;

  stream_in_user_valid <= fifo_empty_neg AND fifo_rd_ack;

  user_data <= stream_in_user_data;

  user_valid <= stream_in_user_valid;

END rtl;

