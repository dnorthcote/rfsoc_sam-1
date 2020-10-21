-- Generated from Simulink block BandwidthSelector/AXI-Stream FIR Variant/FIR/Subsystem/Downsampler
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_downsampler is
  port (
    downsample_factor : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    valid : out std_logic_vector( 1-1 downto 0 )
  );
end bandwidthselector_downsampler;
architecture structural of bandwidthselector_downsampler is 
  signal clk_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal downsample_factor_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal counter_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 32-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
begin
  valid <= relational_op_net;
  downsample_factor_net <= downsample_factor;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant1 : entity xil_defaultlib.sysgen_constant_b76f44cae2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  counter : entity xil_defaultlib.bandwidthselector_xlcounter_free 
  generic map (
    core_name0 => "bandwidthselector_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 16
  )
  port map (
    en => "1",
    clr => '0',
    rst => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  register_x0 : entity xil_defaultlib.bandwidthselector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    rst => "0",
    d => downsample_factor_net,
    en => relational1_op_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_06ed39ed8d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => register_q_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_33f27f7ea3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block BandwidthSelector/AXI-Stream FIR Variant/FIR/Subsystem
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_subsystem is
  port (
    s_axis_re_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_im_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_config_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_config_tdata : in std_logic_vector( 8-1 downto 0 );
    s_axis_reload_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_reload_tlast : in std_logic_vector( 1-1 downto 0 );
    downsample_factor : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_axis_re_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_re_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_im_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_im_tdata : out std_logic_vector( 16-1 downto 0 );
    s_axis_re_tready : out std_logic;
    s_axis_im_tready : out std_logic;
    s_axis_config_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tready : out std_logic_vector( 1-1 downto 0 );
    event_missing : out std_logic_vector( 1-1 downto 0 );
    event_unexpected : out std_logic_vector( 1-1 downto 0 )
  );
end bandwidthselector_subsystem;
architecture structural of bandwidthselector_subsystem is 
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_re_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_im_s_axis_data_tready_net : std_logic;
  signal s_axis_re_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_reload_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_config_tdata_net : std_logic_vector( 8-1 downto 0 );
  signal downsample_factor_net : std_logic_vector( 32-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_im_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_im_m_axis_data_tdata_real_net : std_logic_vector( 40-1 downto 0 );
  signal s_axis_config_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_reload_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_im_s_axis_config_tready_net : std_logic;
  signal fir_compiler_7_2_im_s_axis_reload_tready_net : std_logic;
  signal fir_compiler_7_2_im_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_re_m_axis_data_tdata_real_net : std_logic_vector( 40-1 downto 0 );
  signal fir_compiler_7_2_im_event_s_reload_tlast_unexpected_net : std_logic;
  signal clk_net : std_logic;
  signal fir_compiler_7_2_im_event_s_reload_tlast_missing_net : std_logic;
  signal s_axis_reload_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_re_event_s_reload_tlast_missing_net : std_logic;
  signal fir_compiler_7_2_re_s_axis_reload_tready_net : std_logic;
  signal fir_compiler_7_2_re_event_s_reload_tlast_unexpected_net : std_logic;
  signal fir_compiler_7_2_re_m_axis_data_tvalid_net : std_logic;
  signal fir_compiler_7_2_re_s_axis_config_tready_net : std_logic;
begin
  m_axis_re_tvalid <= logical4_y_net;
  m_axis_re_tdata <= convert_dout_net;
  m_axis_im_tvalid <= logical5_y_net;
  m_axis_im_tdata <= convert1_dout_net;
  s_axis_re_tready <= fir_compiler_7_2_re_s_axis_data_tready_net;
  s_axis_im_tready <= fir_compiler_7_2_im_s_axis_data_tready_net;
  s_axis_config_tready <= logical3_y_net;
  s_axis_reload_tready <= logical2_y_net;
  event_missing <= logical1_y_net;
  event_unexpected <= logical_y_net;
  s_axis_re_tdata_net <= s_axis_re_tdata;
  s_axis_im_tdata_net <= s_axis_im_tdata;
  s_axis_config_tvalid_net <= s_axis_config_tvalid;
  s_axis_config_tdata_net <= s_axis_config_tdata;
  s_axis_reload_tvalid_net <= s_axis_reload_tvalid;
  s_axis_reload_tdata_net <= s_axis_reload_tdata;
  s_axis_reload_tlast_net <= s_axis_reload_tlast;
  downsample_factor_net <= downsample_factor;
  clk_net <= clk_1;
  ce_net <= ce_1;
  downsampler : entity xil_defaultlib.bandwidthselector_downsampler 
  port map (
    downsample_factor => downsample_factor_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    valid => relational_op_net
  );
  convert : entity xil_defaultlib.bandwidthselector_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 40,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_re_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.bandwidthselector_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 40,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => fir_compiler_7_2_im_m_axis_data_tdata_real_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  fir_compiler_7_2_im : entity xil_defaultlib.xlfir_compiler_548447858a9e7bfba9cfe6326e343584 
  port map (
    s_axis_data_tdata_real => s_axis_im_tdata_net,
    s_axis_config_tvalid => s_axis_config_tvalid_net(0),
    s_axis_config_tdata_data => s_axis_config_tdata_net,
    s_axis_reload_tvalid => s_axis_reload_tvalid_net(0),
    s_axis_reload_tlast => s_axis_reload_tlast_net(0),
    s_axis_reload_tdata_data => s_axis_reload_tdata_net,
    src_clk => clk_net,
    src_ce => ce_net,
    clk => clk_net,
    ce => ce_net,
    clk_logic_1 => clk_net,
    ce_logic_1 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_im_s_axis_data_tready_net,
    s_axis_config_tready => fir_compiler_7_2_im_s_axis_config_tready_net,
    s_axis_reload_tready => fir_compiler_7_2_im_s_axis_reload_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_im_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_im_m_axis_data_tdata_real_net,
    event_s_reload_tlast_missing => fir_compiler_7_2_im_event_s_reload_tlast_missing_net,
    event_s_reload_tlast_unexpected => fir_compiler_7_2_im_event_s_reload_tlast_unexpected_net
  );
  fir_compiler_7_2_re : entity xil_defaultlib.xlfir_compiler_548447858a9e7bfba9cfe6326e343584 
  port map (
    s_axis_data_tdata_real => s_axis_re_tdata_net,
    s_axis_config_tvalid => s_axis_config_tvalid_net(0),
    s_axis_config_tdata_data => s_axis_config_tdata_net,
    s_axis_reload_tvalid => s_axis_reload_tvalid_net(0),
    s_axis_reload_tlast => s_axis_reload_tlast_net(0),
    s_axis_reload_tdata_data => s_axis_reload_tdata_net,
    src_clk => clk_net,
    src_ce => ce_net,
    clk => clk_net,
    ce => ce_net,
    clk_logic_1 => clk_net,
    ce_logic_1 => ce_net,
    s_axis_data_tready => fir_compiler_7_2_re_s_axis_data_tready_net,
    s_axis_config_tready => fir_compiler_7_2_re_s_axis_config_tready_net,
    s_axis_reload_tready => fir_compiler_7_2_re_s_axis_reload_tready_net,
    m_axis_data_tvalid => fir_compiler_7_2_re_m_axis_data_tvalid_net,
    m_axis_data_tdata_real => fir_compiler_7_2_re_m_axis_data_tdata_real_net,
    event_s_reload_tlast_missing => fir_compiler_7_2_re_event_s_reload_tlast_missing_net,
    event_s_reload_tlast_unexpected => fir_compiler_7_2_re_event_s_reload_tlast_unexpected_net
  );
  logical : entity xil_defaultlib.sysgen_logical_4705477838 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_re_event_s_reload_tlast_unexpected_net,
    d1(0) => fir_compiler_7_2_im_event_s_reload_tlast_unexpected_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_4705477838 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_re_event_s_reload_tlast_missing_net,
    d1(0) => fir_compiler_7_2_im_event_s_reload_tlast_missing_net,
    y => logical1_y_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_4705477838 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_re_s_axis_reload_tready_net,
    d1(0) => fir_compiler_7_2_im_s_axis_reload_tready_net,
    y => logical2_y_net
  );
  logical3 : entity xil_defaultlib.sysgen_logical_4705477838 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_re_s_axis_config_tready_net,
    d1(0) => fir_compiler_7_2_im_s_axis_config_tready_net,
    y => logical3_y_net
  );
  logical4 : entity xil_defaultlib.sysgen_logical_300d966a4c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_re_m_axis_data_tvalid_net,
    d1 => relational_op_net,
    y => logical4_y_net
  );
  logical5 : entity xil_defaultlib.sysgen_logical_300d966a4c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0(0) => fir_compiler_7_2_im_m_axis_data_tvalid_net,
    d1 => relational_op_net,
    y => logical5_y_net
  );
