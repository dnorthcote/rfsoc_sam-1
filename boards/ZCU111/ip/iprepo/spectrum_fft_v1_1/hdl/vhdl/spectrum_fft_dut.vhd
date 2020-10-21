-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\spectrum_fft_hdlcoder\spectrum_fft_dut.vhd
-- Created: 2020-10-15 22:09:52
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: spectrum_fft_dut
-- Source Path: spectrum_fft/spectrum_fft_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY spectrum_fft_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        s_axis_re_tvalid                  :   IN    std_logic;  -- ufix1
        s_axis_re_tdata                   :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        s_axis_re_tlast                   :   IN    std_logic;  -- ufix1
        s_axis_re_tuser                   :   IN    std_logic;  -- ufix1
        s_axis_im_tvalid                  :   IN    std_logic;  -- ufix1
        s_axis_im_tdata                   :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        s_axis_im_tlast                   :   IN    std_logic;  -- ufix1
        s_axis_im_tuser                   :   IN    std_logic;  -- ufix1
        reset_1                           :   IN    std_logic;  -- ufix1
        m_axis_tready                     :   IN    std_logic;  -- ufix1
        m_axis_tvalid                     :   OUT   std_logic;  -- ufix1
        m_axis_tdata                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        m_axis_tlast                      :   OUT   std_logic;  -- ufix1
        m_axis_tuser                      :   OUT   std_logic;  -- ufix1
        s_axis_re_tready                  :   OUT   std_logic;  -- ufix1
        s_axis_im_tready                  :   OUT   std_logic  -- ufix1
        );
END spectrum_fft_dut;


ARCHITECTURE rtl OF spectrum_fft_dut IS

  -- Component Declarations
  COMPONENT spectrum_fft_src_FFT
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          s_axis_re_tvalid                :   IN    std_logic;  -- ufix1
          s_axis_re_tdata                 :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          s_axis_re_tlast                 :   IN    std_logic;  -- ufix1
          s_axis_re_tuser                 :   IN    std_logic;  -- ufix1
          s_axis_im_tvalid                :   IN    std_logic;  -- ufix1
          s_axis_im_tdata                 :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          s_axis_im_tlast                 :   IN    std_logic;  -- ufix1
          s_axis_im_tuser                 :   IN    std_logic;  -- ufix1
          reset_1                         :   IN    std_logic;  -- ufix1
          m_axis_tready                   :   IN    std_logic;  -- ufix1
          m_axis_tvalid                   :   OUT   std_logic;  -- ufix1
          m_axis_tdata                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          m_axis_tlast                    :   OUT   std_logic;  -- ufix1
          m_axis_tuser                    :   OUT   std_logic;  -- ufix1
          s_axis_re_tready                :   OUT   std_logic;  -- ufix1
          s_axis_im_tready                :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : spectrum_fft_src_FFT
    USE ENTITY work.spectrum_fft_src_FFT(rtl);

  -- Signals
  SIGNAL m_axis_tvalid_sig                : std_logic;  -- ufix1
  SIGNAL m_axis_tdata_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL m_axis_tlast_sig                 : std_logic;  -- ufix1
  SIGNAL m_axis_tuser_sig                 : std_logic;  -- ufix1
  SIGNAL s_axis_re_tready_sig             : std_logic;  -- ufix1
  SIGNAL s_axis_im_tready_sig             : std_logic;  -- ufix1

BEGIN
  u_spectrum_fft_src_FFT : spectrum_fft_src_FFT
    PORT MAP( clk => clk,
              reset => reset,
              s_axis_re_tvalid => s_axis_re_tvalid,  -- ufix1
              s_axis_re_tdata => s_axis_re_tdata,  -- ufix16
              s_axis_re_tlast => s_axis_re_tlast,  -- ufix1
              s_axis_re_tuser => s_axis_re_tuser,  -- ufix1
              s_axis_im_tvalid => s_axis_im_tvalid,  -- ufix1
              s_axis_im_tdata => s_axis_im_tdata,  -- ufix16
              s_axis_im_tlast => s_axis_im_tlast,  -- ufix1
              s_axis_im_tuser => s_axis_im_tuser,  -- ufix1
              reset_1 => reset_1,  -- ufix1
              m_axis_tready => m_axis_tready,  -- ufix1
              m_axis_tvalid => m_axis_tvalid_sig,  -- ufix1
              m_axis_tdata => m_axis_tdata_sig,  -- ufix32
              m_axis_tlast => m_axis_tlast_sig,  -- ufix1
              m_axis_tuser => m_axis_tuser_sig,  -- ufix1
              s_axis_re_tready => s_axis_re_tready_sig,  -- ufix1
              s_axis_im_tready => s_axis_im_tready_sig  -- ufix1
              );

  m_axis_tvalid <= m_axis_tvalid_sig;

  m_axis_tlast <= m_axis_tlast_sig;

  m_axis_tuser <= m_axis_tuser_sig;

  s_axis_re_tready <= s_axis_re_tready_sig;

  s_axis_im_tready <= s_axis_im_tready_sig;

  m_axis_tdata <= m_axis_tdata_sig;

END rtl;
