-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\frequency_synth\frequency_synth_addr_decoder.vhd
-- Created: 2020-10-19 10:03:37
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: frequency_synth_addr_decoder
-- Source Path: frequency_synth/frequency_synth_axi_lite/frequency_synth_addr_decoder
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY frequency_synth_addr_decoder IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        data_write                        :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        addr_sel                          :   IN    std_logic_vector(13 DOWNTO 0);  -- ufix14
        wr_enb                            :   IN    std_logic;  -- ufix1
        rd_enb                            :   IN    std_logic;  -- ufix1
        read_ip_timestamp                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        data_read                         :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_axi_enable                  :   OUT   std_logic;  -- ufix1
        write_packet_size_axi4_stream_f0_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_packet_size_axi4_stream_f1_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_packet_size_axi4_stream_f2_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_packet_size_axi4_stream_f3_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_Constant                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_Enable_NCO_0                :   OUT   std_logic;  -- ufix1
        write_Enable_NCO_1                :   OUT   std_logic;  -- ufix1
        write_Enable_NCO_2                :   OUT   std_logic;  -- ufix1
        write_Enable_NCO_3                :   OUT   std_logic;  -- ufix1
        write_Gain_NCO_0                  :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        write_Gain_NCO_1                  :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        write_Gain_NCO_2                  :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        write_Gain_NCO_3                  :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
        write_Step_Size_0                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_Step_Size_1                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_Step_Size_2                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        write_Step_Size_3                 :   OUT   std_logic_vector(31 DOWNTO 0)  -- ufix32
        );
END frequency_synth_addr_decoder;


