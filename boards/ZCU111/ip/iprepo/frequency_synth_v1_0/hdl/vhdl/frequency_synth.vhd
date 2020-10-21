-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\frequency_synth\frequency_synth.vhd
-- Created: 2020-10-19 10:03:37
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: -1
-- Target subsystem base rate: -1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: frequency_synth
-- Source Path: frequency_synth
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY frequency_synth IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        AXI4_Stream_F0_Master_TREADY      :   IN    std_logic;  -- ufix1
        AXI4_Stream_F1_Master_TREADY      :   IN    std_logic;  -- ufix1
        AXI4_Stream_F2_Master_TREADY      :   IN    std_logic;  -- ufix1
        AXI4_Stream_F3_Master_TREADY      :   IN    std_logic;  -- ufix1
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Stream_F0_Master_TDATA       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_F0_Master_TVALID      :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F0_Master_TLAST       :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F1_Master_TDATA       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_F1_Master_TVALID      :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F1_Master_TLAST       :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F2_Master_TDATA       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_F2_Master_TVALID      :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F2_Master_TLAST       :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F3_Master_TDATA       :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
        AXI4_Stream_F3_Master_TVALID      :   OUT   std_logic;  -- ufix1
        AXI4_Stream_F3_Master_TLAST       :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END frequency_synth;


