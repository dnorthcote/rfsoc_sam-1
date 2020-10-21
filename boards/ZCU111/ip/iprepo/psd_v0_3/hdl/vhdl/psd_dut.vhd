-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\psd_db\psd_dut.vhd
-- Created: 2020-10-15 20:02:06
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: psd_dut
-- Source Path: psd/psd_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY psd_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        output_selection                  :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        window                            :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        rbw                               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        s_axis_tvalid                     :   IN    std_logic;  -- ufix1
        s_axis_tdata                      :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        s_axis_tlast                      :   IN    std_logic;  -- ufix1
        s_axis_tuser                      :   IN    std_logic;  -- ufix1
        ce_out                            :   OUT   std_logic;  -- ufix1
        m_axis_tvalid                     :   OUT   std_logic;  -- ufix1
        m_axis_tdata                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        m_axis_tlast                      :   OUT   std_logic;  -- ufix1
        m_axis_tuser                      :   OUT   std_logic  -- ufix1
        );
END psd_dut;


ARCHITECTURE rtl OF psd_dut IS

  -- Component Declarations
  COMPONENT psd_src_PSD_Calculation
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
          output_selection                :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          window                          :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          rbw                             :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_tvalid                   :   IN    std_logic;  -- ufix1
          s_axis_tdata                    :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          s_axis_tlast                    :   IN    std_logic;  -- ufix1
          s_axis_tuser                    :   IN    std_logic;  -- ufix1
          ce_out                          :   OUT   std_logic;  -- ufix1
          m_axis_tvalid                   :   OUT   std_logic;  -- ufix1
          m_axis_tdata                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          m_axis_tlast                    :   OUT   std_logic;  -- ufix1
          m_axis_tuser                    :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : psd_src_PSD_Calculation
    USE ENTITY work.psd_src_PSD_Calculation(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL ce_out_sig                       : std_logic;  -- ufix1
  SIGNAL m_axis_tvalid_sig                : std_logic;  -- ufix1
  SIGNAL m_axis_tdata_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_tlast_sig                 : std_logic;  -- ufix1
  SIGNAL m_axis_tuser_sig                 : std_logic;  -- ufix1

BEGIN
  u_psd_src_PSD_Calculation : psd_src_PSD_Calculation
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              output_selection => output_selection,  -- ufix32
              window => window,  -- ufix32
              rbw => rbw,  -- ufix32
              s_axis_tvalid => s_axis_tvalid,  -- ufix1
              s_axis_tdata => s_axis_tdata,  -- ufix32
              s_axis_tlast => s_axis_tlast,  -- ufix1
              s_axis_tuser => s_axis_tuser,  -- ufix1
              ce_out => ce_out_sig,  -- ufix1
              m_axis_tvalid => m_axis_tvalid_sig,  -- ufix1
              m_axis_tdata => m_axis_tdata_sig,  -- ufix32
              m_axis_tlast => m_axis_tlast_sig,  -- ufix1
              m_axis_tuser => m_axis_tuser_sig  -- ufix1
              );

  enb <= dut_enable;

  ce_out <= ce_out_sig;

  m_axis_tvalid <= m_axis_tvalid_sig;

  m_axis_tlast <= m_axis_tlast_sig;

  m_axis_tuser <= m_axis_tuser_sig;

  m_axis_tdata <= m_axis_tdata_sig;

END rtl;