ARCHITECTURE rtl OF frequency_synth_addr_decoder IS

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL addr_sel_unsigned                : unsigned(13 DOWNTO 0);  -- ufix14
  SIGNAL decode_sel_Step_Size_3_1_1       : std_logic;  -- ufix1
  SIGNAL decode_sel_Step_Size_2_1_1       : std_logic;  -- ufix1
  SIGNAL decode_sel_Step_Size_1_1_1       : std_logic;  -- ufix1
  SIGNAL decode_sel_Step_Size_0_1_1       : std_logic;  -- ufix1
  SIGNAL decode_sel_Gain_NCO_3_1_1        : std_logic;  -- ufix1
  SIGNAL decode_sel_Gain_NCO_2_1_1        : std_logic;  -- ufix1
  SIGNAL decode_sel_Gain_NCO_1_1_1        : std_logic;  -- ufix1
  SIGNAL decode_sel_Gain_NCO_0_1_1        : std_logic;  -- ufix1
  SIGNAL decode_sel_Enable_NCO_3_1_1      : std_logic;  -- ufix1
  SIGNAL decode_sel_Enable_NCO_2_1_1      : std_logic;  -- ufix1
  SIGNAL decode_sel_Enable_NCO_1_1_1      : std_logic;  -- ufix1
  SIGNAL decode_sel_Enable_NCO_0_1_1      : std_logic;  -- ufix1
  SIGNAL decode_sel_Constant_1_1          : std_logic;  -- ufix1
  SIGNAL decode_sel_ip_timestamp_1_1      : std_logic;  -- ufix1
  SIGNAL decode_sel_packet_size_axi4_stream_f3_master_1_1 : std_logic;  -- ufix1
  SIGNAL decode_sel_packet_size_axi4_stream_f2_master_1_1 : std_logic;  -- ufix1
  SIGNAL decode_sel_packet_size_axi4_stream_f1_master_1_1 : std_logic;  -- ufix1
  SIGNAL decode_sel_packet_size_axi4_stream_f0_master_1_1 : std_logic;  -- ufix1
  SIGNAL decode_sel_axi_enable_1_1        : std_logic;  -- ufix1
  SIGNAL const_0                          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_axi_enable_1_1           : std_logic;  -- ufix1
  SIGNAL data_write_unsigned              : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL data_in_axi_enable               : std_logic;  -- ufix1
  SIGNAL const_1_1                        : std_logic;  -- ufix1
  SIGNAL data_reg_axi_enable_1_1          : std_logic;  -- ufix1
  SIGNAL write_concats_axi_enable_1       : std_logic;  -- ufix1
  SIGNAL data_slice_axi_enable_1          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_axi_enable_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_packet_size_axi4_stream_f0_master_1_1 : std_logic;  -- ufix1
  SIGNAL data_reg_packet_size_axi4_stream_f0_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packet_size_axi4_stream_f0_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_packet_size_axi4_stream_f1_master_1_1 : std_logic;  -- ufix1
  SIGNAL data_reg_packet_size_axi4_stream_f1_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packet_size_axi4_stream_f1_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_packet_size_axi4_stream_f2_master_1_1 : std_logic;  -- ufix1
  SIGNAL data_reg_packet_size_axi4_stream_f2_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packet_size_axi4_stream_f2_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_packet_size_axi4_stream_f3_master_1_1 : std_logic;  -- ufix1
  SIGNAL data_reg_packet_size_axi4_stream_f3_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_ip_timestamp_unsigned       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_packet_size_axi4_stream_f3_master_1_1 : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL read_reg_ip_timestamp            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_ip_timestamp_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Constant_1_1             : std_logic;  -- ufix1
  SIGNAL data_reg_Constant_1_1            : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Constant_1_1           : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Enable_NCO_0_1_1         : std_logic;  -- ufix1
  SIGNAL data_in_Enable_NCO_0             : std_logic;  -- ufix1
  SIGNAL data_reg_Enable_NCO_0_1_1        : std_logic;  -- ufix1
  SIGNAL write_concats_Enable_NCO_0_1     : std_logic;  -- ufix1
  SIGNAL data_slice_Enable_NCO_0_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Enable_NCO_0_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Enable_NCO_1_1_1         : std_logic;  -- ufix1
  SIGNAL data_in_Enable_NCO_1             : std_logic;  -- ufix1
  SIGNAL data_reg_Enable_NCO_1_1_1        : std_logic;  -- ufix1
  SIGNAL write_concats_Enable_NCO_1_1     : std_logic;  -- ufix1
  SIGNAL data_slice_Enable_NCO_1_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Enable_NCO_1_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Enable_NCO_2_1_1         : std_logic;  -- ufix1
  SIGNAL data_in_Enable_NCO_2             : std_logic;  -- ufix1
  SIGNAL data_reg_Enable_NCO_2_1_1        : std_logic;  -- ufix1
  SIGNAL write_concats_Enable_NCO_2_1     : std_logic;  -- ufix1
  SIGNAL data_slice_Enable_NCO_2_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Enable_NCO_2_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Enable_NCO_3_1_1         : std_logic;  -- ufix1
  SIGNAL data_in_Enable_NCO_3             : std_logic;  -- ufix1
  SIGNAL data_reg_Enable_NCO_3_1_1        : std_logic;  -- ufix1
  SIGNAL write_concats_Enable_NCO_3_1     : std_logic;  -- ufix1
  SIGNAL data_slice_Enable_NCO_3_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Enable_NCO_3_1_1       : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Gain_NCO_0_1_1           : std_logic;  -- ufix1
  SIGNAL data_in_Gain_NCO_0               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_reg_Gain_NCO_0_1_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_slice_Gain_NCO_0_1          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Gain_NCO_0_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Gain_NCO_1_1_1           : std_logic;  -- ufix1
  SIGNAL data_in_Gain_NCO_1               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_reg_Gain_NCO_1_1_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_slice_Gain_NCO_1_1          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Gain_NCO_1_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Gain_NCO_2_1_1           : std_logic;  -- ufix1
  SIGNAL data_in_Gain_NCO_2               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_reg_Gain_NCO_2_1_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_slice_Gain_NCO_2_1          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Gain_NCO_2_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Gain_NCO_3_1_1           : std_logic;  -- ufix1
  SIGNAL data_in_Gain_NCO_3               : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_reg_Gain_NCO_3_1_1          : signed(15 DOWNTO 0);  -- sfix16_En14
  SIGNAL data_slice_Gain_NCO_3_1          : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Gain_NCO_3_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Step_Size_0_1_1          : std_logic;  -- ufix1
  SIGNAL data_reg_Step_Size_0_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Step_Size_0_1_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Step_Size_1_1_1          : std_logic;  -- ufix1
  SIGNAL data_reg_Step_Size_1_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Step_Size_1_1_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Step_Size_2_1_1          : std_logic;  -- ufix1
  SIGNAL data_reg_Step_Size_2_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Step_Size_2_1_1        : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reg_enb_Step_Size_3_1_1          : std_logic;  -- ufix1
  SIGNAL data_reg_Step_Size_3_1_1         : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL decode_rd_Step_Size_3_1_1        : unsigned(31 DOWNTO 0);  -- ufix32