ARCHITECTURE rtl OF frequency_synth IS

  -- Component Declarations
  COMPONENT frequency_synth_reset_sync
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset_in                        :   IN    std_logic;  -- ufix1
          reset_out                       :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT frequency_synth_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          write_packet_size_axi4_stream_f0_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_packet_size_axi4_stream_f1_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_packet_size_axi4_stream_f2_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_packet_size_axi4_stream_f3_master :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_Constant                  :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_Enable_NCO_0              :   OUT   std_logic;  -- ufix1
          write_Enable_NCO_1              :   OUT   std_logic;  -- ufix1
          write_Enable_NCO_2              :   OUT   std_logic;  -- ufix1
          write_Enable_NCO_3              :   OUT   std_logic;  -- ufix1
          write_Gain_NCO_0                :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          write_Gain_NCO_1                :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          write_Gain_NCO_2                :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          write_Gain_NCO_3                :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          write_Step_Size_0               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_Step_Size_1               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_Step_Size_2               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          write_Step_Size_3               :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT frequency_synth_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          Constant_rsvd                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          Enable_NCO_0                    :   IN    std_logic;  -- ufix1
          Enable_NCO_1                    :   IN    std_logic;  -- ufix1
          Enable_NCO_2                    :   IN    std_logic;  -- ufix1
          Enable_NCO_3                    :   IN    std_logic;  -- ufix1
          Gain_NCO_0                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Gain_NCO_1                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Gain_NCO_2                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Gain_NCO_3                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En14
          Step_Size_0                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          Step_Size_1                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          Step_Size_2                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          Step_Size_3                     :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          ce_out                          :   OUT   std_logic;  -- ufix1
          Valid_NCO_0                     :   OUT   std_logic;  -- ufix1
          Data_NCO_0                      :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          Valid_NCO_1                     :   OUT   std_logic;  -- ufix1
          Data_NCO_1                      :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          Valid_NCO_2                     :   OUT   std_logic;  -- ufix1
          Data_NCO_2                      :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          Valid_NCO_3                     :   OUT   std_logic;  -- ufix1
          Data_NCO_3                      :   OUT   std_logic_vector(127 DOWNTO 0)  -- ufix128
          );
  END COMPONENT;

  COMPONENT frequency_synth_axi4_stream_f0_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_F0_Master_TREADY    :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          write_packet_size_axi4_stream_f0_master :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Stream_F0_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_F0_Master_TVALID    :   OUT   std_logic;  -- ufix1
          AXI4_Stream_F0_Master_TLAST     :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT frequency_synth_axi4_stream_f1_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_F1_Master_TREADY    :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          write_packet_size_axi4_stream_f1_master :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Stream_F1_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_F1_Master_TVALID    :   OUT   std_logic;  -- ufix1
          AXI4_Stream_F1_Master_TLAST     :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT frequency_synth_axi4_stream_f2_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_F2_Master_TREADY    :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          write_packet_size_axi4_stream_f2_master :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Stream_F2_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_F2_Master_TVALID    :   OUT   std_logic;  -- ufix1
          AXI4_Stream_F2_Master_TLAST     :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT frequency_synth_axi4_stream_f3_master
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          AXI4_Stream_F3_Master_TREADY    :   IN    std_logic;  -- ufix1
          user_data                       :   IN    std_logic_vector(127 DOWNTO 0);  -- ufix128
          user_valid                      :   IN    std_logic;  -- ufix1
          write_packet_size_axi4_stream_f3_master :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Stream_F3_Master_TDATA     :   OUT   std_logic_vector(127 DOWNTO 0);  -- ufix128
          AXI4_Stream_F3_Master_TVALID    :   OUT   std_logic;  -- ufix1
          AXI4_Stream_F3_Master_TLAST     :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : frequency_synth_reset_sync
    USE ENTITY work.frequency_synth_reset_sync(rtl);

  FOR ALL : frequency_synth_axi_lite
    USE ENTITY work.frequency_synth_axi_lite(rtl);

  FOR ALL : frequency_synth_dut
    USE ENTITY work.frequency_synth_dut(rtl);

  FOR ALL : frequency_synth_axi4_stream_f0_master
    USE ENTITY work.frequency_synth_axi4_stream_f0_master(rtl);

  FOR ALL : frequency_synth_axi4_stream_f1_master
    USE ENTITY work.frequency_synth_axi4_stream_f1_master(rtl);

  FOR ALL : frequency_synth_axi4_stream_f2_master
    USE ENTITY work.frequency_synth_axi4_stream_f2_master(rtl);

  FOR ALL : frequency_synth_axi4_stream_f3_master
    USE ENTITY work.frequency_synth_axi4_stream_f3_master(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL reset_before_sync                : std_logic;  -- ufix1
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL write_packet_size_axi4_stream_f0_master : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_packet_size_axi4_stream_f1_master : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_packet_size_axi4_stream_f2_master : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_packet_size_axi4_stream_f3_master : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_Constant                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_Enable_NCO_0               : std_logic;  -- ufix1
  SIGNAL write_Enable_NCO_1               : std_logic;  -- ufix1
  SIGNAL write_Enable_NCO_2               : std_logic;  -- ufix1
  SIGNAL write_Enable_NCO_3               : std_logic;  -- ufix1
  SIGNAL write_Gain_NCO_0                 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL write_Gain_NCO_1                 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL write_Gain_NCO_2                 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL write_Gain_NCO_3                 : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL write_Step_Size_0                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_Step_Size_1                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_Step_Size_2                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL write_Step_Size_3                : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL Valid_NCO_0_sig                  : std_logic;  -- ufix1
  SIGNAL Data_NCO_0_sig                   : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Valid_NCO_1_sig                  : std_logic;  -- ufix1
  SIGNAL Data_NCO_1_sig                   : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Valid_NCO_2_sig                  : std_logic;  -- ufix1
  SIGNAL Data_NCO_2_sig                   : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL Valid_NCO_3_sig                  : std_logic;  -- ufix1
  SIGNAL Data_NCO_3_sig                   : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL const_1_1                        : std_logic;  -- ufix1
  SIGNAL AXI4_Stream_F0_Master_TDATA_tmp  : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL AXI4_Stream_F1_Master_TDATA_tmp  : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL AXI4_Stream_F2_Master_TDATA_tmp  : std_logic_vector(127 DOWNTO 0);  -- ufix128
  SIGNAL AXI4_Stream_F3_Master_TDATA_tmp  : std_logic_vector(127 DOWNTO 0);  -- ufix128

BEGIN
  u_frequency_synth_reset_sync_inst : frequency_synth_reset_sync
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset_in => reset_before_sync,  -- ufix1
              reset_out => reset
              );

  u_frequency_synth_axi_lite_inst : frequency_synth_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              write_packet_size_axi4_stream_f0_master => write_packet_size_axi4_stream_f0_master,  -- ufix32
              write_packet_size_axi4_stream_f1_master => write_packet_size_axi4_stream_f1_master,  -- ufix32
              write_packet_size_axi4_stream_f2_master => write_packet_size_axi4_stream_f2_master,  -- ufix32
              write_packet_size_axi4_stream_f3_master => write_packet_size_axi4_stream_f3_master,  -- ufix32
              write_Constant => write_Constant,  -- ufix32
              write_Enable_NCO_0 => write_Enable_NCO_0,  -- ufix1
              write_Enable_NCO_1 => write_Enable_NCO_1,  -- ufix1
              write_Enable_NCO_2 => write_Enable_NCO_2,  -- ufix1
              write_Enable_NCO_3 => write_Enable_NCO_3,  -- ufix1
              write_Gain_NCO_0 => write_Gain_NCO_0,  -- sfix16_En14
              write_Gain_NCO_1 => write_Gain_NCO_1,  -- sfix16_En14
              write_Gain_NCO_2 => write_Gain_NCO_2,  -- sfix16_En14
              write_Gain_NCO_3 => write_Gain_NCO_3,  -- sfix16_En14
              write_Step_Size_0 => write_Step_Size_0,  -- ufix32
              write_Step_Size_1 => write_Step_Size_1,  -- ufix32
              write_Step_Size_2 => write_Step_Size_2,  -- ufix32
              write_Step_Size_3 => write_Step_Size_3,  -- ufix32
              reset_internal => reset_internal  -- ufix1
              );

  u_frequency_synth_dut_inst : frequency_synth_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              Constant_rsvd => write_Constant,  -- ufix32
              Enable_NCO_0 => write_Enable_NCO_0,  -- ufix1
              Enable_NCO_1 => write_Enable_NCO_1,  -- ufix1
              Enable_NCO_2 => write_Enable_NCO_2,  -- ufix1
              Enable_NCO_3 => write_Enable_NCO_3,  -- ufix1
              Gain_NCO_0 => write_Gain_NCO_0,  -- sfix16_En14
              Gain_NCO_1 => write_Gain_NCO_1,  -- sfix16_En14
              Gain_NCO_2 => write_Gain_NCO_2,  -- sfix16_En14
              Gain_NCO_3 => write_Gain_NCO_3,  -- sfix16_En14
              Step_Size_0 => write_Step_Size_0,  -- ufix32
              Step_Size_1 => write_Step_Size_1,  -- ufix32
              Step_Size_2 => write_Step_Size_2,  -- ufix32
              Step_Size_3 => write_Step_Size_3,  -- ufix32
              ce_out => ce_out_sig,  -- ufix1
              Valid_NCO_0 => Valid_NCO_0_sig,  -- ufix1
              Data_NCO_0 => Data_NCO_0_sig,  -- ufix128
              Valid_NCO_1 => Valid_NCO_1_sig,  -- ufix1
              Data_NCO_1 => Data_NCO_1_sig,  -- ufix128
              Valid_NCO_2 => Valid_NCO_2_sig,  -- ufix1
              Data_NCO_2 => Data_NCO_2_sig,  -- ufix128
              Valid_NCO_3 => Valid_NCO_3_sig,  -- ufix1
              Data_NCO_3 => Data_NCO_3_sig  -- ufix128
              );

  u_frequency_synth_axi4_stream_f0_master_inst : frequency_synth_axi4_stream_f0_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_F0_Master_TREADY => AXI4_Stream_F0_Master_TREADY,  -- ufix1
              user_data => Data_NCO_0_sig,  -- ufix128
              user_valid => Valid_NCO_0_sig,  -- ufix1
              write_packet_size_axi4_stream_f0_master => write_packet_size_axi4_stream_f0_master,  -- ufix32
              AXI4_Stream_F0_Master_TDATA => AXI4_Stream_F0_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_F0_Master_TVALID => AXI4_Stream_F0_Master_TVALID,  -- ufix1
              AXI4_Stream_F0_Master_TLAST => AXI4_Stream_F0_Master_TLAST  -- ufix1
              );

  u_frequency_synth_axi4_stream_f1_master_inst : frequency_synth_axi4_stream_f1_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_F1_Master_TREADY => AXI4_Stream_F1_Master_TREADY,  -- ufix1
              user_data => Data_NCO_1_sig,  -- ufix128
              user_valid => Valid_NCO_1_sig,  -- ufix1
              write_packet_size_axi4_stream_f1_master => write_packet_size_axi4_stream_f1_master,  -- ufix32
              AXI4_Stream_F1_Master_TDATA => AXI4_Stream_F1_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_F1_Master_TVALID => AXI4_Stream_F1_Master_TVALID,  -- ufix1
              AXI4_Stream_F1_Master_TLAST => AXI4_Stream_F1_Master_TLAST  -- ufix1
              );

  u_frequency_synth_axi4_stream_f2_master_inst : frequency_synth_axi4_stream_f2_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_F2_Master_TREADY => AXI4_Stream_F2_Master_TREADY,  -- ufix1
              user_data => Data_NCO_2_sig,  -- ufix128
              user_valid => Valid_NCO_2_sig,  -- ufix1
              write_packet_size_axi4_stream_f2_master => write_packet_size_axi4_stream_f2_master,  -- ufix32
              AXI4_Stream_F2_Master_TDATA => AXI4_Stream_F2_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_F2_Master_TVALID => AXI4_Stream_F2_Master_TVALID,  -- ufix1
              AXI4_Stream_F2_Master_TLAST => AXI4_Stream_F2_Master_TLAST  -- ufix1
              );

  u_frequency_synth_axi4_stream_f3_master_inst : frequency_synth_axi4_stream_f3_master
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              enb => const_1_1,
              AXI4_Stream_F3_Master_TREADY => AXI4_Stream_F3_Master_TREADY,  -- ufix1
              user_data => Data_NCO_3_sig,  -- ufix128
              user_valid => Valid_NCO_3_sig,  -- ufix1
              write_packet_size_axi4_stream_f3_master => write_packet_size_axi4_stream_f3_master,  -- ufix32
              AXI4_Stream_F3_Master_TDATA => AXI4_Stream_F3_Master_TDATA_tmp,  -- ufix128
              AXI4_Stream_F3_Master_TVALID => AXI4_Stream_F3_Master_TVALID,  -- ufix1
              AXI4_Stream_F3_Master_TLAST => AXI4_Stream_F3_Master_TLAST  -- ufix1
              );

  ip_timestamp <= to_unsigned(2010191003, 32);

  reset_cm <=  NOT IPCORE_RESETN;

  reset_before_sync <= reset_cm OR reset_internal;

  const_1_1 <= '1';

  AXI4_Stream_F0_Master_TDATA <= AXI4_Stream_F0_Master_TDATA_tmp;

  AXI4_Stream_F1_Master_TDATA <= AXI4_Stream_F1_Master_TDATA_tmp;

  AXI4_Stream_F2_Master_TDATA <= AXI4_Stream_F2_Master_TDATA_tmp;

  AXI4_Stream_F3_Master_TDATA <= AXI4_Stream_F3_Master_TDATA_tmp;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