end structural;
-- Generated from Simulink block BandwidthSelector/AXI-Stream FIR Variant/FIR
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_fir is
  port (
    s_axis_re_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_im_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_config_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_config_tdata : in std_logic_vector( 8-1 downto 0 );
    s_axis_reload_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_reload_tlast : in std_logic_vector( 1-1 downto 0 );
    downsample_factor : in std_logic_vector( 32-1 downto 0 );
    fir_enable : in std_logic_vector( 8-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_axis_re_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_re_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_im_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_im_tdata : out std_logic_vector( 16-1 downto 0 );
    s_axis_re_tready : out std_logic;
    s_axis_im_tready : out std_logic;
    s_axis_config_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tready : out std_logic_vector( 1-1 downto 0 );
    event_missing : out std_logic_vector( 1-1 downto 0 );
    event_unexpected : out std_logic_vector( 1-1 downto 0 )
  );
end bandwidthselector_fir;
architecture structural of bandwidthselector_fir is 
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_re_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_reload_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal fir_enable_net : std_logic_vector( 8-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_re_s_axis_data_tready_net : std_logic;
  signal s_axis_reload_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal s_axis_config_tdata_net : std_logic_vector( 8-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_im_s_axis_data_tready_net : std_logic;
  signal downsample_factor_net : std_logic_vector( 32-1 downto 0 );
  signal s_axis_config_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_im_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_reload_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
begin
  m_axis_re_tvalid <= logical4_y_net;
  m_axis_re_tdata <= mux_y_net;
  m_axis_im_tvalid <= logical5_y_net;
  m_axis_im_tdata <= mux1_y_net;
  s_axis_re_tready <= fir_compiler_7_2_re_s_axis_data_tready_net;
  s_axis_im_tready <= fir_compiler_7_2_im_s_axis_data_tready_net;
  s_axis_config_tready <= logical3_y_net;
  s_axis_reload_tready <= logical2_y_net;
  event_missing <= logical1_y_net;
  event_unexpected <= logical_y_net;
  s_axis_re_tdata_net <= s_axis_re_tdata;
  s_axis_im_tdata_net <= s_axis_im_tdata;
  s_axis_config_tvalid_net <= s_axis_config_tvalid;
  s_axis_config_tdata_net <= s_axis_config_tdata;
  s_axis_reload_tvalid_net <= s_axis_reload_tvalid;
  s_axis_reload_tdata_net <= s_axis_reload_tdata;
  s_axis_reload_tlast_net <= s_axis_reload_tlast;
  downsample_factor_net <= downsample_factor;
  fir_enable_net <= fir_enable;
  clk_net <= clk_1;
  ce_net <= ce_1;
  subsystem : entity xil_defaultlib.bandwidthselector_subsystem 
  port map (
    s_axis_re_tdata => s_axis_re_tdata_net,
    s_axis_im_tdata => s_axis_im_tdata_net,
    s_axis_config_tvalid => s_axis_config_tvalid_net,
    s_axis_config_tdata => s_axis_config_tdata_net,
    s_axis_reload_tvalid => s_axis_reload_tvalid_net,
    s_axis_reload_tdata => s_axis_reload_tdata_net,
    s_axis_reload_tlast => s_axis_reload_tlast_net,
    downsample_factor => downsample_factor_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    m_axis_re_tvalid => logical4_y_net,
    m_axis_re_tdata => convert_dout_net,
    m_axis_im_tvalid => logical5_y_net,
    m_axis_im_tdata => convert1_dout_net,
    s_axis_re_tready => fir_compiler_7_2_re_s_axis_data_tready_net,
    s_axis_im_tready => fir_compiler_7_2_im_s_axis_data_tready_net,
    s_axis_config_tready => logical3_y_net,
    s_axis_reload_tready => logical2_y_net,
    event_missing => logical1_y_net,
    event_unexpected => logical_y_net
  );
  delay1 : entity xil_defaultlib.bandwidthselector_xldelay 
  generic map (
    latency => 136,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => s_axis_re_tdata_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.bandwidthselector_xldelay 
  generic map (
    latency => 136,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => s_axis_im_tdata_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  mux : entity xil_defaultlib.sysgen_mux_6dd97b4845 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice_y_net,
    d0 => delay1_q_net,
    d1 => convert_dout_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_6dd97b4845 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice_y_net,
    d0 => delay2_q_net,
    d1 => convert1_dout_net,
    y => mux1_y_net
  );
  slice : entity xil_defaultlib.bandwidthselector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 8,
    y_width => 1
  )
  port map (
    x => fir_enable_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block BandwidthSelector/AXI-Stream FIR Variant
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_axi_stream_fir_variant is
  port (
    s_axis_re_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_im_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_config_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_config_tdata : in std_logic_vector( 8-1 downto 0 );
    s_axis_reload_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_reload_tlast : in std_logic_vector( 1-1 downto 0 );
    downsample_factor : in std_logic_vector( 32-1 downto 0 );
    fir_enable : in std_logic_vector( 8-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    m_axis_re_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_re_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_im_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_im_tdata : out std_logic_vector( 16-1 downto 0 );
    s_axis_re_tready : out std_logic;
    s_axis_im_tready : out std_logic;
    s_axis_config_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tready : out std_logic_vector( 1-1 downto 0 );
    event_missing : out std_logic_vector( 1-1 downto 0 );
    event_unexpected : out std_logic_vector( 1-1 downto 0 )
  );
end bandwidthselector_axi_stream_fir_variant;
architecture structural of bandwidthselector_axi_stream_fir_variant is 
  signal s_axis_config_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_reload_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal s_axis_reload_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal fir_compiler_7_2_re_s_axis_data_tready_net : std_logic;
  signal fir_compiler_7_2_im_s_axis_data_tready_net : std_logic;
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_re_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal downsample_factor_net : std_logic_vector( 32-1 downto 0 );
  signal fir_enable_net : std_logic_vector( 8-1 downto 0 );
  signal s_axis_im_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_config_tdata_net : std_logic_vector( 8-1 downto 0 );
  signal ce_net : std_logic;
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_reload_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
begin
  m_axis_re_tvalid <= logical4_y_net;
  m_axis_re_tdata <= mux_y_net;
  m_axis_im_tvalid <= logical5_y_net;
  m_axis_im_tdata <= mux1_y_net;
  s_axis_re_tready <= fir_compiler_7_2_re_s_axis_data_tready_net;
  s_axis_im_tready <= fir_compiler_7_2_im_s_axis_data_tready_net;
  s_axis_config_tready <= logical3_y_net;
  s_axis_reload_tready <= logical2_y_net;
  event_missing <= logical1_y_net;
  event_unexpected <= logical_y_net;
  s_axis_re_tdata_net <= s_axis_re_tdata;
  s_axis_im_tdata_net <= s_axis_im_tdata;
  s_axis_config_tvalid_net <= s_axis_config_tvalid;
  s_axis_config_tdata_net <= s_axis_config_tdata;
  s_axis_reload_tvalid_net <= s_axis_reload_tvalid;
  s_axis_reload_tdata_net <= s_axis_reload_tdata;
  s_axis_reload_tlast_net <= s_axis_reload_tlast;
  downsample_factor_net <= downsample_factor;
  fir_enable_net <= fir_enable;
  clk_net <= clk_1;
  ce_net <= ce_1;
  fir : entity xil_defaultlib.bandwidthselector_fir 
  port map (
    s_axis_re_tdata => s_axis_re_tdata_net,
    s_axis_im_tdata => s_axis_im_tdata_net,
    s_axis_config_tvalid => s_axis_config_tvalid_net,
    s_axis_config_tdata => s_axis_config_tdata_net,
    s_axis_reload_tvalid => s_axis_reload_tvalid_net,
    s_axis_reload_tdata => s_axis_reload_tdata_net,
    s_axis_reload_tlast => s_axis_reload_tlast_net,
    downsample_factor => downsample_factor_net,
    fir_enable => fir_enable_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    m_axis_re_tvalid => logical4_y_net,
    m_axis_re_tdata => mux_y_net,
    m_axis_im_tvalid => logical5_y_net,
    m_axis_im_tdata => mux1_y_net,
    s_axis_re_tready => fir_compiler_7_2_re_s_axis_data_tready_net,
    s_axis_im_tready => fir_compiler_7_2_im_s_axis_data_tready_net,
    s_axis_config_tready => logical3_y_net,
    s_axis_reload_tready => logical2_y_net,
    event_missing => logical1_y_net,
    event_unexpected => logical_y_net
  );
end structural;
-- Generated from Simulink block BandwidthSelector_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_struct is
  port (
    downsample_factor : in std_logic_vector( 32-1 downto 0 );
    fir_enable : in std_logic_vector( 8-1 downto 0 );
    s_axis_config_tdata : in std_logic_vector( 8-1 downto 0 );
    s_axis_config_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_im_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_im_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_re_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_re_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_reload_tlast : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    event_missing : out std_logic_vector( 1-1 downto 0 );
    event_unexpected : out std_logic_vector( 1-1 downto 0 );
    m_axis_im_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_im_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_re_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_re_tvalid : out std_logic_vector( 1-1 downto 0 );
    s_axis_config_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_im_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_re_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tready : out std_logic_vector( 1-1 downto 0 )
  );
end bandwidthselector_struct;
architecture structural of bandwidthselector_struct is 
  signal downsample_factor_net : std_logic_vector( 32-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_enable_net : std_logic_vector( 8-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 16-1 downto 0 );
  signal logical5_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_re_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_reload_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_reload_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_config_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_reload_tlast_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_config_tdata_net : std_logic_vector( 8-1 downto 0 );
  signal ce_net : std_logic;
  signal s_axis_im_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical4_y_net : std_logic_vector( 1-1 downto 0 );
  signal s_axis_im_tvalid_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal s_axis_re_tdata_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal fir_compiler_7_2_im_s_axis_data_tready_net : std_logic_vector( 1-1 downto 0 );
  signal logical3_y_net : std_logic_vector( 1-1 downto 0 );
  signal fir_compiler_7_2_re_s_axis_data_tready_net : std_logic_vector( 1-1 downto 0 );
begin
  downsample_factor_net <= downsample_factor;
  event_missing <= logical1_y_net;
  event_unexpected <= logical_y_net;
  fir_enable_net <= fir_enable;
  m_axis_im_tdata <= mux1_y_net;
  m_axis_im_tvalid <= logical5_y_net;
  m_axis_re_tdata <= mux_y_net;
  m_axis_re_tvalid <= logical4_y_net;
  s_axis_config_tdata_net <= s_axis_config_tdata;
  s_axis_config_tready <= logical3_y_net;
  s_axis_config_tvalid_net <= s_axis_config_tvalid;
  s_axis_im_tdata_net <= s_axis_im_tdata;
  s_axis_im_tready <= fir_compiler_7_2_im_s_axis_data_tready_net;
  s_axis_im_tvalid_net <= s_axis_im_tvalid;
  s_axis_re_tdata_net <= s_axis_re_tdata;
  s_axis_re_tready <= fir_compiler_7_2_re_s_axis_data_tready_net;
  s_axis_re_tvalid_net <= s_axis_re_tvalid;
  s_axis_reload_tdata_net <= s_axis_reload_tdata;
  s_axis_reload_tlast_net <= s_axis_reload_tlast;
  s_axis_reload_tready <= logical2_y_net;
  s_axis_reload_tvalid_net <= s_axis_reload_tvalid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  axi_stream_fir_variant : entity xil_defaultlib.bandwidthselector_axi_stream_fir_variant 
  port map (
    s_axis_re_tdata => s_axis_re_tdata_net,
    s_axis_im_tdata => s_axis_im_tdata_net,
    s_axis_config_tvalid => s_axis_config_tvalid_net,
    s_axis_config_tdata => s_axis_config_tdata_net,
    s_axis_reload_tvalid => s_axis_reload_tvalid_net,
    s_axis_reload_tdata => s_axis_reload_tdata_net,
    s_axis_reload_tlast => s_axis_reload_tlast_net,
    downsample_factor => downsample_factor_net,
    fir_enable => fir_enable_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    m_axis_re_tvalid => logical4_y_net,
    m_axis_re_tdata => mux_y_net,
    m_axis_im_tvalid => logical5_y_net,
    m_axis_im_tdata => mux1_y_net,
    s_axis_re_tready => fir_compiler_7_2_re_s_axis_data_tready_net(0),
    s_axis_im_tready => fir_compiler_7_2_im_s_axis_data_tready_net(0),
    s_axis_config_tready => logical3_y_net,
    s_axis_reload_tready => logical2_y_net,
    event_missing => logical1_y_net,
    event_unexpected => logical_y_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector_default_clock_driver is
  port (
    bandwidthselector_sysclk : in std_logic;
    bandwidthselector_sysce : in std_logic;
    bandwidthselector_sysclr : in std_logic;
    bandwidthselector_clk1 : out std_logic;
    bandwidthselector_ce1 : out std_logic
  );
end bandwidthselector_default_clock_driver;
architecture structural of bandwidthselector_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => bandwidthselector_sysclk,
    sysce => bandwidthselector_sysce,
    sysclr => bandwidthselector_sysclr,
    clk => bandwidthselector_clk1,
    ce => bandwidthselector_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity bandwidthselector is
  port (
    s_axis_config_tdata : in std_logic_vector( 8-1 downto 0 );
    s_axis_config_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_im_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_im_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_re_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_re_tvalid : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tdata : in std_logic_vector( 16-1 downto 0 );
    s_axis_reload_tlast : in std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tvalid : in std_logic_vector( 1-1 downto 0 );
    clk : in std_logic;
    bandwidthselector_aresetn : in std_logic;
    bandwidthselector_s_axi_awaddr : in std_logic_vector( 4-1 downto 0 );
    bandwidthselector_s_axi_awvalid : in std_logic;
    bandwidthselector_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    bandwidthselector_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    bandwidthselector_s_axi_wvalid : in std_logic;
    bandwidthselector_s_axi_bready : in std_logic;
    bandwidthselector_s_axi_araddr : in std_logic_vector( 4-1 downto 0 );
    bandwidthselector_s_axi_arvalid : in std_logic;
    bandwidthselector_s_axi_rready : in std_logic;
    m_axis_im_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_im_tvalid : out std_logic_vector( 1-1 downto 0 );
    m_axis_re_tdata : out std_logic_vector( 16-1 downto 0 );
    m_axis_re_tvalid : out std_logic_vector( 1-1 downto 0 );
    s_axis_config_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_im_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_re_tready : out std_logic_vector( 1-1 downto 0 );
    s_axis_reload_tready : out std_logic_vector( 1-1 downto 0 );
    bandwidthselector_s_axi_awready : out std_logic;
    bandwidthselector_s_axi_wready : out std_logic;
    bandwidthselector_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    bandwidthselector_s_axi_bvalid : out std_logic;
    bandwidthselector_s_axi_arready : out std_logic;
    bandwidthselector_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    bandwidthselector_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    bandwidthselector_s_axi_rvalid : out std_logic
  );
end bandwidthselector;
architecture structural of bandwidthselector is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "bandwidthselector,sysgen_core_2019_1,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplusRFSOC,part=xczu28dr,speed=-2-e,package=ffvg1517,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=3.90625,system_simulink_period=3.90625e-09,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=inf,constant=1,convert=2,counter=1,delay=2,fir_compiler_v7_2=2,logical=6,mux=2,register=1,relational=2,slice=1,}";
  signal event_missing : std_logic_vector( 1-1 downto 0 );
  signal fir_enable : std_logic_vector( 8-1 downto 0 );
  signal event_unexpected : std_logic_vector( 1-1 downto 0 );
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
  signal downsample_factor : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
begin
  bandwidthselector_axi_lite_interface : entity xil_defaultlib.bandwidthselector_axi_lite_interface 
  port map (
    event_missing => event_missing,
    event_unexpected => event_unexpected,
    bandwidthselector_s_axi_awaddr => bandwidthselector_s_axi_awaddr,
    bandwidthselector_s_axi_awvalid => bandwidthselector_s_axi_awvalid,
    bandwidthselector_s_axi_wdata => bandwidthselector_s_axi_wdata,
    bandwidthselector_s_axi_wstrb => bandwidthselector_s_axi_wstrb,
    bandwidthselector_s_axi_wvalid => bandwidthselector_s_axi_wvalid,
    bandwidthselector_s_axi_bready => bandwidthselector_s_axi_bready,
    bandwidthselector_s_axi_araddr => bandwidthselector_s_axi_araddr,
    bandwidthselector_s_axi_arvalid => bandwidthselector_s_axi_arvalid,
    bandwidthselector_s_axi_rready => bandwidthselector_s_axi_rready,
    bandwidthselector_aresetn => bandwidthselector_aresetn,
    bandwidthselector_aclk => clk,
    fir_enable => fir_enable,
    downsample_factor => downsample_factor,
    bandwidthselector_s_axi_awready => bandwidthselector_s_axi_awready,
    bandwidthselector_s_axi_wready => bandwidthselector_s_axi_wready,
    bandwidthselector_s_axi_bresp => bandwidthselector_s_axi_bresp,
    bandwidthselector_s_axi_bvalid => bandwidthselector_s_axi_bvalid,
    bandwidthselector_s_axi_arready => bandwidthselector_s_axi_arready,
    bandwidthselector_s_axi_rdata => bandwidthselector_s_axi_rdata,
    bandwidthselector_s_axi_rresp => bandwidthselector_s_axi_rresp,
    bandwidthselector_s_axi_rvalid => bandwidthselector_s_axi_rvalid,
    clk => clk_net
  );
  bandwidthselector_default_clock_driver : entity xil_defaultlib.bandwidthselector_default_clock_driver 
  port map (
    bandwidthselector_sysclk => clk_net,
    bandwidthselector_sysce => '1',
    bandwidthselector_sysclr => '0',
    bandwidthselector_clk1 => clk_1_net,
    bandwidthselector_ce1 => ce_1_net
  );
  bandwidthselector_struct : entity xil_defaultlib.bandwidthselector_struct 
  port map (
    downsample_factor => downsample_factor,
    fir_enable => fir_enable,
    s_axis_config_tdata => s_axis_config_tdata,
    s_axis_config_tvalid => s_axis_config_tvalid,
    s_axis_im_tdata => s_axis_im_tdata,
    s_axis_im_tvalid => s_axis_im_tvalid,
    s_axis_re_tdata => s_axis_re_tdata,
    s_axis_re_tvalid => s_axis_re_tvalid,
    s_axis_reload_tdata => s_axis_reload_tdata,
    s_axis_reload_tlast => s_axis_reload_tlast,
    s_axis_reload_tvalid => s_axis_reload_tvalid,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    event_missing => event_missing,
    event_unexpected => event_unexpected,
    m_axis_im_tdata => m_axis_im_tdata,
    m_axis_im_tvalid => m_axis_im_tvalid,
    m_axis_re_tdata => m_axis_re_tdata,
    m_axis_re_tvalid => m_axis_re_tvalid,
    s_axis_config_tready => s_axis_config_tready,
    s_axis_im_tready => s_axis_im_tready,
    s_axis_re_tready => s_axis_re_tready,
    s_axis_reload_tready => s_axis_reload_tready
  );
end structural;