BEGIN
  addr_sel_unsigned <= unsigned(addr_sel);

  
  decode_sel_Step_Size_3_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#004C#, 14) ELSE
      '0';

  
  decode_sel_Step_Size_2_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#004B#, 14) ELSE
      '0';

  
  decode_sel_Step_Size_1_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#004A#, 14) ELSE
      '0';

  
  decode_sel_Step_Size_0_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0049#, 14) ELSE
      '0';

  
  decode_sel_Gain_NCO_3_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0048#, 14) ELSE
      '0';

  
  decode_sel_Gain_NCO_2_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0047#, 14) ELSE
      '0';

  
  decode_sel_Gain_NCO_1_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0046#, 14) ELSE
      '0';

  
  decode_sel_Gain_NCO_0_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0045#, 14) ELSE
      '0';

  
  decode_sel_Enable_NCO_3_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0044#, 14) ELSE
      '0';

  
  decode_sel_Enable_NCO_2_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0043#, 14) ELSE
      '0';

  
  decode_sel_Enable_NCO_1_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0042#, 14) ELSE
      '0';

  
  decode_sel_Enable_NCO_0_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0041#, 14) ELSE
      '0';

  
  decode_sel_Constant_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0040#, 14) ELSE
      '0';

  
  decode_sel_ip_timestamp_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0006#, 14) ELSE
      '0';

  
  decode_sel_packet_size_axi4_stream_f3_master_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0005#, 14) ELSE
      '0';

  
  decode_sel_packet_size_axi4_stream_f2_master_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0004#, 14) ELSE
      '0';

  
  decode_sel_packet_size_axi4_stream_f1_master_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0003#, 14) ELSE
      '0';

  
  decode_sel_packet_size_axi4_stream_f0_master_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0002#, 14) ELSE
      '0';

  
  decode_sel_axi_enable_1_1 <= '1' WHEN addr_sel_unsigned = to_unsigned(16#0001#, 14) ELSE
      '0';

  const_0 <= to_unsigned(0, 32);

  reg_enb_axi_enable_1_1 <= decode_sel_axi_enable_1_1 AND wr_enb;

  data_write_unsigned <= unsigned(data_write);

  data_in_axi_enable <= data_write_unsigned(0);

  const_1_1 <= '1';

  enb <= const_1_1;

  reg_axi_enable_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_axi_enable_1_1 <= '1';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_axi_enable_1_1 = '1' THEN
        data_reg_axi_enable_1_1 <= data_in_axi_enable;
      END IF;
    END IF;
  END PROCESS reg_axi_enable_1_1_process;


  write_concats_axi_enable_1 <= data_reg_axi_enable_1_1;

  data_slice_axi_enable_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & write_concats_axi_enable_1;

  
  decode_rd_axi_enable_1_1 <= const_0 WHEN decode_sel_axi_enable_1_1 = '0' ELSE
      data_slice_axi_enable_1;

  reg_enb_packet_size_axi4_stream_f0_master_1_1 <= decode_sel_packet_size_axi4_stream_f0_master_1_1 AND wr_enb;

  reg_packet_size_axi4_stream_f0_master_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_packet_size_axi4_stream_f0_master_1_1 <= to_unsigned(1024, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_packet_size_axi4_stream_f0_master_1_1 = '1' THEN
        data_reg_packet_size_axi4_stream_f0_master_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packet_size_axi4_stream_f0_master_1_1_process;


  
  decode_rd_packet_size_axi4_stream_f0_master_1_1 <= decode_rd_axi_enable_1_1 WHEN decode_sel_packet_size_axi4_stream_f0_master_1_1 = '0' ELSE
      data_reg_packet_size_axi4_stream_f0_master_1_1;

  reg_enb_packet_size_axi4_stream_f1_master_1_1 <= decode_sel_packet_size_axi4_stream_f1_master_1_1 AND wr_enb;

  reg_packet_size_axi4_stream_f1_master_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_packet_size_axi4_stream_f1_master_1_1 <= to_unsigned(1024, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_packet_size_axi4_stream_f1_master_1_1 = '1' THEN
        data_reg_packet_size_axi4_stream_f1_master_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packet_size_axi4_stream_f1_master_1_1_process;


  
  decode_rd_packet_size_axi4_stream_f1_master_1_1 <= decode_rd_packet_size_axi4_stream_f0_master_1_1 WHEN decode_sel_packet_size_axi4_stream_f1_master_1_1 = '0' ELSE
      data_reg_packet_size_axi4_stream_f1_master_1_1;

  reg_enb_packet_size_axi4_stream_f2_master_1_1 <= decode_sel_packet_size_axi4_stream_f2_master_1_1 AND wr_enb;

  reg_packet_size_axi4_stream_f2_master_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_packet_size_axi4_stream_f2_master_1_1 <= to_unsigned(1024, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_packet_size_axi4_stream_f2_master_1_1 = '1' THEN
        data_reg_packet_size_axi4_stream_f2_master_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packet_size_axi4_stream_f2_master_1_1_process;


  
  decode_rd_packet_size_axi4_stream_f2_master_1_1 <= decode_rd_packet_size_axi4_stream_f1_master_1_1 WHEN decode_sel_packet_size_axi4_stream_f2_master_1_1 = '0' ELSE
      data_reg_packet_size_axi4_stream_f2_master_1_1;

  reg_enb_packet_size_axi4_stream_f3_master_1_1 <= decode_sel_packet_size_axi4_stream_f3_master_1_1 AND wr_enb;

  reg_packet_size_axi4_stream_f3_master_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_packet_size_axi4_stream_f3_master_1_1 <= to_unsigned(1024, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_packet_size_axi4_stream_f3_master_1_1 = '1' THEN
        data_reg_packet_size_axi4_stream_f3_master_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_packet_size_axi4_stream_f3_master_1_1_process;


  read_ip_timestamp_unsigned <= unsigned(read_ip_timestamp);

  
  decode_rd_packet_size_axi4_stream_f3_master_1_1 <= decode_rd_packet_size_axi4_stream_f2_master_1_1 WHEN decode_sel_packet_size_axi4_stream_f3_master_1_1 = '0' ELSE
      data_reg_packet_size_axi4_stream_f3_master_1_1;

  reg_ip_timestamp_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      read_reg_ip_timestamp <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        read_reg_ip_timestamp <= read_ip_timestamp_unsigned;
      END IF;
    END IF;
  END PROCESS reg_ip_timestamp_process;


  
  decode_rd_ip_timestamp_1_1 <= decode_rd_packet_size_axi4_stream_f3_master_1_1 WHEN decode_sel_ip_timestamp_1_1 = '0' ELSE
      read_reg_ip_timestamp;

  reg_enb_Constant_1_1 <= decode_sel_Constant_1_1 AND wr_enb;

  reg_Constant_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Constant_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Constant_1_1 = '1' THEN
        data_reg_Constant_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_Constant_1_1_process;


  
  decode_rd_Constant_1_1 <= decode_rd_ip_timestamp_1_1 WHEN decode_sel_Constant_1_1 = '0' ELSE
      data_reg_Constant_1_1;

  reg_enb_Enable_NCO_0_1_1 <= decode_sel_Enable_NCO_0_1_1 AND wr_enb;

  data_in_Enable_NCO_0 <= data_write_unsigned(0);

  reg_Enable_NCO_0_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Enable_NCO_0_1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Enable_NCO_0_1_1 = '1' THEN
        data_reg_Enable_NCO_0_1_1 <= data_in_Enable_NCO_0;
      END IF;
    END IF;
  END PROCESS reg_Enable_NCO_0_1_1_process;


  write_concats_Enable_NCO_0_1 <= data_reg_Enable_NCO_0_1_1;

  data_slice_Enable_NCO_0_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & write_concats_Enable_NCO_0_1;

  
  decode_rd_Enable_NCO_0_1_1 <= decode_rd_Constant_1_1 WHEN decode_sel_Enable_NCO_0_1_1 = '0' ELSE
      data_slice_Enable_NCO_0_1;

  reg_enb_Enable_NCO_1_1_1 <= decode_sel_Enable_NCO_1_1_1 AND wr_enb;

  data_in_Enable_NCO_1 <= data_write_unsigned(0);

  reg_Enable_NCO_1_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Enable_NCO_1_1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Enable_NCO_1_1_1 = '1' THEN
        data_reg_Enable_NCO_1_1_1 <= data_in_Enable_NCO_1;
      END IF;
    END IF;
  END PROCESS reg_Enable_NCO_1_1_1_process;


  write_concats_Enable_NCO_1_1 <= data_reg_Enable_NCO_1_1_1;

  data_slice_Enable_NCO_1_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & write_concats_Enable_NCO_1_1;

  
  decode_rd_Enable_NCO_1_1_1 <= decode_rd_Enable_NCO_0_1_1 WHEN decode_sel_Enable_NCO_1_1_1 = '0' ELSE
      data_slice_Enable_NCO_1_1;

  reg_enb_Enable_NCO_2_1_1 <= decode_sel_Enable_NCO_2_1_1 AND wr_enb;

  data_in_Enable_NCO_2 <= data_write_unsigned(0);

  reg_Enable_NCO_2_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Enable_NCO_2_1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Enable_NCO_2_1_1 = '1' THEN
        data_reg_Enable_NCO_2_1_1 <= data_in_Enable_NCO_2;
      END IF;
    END IF;
  END PROCESS reg_Enable_NCO_2_1_1_process;


  write_concats_Enable_NCO_2_1 <= data_reg_Enable_NCO_2_1_1;

  data_slice_Enable_NCO_2_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & write_concats_Enable_NCO_2_1;

  
  decode_rd_Enable_NCO_2_1_1 <= decode_rd_Enable_NCO_1_1_1 WHEN decode_sel_Enable_NCO_2_1_1 = '0' ELSE
      data_slice_Enable_NCO_2_1;

  reg_enb_Enable_NCO_3_1_1 <= decode_sel_Enable_NCO_3_1_1 AND wr_enb;

  data_in_Enable_NCO_3 <= data_write_unsigned(0);

  reg_Enable_NCO_3_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Enable_NCO_3_1_1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Enable_NCO_3_1_1 = '1' THEN
        data_reg_Enable_NCO_3_1_1 <= data_in_Enable_NCO_3;
      END IF;
    END IF;
  END PROCESS reg_Enable_NCO_3_1_1_process;


  write_concats_Enable_NCO_3_1 <= data_reg_Enable_NCO_3_1_1;

  data_slice_Enable_NCO_3_1 <= '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & write_concats_Enable_NCO_3_1;

  
  decode_rd_Enable_NCO_3_1_1 <= decode_rd_Enable_NCO_2_1_1 WHEN decode_sel_Enable_NCO_3_1_1 = '0' ELSE
      data_slice_Enable_NCO_3_1;

  reg_enb_Gain_NCO_0_1_1 <= decode_sel_Gain_NCO_0_1_1 AND wr_enb;

  data_in_Gain_NCO_0 <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_Gain_NCO_0_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Gain_NCO_0_1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Gain_NCO_0_1_1 = '1' THEN
        data_reg_Gain_NCO_0_1_1 <= data_in_Gain_NCO_0;
      END IF;
    END IF;
  END PROCESS reg_Gain_NCO_0_1_1_process;


  data_slice_Gain_NCO_0_1 <= unsigned(resize(data_reg_Gain_NCO_0_1_1, 32));

  
  decode_rd_Gain_NCO_0_1_1 <= decode_rd_Enable_NCO_3_1_1 WHEN decode_sel_Gain_NCO_0_1_1 = '0' ELSE
      data_slice_Gain_NCO_0_1;

  reg_enb_Gain_NCO_1_1_1 <= decode_sel_Gain_NCO_1_1_1 AND wr_enb;

  data_in_Gain_NCO_1 <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_Gain_NCO_1_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Gain_NCO_1_1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Gain_NCO_1_1_1 = '1' THEN
        data_reg_Gain_NCO_1_1_1 <= data_in_Gain_NCO_1;
      END IF;
    END IF;
  END PROCESS reg_Gain_NCO_1_1_1_process;


  data_slice_Gain_NCO_1_1 <= unsigned(resize(data_reg_Gain_NCO_1_1_1, 32));

  
  decode_rd_Gain_NCO_1_1_1 <= decode_rd_Gain_NCO_0_1_1 WHEN decode_sel_Gain_NCO_1_1_1 = '0' ELSE
      data_slice_Gain_NCO_1_1;

  reg_enb_Gain_NCO_2_1_1 <= decode_sel_Gain_NCO_2_1_1 AND wr_enb;

  data_in_Gain_NCO_2 <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_Gain_NCO_2_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Gain_NCO_2_1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Gain_NCO_2_1_1 = '1' THEN
        data_reg_Gain_NCO_2_1_1 <= data_in_Gain_NCO_2;
      END IF;
    END IF;
  END PROCESS reg_Gain_NCO_2_1_1_process;


  data_slice_Gain_NCO_2_1 <= unsigned(resize(data_reg_Gain_NCO_2_1_1, 32));

  
  decode_rd_Gain_NCO_2_1_1 <= decode_rd_Gain_NCO_1_1_1 WHEN decode_sel_Gain_NCO_2_1_1 = '0' ELSE
      data_slice_Gain_NCO_2_1;

  reg_enb_Gain_NCO_3_1_1 <= decode_sel_Gain_NCO_3_1_1 AND wr_enb;

  data_in_Gain_NCO_3 <= signed(data_write_unsigned(15 DOWNTO 0));

  reg_Gain_NCO_3_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Gain_NCO_3_1_1 <= to_signed(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Gain_NCO_3_1_1 = '1' THEN
        data_reg_Gain_NCO_3_1_1 <= data_in_Gain_NCO_3;
      END IF;
    END IF;
  END PROCESS reg_Gain_NCO_3_1_1_process;


  data_slice_Gain_NCO_3_1 <= unsigned(resize(data_reg_Gain_NCO_3_1_1, 32));

  
  decode_rd_Gain_NCO_3_1_1 <= decode_rd_Gain_NCO_2_1_1 WHEN decode_sel_Gain_NCO_3_1_1 = '0' ELSE
      data_slice_Gain_NCO_3_1;

  reg_enb_Step_Size_0_1_1 <= decode_sel_Step_Size_0_1_1 AND wr_enb;

  reg_Step_Size_0_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Step_Size_0_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Step_Size_0_1_1 = '1' THEN
        data_reg_Step_Size_0_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_Step_Size_0_1_1_process;


  
  decode_rd_Step_Size_0_1_1 <= decode_rd_Gain_NCO_3_1_1 WHEN decode_sel_Step_Size_0_1_1 = '0' ELSE
      data_reg_Step_Size_0_1_1;

  reg_enb_Step_Size_1_1_1 <= decode_sel_Step_Size_1_1_1 AND wr_enb;

  reg_Step_Size_1_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Step_Size_1_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Step_Size_1_1_1 = '1' THEN
        data_reg_Step_Size_1_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_Step_Size_1_1_1_process;


  
  decode_rd_Step_Size_1_1_1 <= decode_rd_Step_Size_0_1_1 WHEN decode_sel_Step_Size_1_1_1 = '0' ELSE
      data_reg_Step_Size_1_1_1;

  reg_enb_Step_Size_2_1_1 <= decode_sel_Step_Size_2_1_1 AND wr_enb;

  reg_Step_Size_2_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Step_Size_2_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Step_Size_2_1_1 = '1' THEN
        data_reg_Step_Size_2_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_Step_Size_2_1_1_process;


  
  decode_rd_Step_Size_2_1_1 <= decode_rd_Step_Size_1_1_1 WHEN decode_sel_Step_Size_2_1_1 = '0' ELSE
      data_reg_Step_Size_2_1_1;

  reg_enb_Step_Size_3_1_1 <= decode_sel_Step_Size_3_1_1 AND wr_enb;

  reg_Step_Size_3_1_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      data_reg_Step_Size_3_1_1 <= to_unsigned(0, 32);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND reg_enb_Step_Size_3_1_1 = '1' THEN
        data_reg_Step_Size_3_1_1 <= data_write_unsigned;
      END IF;
    END IF;
  END PROCESS reg_Step_Size_3_1_1_process;


  
  decode_rd_Step_Size_3_1_1 <= decode_rd_Step_Size_2_1_1 WHEN decode_sel_Step_Size_3_1_1 = '0' ELSE
      data_reg_Step_Size_3_1_1;

  data_read <= std_logic_vector(decode_rd_Step_Size_3_1_1);

  write_axi_enable <= write_concats_axi_enable_1;

  write_packet_size_axi4_stream_f0_master <= std_logic_vector(data_reg_packet_size_axi4_stream_f0_master_1_1);

  write_packet_size_axi4_stream_f1_master <= std_logic_vector(data_reg_packet_size_axi4_stream_f1_master_1_1);

  write_packet_size_axi4_stream_f2_master <= std_logic_vector(data_reg_packet_size_axi4_stream_f2_master_1_1);

  write_packet_size_axi4_stream_f3_master <= std_logic_vector(data_reg_packet_size_axi4_stream_f3_master_1_1);

  write_Constant <= std_logic_vector(data_reg_Constant_1_1);

  write_Enable_NCO_0 <= write_concats_Enable_NCO_0_1;

  write_Enable_NCO_1 <= write_concats_Enable_NCO_1_1;

  write_Enable_NCO_2 <= write_concats_Enable_NCO_2_1;

  write_Enable_NCO_3 <= write_concats_Enable_NCO_3_1;

  write_Gain_NCO_0 <= std_logic_vector(data_reg_Gain_NCO_0_1_1);

  write_Gain_NCO_1 <= std_logic_vector(data_reg_Gain_NCO_1_1_1);

  write_Gain_NCO_2 <= std_logic_vector(data_reg_Gain_NCO_2_1_1);

  write_Gain_NCO_3 <= std_logic_vector(data_reg_Gain_NCO_3_1_1);

  write_Step_Size_0 <= std_logic_vector(data_reg_Step_Size_0_1_1);

  write_Step_Size_1 <= std_logic_vector(data_reg_Step_Size_1_1_1);

  write_Step_Size_2 <= std_logic_vector(data_reg_Step_Size_2_1_1);

  write_Step_Size_3 <= std_logic_vector(data_reg_Step_Size_3_1_1);

END rtl;

