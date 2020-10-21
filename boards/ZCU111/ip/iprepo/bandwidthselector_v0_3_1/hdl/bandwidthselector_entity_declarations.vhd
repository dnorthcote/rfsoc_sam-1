-------------------------------------------------------------------
-- System Generator version 2019.1 VHDL source file.
--
-- Copyright(C) 2019 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2019 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity bandwidthselector_xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer :=  0;
           reset        : integer :=  0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));

end bandwidthselector_xldelay;

architecture behavior of bandwidthselector_xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component; -- end component synth_reg

   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;

   signal internal_ce  : std_logic;

begin
   internal_ce  <= ce and en;

   srl_delay: if ((reg_retiming = 0) and (reset = 0)) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;

   reg_delay: if ((reg_retiming = 1) or (reset = 1)) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => rst,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_6dd97b4845 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_6dd97b4845;
architecture behavior of sysgen_mux_6dd97b4845
is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlslice.vhd
--
--  Description   : VHDL description of a block that sets the output to a
--                  specified range of the input bits. The output is always
--                  set to an unsigned type with it's binary point at zero.
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity bandwidthselector_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end bandwidthselector_xlslice;

architecture behavior of bandwidthselector_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

--$Header: /devl/xcs/repo/env/Jobs/sysgen/src/xbs/blocks/xlconvert/hdl/xlconvert.vhd,v 1.1 2004/11/22 00:17:30 rosty Exp $
---------------------------------------------------------------------
--
--  Filename      : xlconvert.vhd
--
--  Description   : VHDL description of a fixed point converter block that
--                  converts the input to a new output type.

--
---------------------------------------------------------------------


---------------------------------------------------------------------
--
--  Entity        : xlconvert
--
--  Architecture  : behavior
--
--  Description   : Top level VHDL description of fixed point conver block.
--
---------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity convert_func_call_bandwidthselector_xlconvert is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        result : out std_logic_vector (dout_width-1 downto 0));
end convert_func_call_bandwidthselector_xlconvert ;

architecture behavior of convert_func_call_bandwidthselector_xlconvert is
begin
    -- Convert to output type and do saturation arith.
    result <= convert_type(din, din_width, din_bin_pt, din_arith,
                           dout_width, dout_bin_pt, dout_arith,
                           quantization, overflow);
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity bandwidthselector_xlconvert  is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        en_width     : integer := 1;
        en_bin_pt    : integer := 0;
        en_arith     : integer := xlUnsigned;
        bool_conversion : integer :=0;           -- if one, convert ufix_1_0 to
                                                 -- bool
        latency      : integer := 0;             -- Ouput delay clk cycles
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        en  : in std_logic_vector (en_width-1 downto 0);
        ce  : in std_logic;
        clr : in std_logic;
        clk : in std_logic;
        dout : out std_logic_vector (dout_width-1 downto 0));

end bandwidthselector_xlconvert ;

architecture behavior of bandwidthselector_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_bandwidthselector_xlconvert 
        generic (
            din_width    : integer := 16;            -- Width of input
            din_bin_pt   : integer := 4;             -- Binary point of input
            din_arith    : integer := xlUnsigned;    -- Type of arith of input
            dout_width   : integer := 8;             -- Width of output
            dout_bin_pt  : integer := 2;             -- Binary point of output
            dout_arith   : integer := xlUnsigned;    -- Type of arith of output
            quantization : integer := xlTruncate;    -- xlRound or xlTruncate
            overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
        port (
            din : in std_logic_vector (din_width-1 downto 0);
            result : out std_logic_vector (dout_width-1 downto 0));
    end component;


    -- synthesis translate_off
--    signal real_din, real_dout : real;    -- For debugging info ports
    -- synthesis translate_on
    signal result : std_logic_vector(dout_width-1 downto 0);
    signal internal_ce : std_logic;

begin

    -- Debugging info for internal full precision variables
    -- synthesis translate_off
--     real_din <= to_real(din, din_bin_pt, din_arith);
--     real_dout <= to_real(dout, dout_bin_pt, dout_arith);
    -- synthesis translate_on

    internal_ce <= ce and en(0);

    bool_conversion_generate : if (bool_conversion = 1)
    generate
      result <= din;
    end generate; --bool_conversion_generate

    std_conversion_generate : if (bool_conversion = 0)
    generate
      -- Workaround for XST bug
      convert : convert_func_call_bandwidthselector_xlconvert 
        generic map (
          din_width   => din_width,
          din_bin_pt  => din_bin_pt,
          din_arith   => din_arith,
          dout_width  => dout_width,
          dout_bin_pt => dout_bin_pt,
          dout_arith  => dout_arith,
          quantization => quantization,
          overflow     => overflow)
        port map (
          din => din,
          result => result);
    end generate; --std_conversion_generate

    latency_test : if (latency > 0) generate
        reg : synth_reg
            generic map (
              width => dout_width,
              latency => latency
            )
            port map (
              i => result,
              ce => internal_ce,
              clr => clr,
              clk => clk,
              o => dout
            );
    end generate;

    latency0 : if (latency = 0)
    generate
        dout <= result;
    end generate latency0;

end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_4705477838 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_4705477838;
architecture behavior of sysgen_logical_4705477838
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_300d966a4c is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_300d966a4c;
architecture behavior of sysgen_logical_300d966a4c
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_b76f44cae2 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_b76f44cae2;
architecture behavior of sysgen_constant_b76f44cae2
is
begin
  op <= "0";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlregister.vhd
--
--  Description   : VHDL description of an arbitrary wide register.
--                  Unlike the delay block, an initial value is
--                  specified and is considered valid at the start
--                  of simulation.  The register is only one word
--                  deep.
--
--  Mod. History  : Removed valid bit logic from wrapper.
--                : Changed VHDL to use a bit_vector generic for its
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity bandwidthselector_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end bandwidthselector_xlregister;

architecture behavior of bandwidthselector_xlregister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   -- synthesis translate_off
   signal real_d, real_q           : real;    -- For debugging info ports
   -- synthesis translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;

begin

   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;

   -- Synthesizable behavioral model
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);

end architecture behavior;


library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_06ed39ed8d is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((32 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_06ed39ed8d;
architecture behavior of sysgen_relational_06ed39ed8d
is
  signal a_1_31: unsigned((16 - 1) downto 0);
  signal b_1_34: unsigned((32 - 1) downto 0);
  signal cast_12_12: unsigned((32 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_12 <= u2u_cast(a_1_31, 0, 32, 0);
  result_12_3_rel <= cast_12_12 = b_1_34;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_33f27f7ea3 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_33f27f7ea3;
architecture behavior of sysgen_relational_33f27f7ea3
is
  signal a_1_31: unsigned((16 - 1) downto 0);
  signal b_1_34: unsigned((1 - 1) downto 0);
  signal cast_12_17: unsigned((16 - 1) downto 0);
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  cast_12_17 <= u2u_cast(b_1_34, 0, 16, 0);
  result_12_3_rel <= a_1_31 = cast_12_17;
  op <= boolean_to_vector(result_12_3_rel);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity bandwidthselector_axi_lite_interface is 
    port(
        fir_enable : out std_logic_vector(7 downto 0);
        downsample_factor : out std_logic_vector(31 downto 0);
        event_missing : in std_logic_vector(0 downto 0);
        event_unexpected : in std_logic_vector(0 downto 0);
        clk : out std_logic;
        bandwidthselector_aclk : in std_logic;
        bandwidthselector_aresetn : in std_logic;
        bandwidthselector_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        bandwidthselector_s_axi_awvalid : in std_logic;
        bandwidthselector_s_axi_awready : out std_logic;
        bandwidthselector_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        bandwidthselector_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        bandwidthselector_s_axi_wvalid : in std_logic;
        bandwidthselector_s_axi_wready : out std_logic;
        bandwidthselector_s_axi_bresp : out std_logic_vector(1 downto 0);
        bandwidthselector_s_axi_bvalid : out std_logic;
        bandwidthselector_s_axi_bready : in std_logic;
        bandwidthselector_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        bandwidthselector_s_axi_arvalid : in std_logic;
        bandwidthselector_s_axi_arready : out std_logic;
        bandwidthselector_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        bandwidthselector_s_axi_rresp : out std_logic_vector(1 downto 0);
        bandwidthselector_s_axi_rvalid : out std_logic;
        bandwidthselector_s_axi_rready : in std_logic
    );
end bandwidthselector_axi_lite_interface;
architecture structural of bandwidthselector_axi_lite_interface is 
component bandwidthselector_axi_lite_interface_verilog is
    port(
        fir_enable : out std_logic_vector(7 downto 0);
        downsample_factor : out std_logic_vector(31 downto 0);
        event_missing : in std_logic_vector(0 downto 0);
        event_unexpected : in std_logic_vector(0 downto 0);
        clk : out std_logic;
        bandwidthselector_aclk : in std_logic;
        bandwidthselector_aresetn : in std_logic;
        bandwidthselector_s_axi_awaddr : in std_logic_vector(4-1 downto 0);
        bandwidthselector_s_axi_awvalid : in std_logic;
        bandwidthselector_s_axi_awready : out std_logic;
        bandwidthselector_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        bandwidthselector_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        bandwidthselector_s_axi_wvalid : in std_logic;
        bandwidthselector_s_axi_wready : out std_logic;
        bandwidthselector_s_axi_bresp : out std_logic_vector(1 downto 0);
        bandwidthselector_s_axi_bvalid : out std_logic;
        bandwidthselector_s_axi_bready : in std_logic;
        bandwidthselector_s_axi_araddr : in std_logic_vector(4-1 downto 0);
        bandwidthselector_s_axi_arvalid : in std_logic;
        bandwidthselector_s_axi_arready : out std_logic;
        bandwidthselector_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        bandwidthselector_s_axi_rresp : out std_logic_vector(1 downto 0);
        bandwidthselector_s_axi_rvalid : out std_logic;
        bandwidthselector_s_axi_rready : in std_logic
    );
end component;
begin
inst : bandwidthselector_axi_lite_interface_verilog
    port map(
    fir_enable => fir_enable,
    downsample_factor => downsample_factor,
    event_missing => event_missing,
    event_unexpected => event_unexpected,
    clk => clk,
    bandwidthselector_aclk => bandwidthselector_aclk,
    bandwidthselector_aresetn => bandwidthselector_aresetn,
    bandwidthselector_s_axi_awaddr => bandwidthselector_s_axi_awaddr,
    bandwidthselector_s_axi_awvalid => bandwidthselector_s_axi_awvalid,
    bandwidthselector_s_axi_awready => bandwidthselector_s_axi_awready,
    bandwidthselector_s_axi_wdata => bandwidthselector_s_axi_wdata,
    bandwidthselector_s_axi_wstrb => bandwidthselector_s_axi_wstrb,
    bandwidthselector_s_axi_wvalid => bandwidthselector_s_axi_wvalid,
    bandwidthselector_s_axi_wready => bandwidthselector_s_axi_wready,
    bandwidthselector_s_axi_bresp => bandwidthselector_s_axi_bresp,
    bandwidthselector_s_axi_bvalid => bandwidthselector_s_axi_bvalid,
    bandwidthselector_s_axi_bready => bandwidthselector_s_axi_bready,
    bandwidthselector_s_axi_araddr => bandwidthselector_s_axi_araddr,
    bandwidthselector_s_axi_arvalid => bandwidthselector_s_axi_arvalid,
    bandwidthselector_s_axi_arready => bandwidthselector_s_axi_arready,
    bandwidthselector_s_axi_rdata => bandwidthselector_s_axi_rdata,
    bandwidthselector_s_axi_rresp => bandwidthselector_s_axi_rresp,
    bandwidthselector_s_axi_rvalid => bandwidthselector_s_axi_rvalid,
    bandwidthselector_s_axi_rready => bandwidthselector_s_axi_rready
);
end structural;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
 --
 --  Filename      : xlcounter_rst.vhd
 --
 --  Created       : 1/31/01
 --  Modified      :
 --
 --  Description   : VHDL wrapper for a counter. This wrapper
 --                  uses the Binary Counter CoreGenerator core.
 --
 ---------------------------------------------------------------------
 
 
 ---------------------------------------------------------------------
 --
 --  Entity        : xlcounter
 --
 --  Architecture  : behavior
 --
 --  Description   : Top level VHDL description of a counter.
 --
 ---------------------------------------------------------------------
 
 library IEEE;
 use IEEE.std_logic_1164.all;

entity bandwidthselector_xlcounter_free is 
   generic (
     core_name0: string := "";
     op_width: integer := 5;
     op_arith: integer := xlSigned
   );
   port (
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     op: out std_logic_vector(op_width - 1 downto 0);
     up: in std_logic_vector(0 downto 0) := (others => '0');
     load: in std_logic_vector(0 downto 0) := (others => '0');
     din: in std_logic_vector(op_width - 1 downto 0) := (others => '0');
     en: in std_logic_vector(0 downto 0);
     rst: in std_logic_vector(0 downto 0)
   );
 end bandwidthselector_xlcounter_free;
 
 architecture behavior of bandwidthselector_xlcounter_free is


 component bandwidthselector_c_counter_binary_v12_0_i0
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      q: out std_logic_vector(op_width - 1 downto 0) 
 		  ); 
 end component;

-- synthesis translate_off
   constant zeroVec: std_logic_vector(op_width - 1 downto 0) := (others => '0');
   constant oneVec: std_logic_vector(op_width - 1 downto 0) := (others => '1');
   constant zeroStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(zeroVec);
   constant oneStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(oneVec);
 -- synthesis translate_on
 
   signal core_sinit: std_logic;
   signal core_ce: std_logic;
   signal op_net: std_logic_vector(op_width - 1 downto 0);
 begin
   core_ce <= ce and en(0);
   core_sinit <= (clr or rst(0)) and ce;
   op <= op_net;


 comp0: if ((core_name0 = "bandwidthselector_c_counter_binary_v12_0_i0")) generate 
  core_instance0:bandwidthselector_c_counter_binary_v12_0_i0
   port map ( 
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
  ); 
   end generate;

end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

entity xlfir_compiler_548447858a9e7bfba9cfe6326e343584 is 
  port(
    ce:in std_logic;
    ce_logic_1:in std_logic;
    clk:in std_logic;
    clk_logic_1:in std_logic;
    event_s_reload_tlast_missing:out std_logic;
    event_s_reload_tlast_unexpected:out std_logic;
    m_axis_data_tdata_real:out std_logic_vector(39 downto 0);
    m_axis_data_tvalid:out std_logic;
    s_axis_config_tdata_data:in std_logic_vector(7 downto 0);
    s_axis_config_tready:out std_logic;
    s_axis_config_tvalid:in std_logic;
    s_axis_data_tdata_real:in std_logic_vector(15 downto 0);
    s_axis_data_tready:out std_logic;
    s_axis_reload_tdata_data:in std_logic_vector(15 downto 0);
    s_axis_reload_tlast:in std_logic;
    s_axis_reload_tready:out std_logic;
    s_axis_reload_tvalid:in std_logic;
    src_ce:in std_logic;
    src_clk:in std_logic
  );
end xlfir_compiler_548447858a9e7bfba9cfe6326e343584; 

architecture behavior of xlfir_compiler_548447858a9e7bfba9cfe6326e343584  is
  component bandwidthselector_fir_compiler_v7_2_i0
    port(
      aclk:in std_logic;
      aclken:in std_logic;
      event_s_reload_tlast_missing:out std_logic;
      event_s_reload_tlast_unexpected:out std_logic;
      m_axis_data_tdata:out std_logic_vector(39 downto 0);
      m_axis_data_tvalid:out std_logic;
      s_axis_config_tdata:in std_logic_vector(7 downto 0);
      s_axis_config_tready:out std_logic;
      s_axis_config_tvalid:in std_logic;
      s_axis_data_tdata:in std_logic_vector(15 downto 0);
      s_axis_data_tready:out std_logic;
      s_axis_data_tvalid:in std_logic;
      s_axis_reload_tdata:in std_logic_vector(15 downto 0);
      s_axis_reload_tlast:in std_logic;
      s_axis_reload_tready:out std_logic;
      s_axis_reload_tvalid:in std_logic
    );
end component;
signal m_axis_data_tdata_net: std_logic_vector(39 downto 0) := (others=>'0');
signal s_axis_config_tdata_net: std_logic_vector(7 downto 0) := (others=>'0');
signal s_axis_data_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
signal s_axis_reload_tdata_net: std_logic_vector(15 downto 0) := (others=>'0');
begin
  m_axis_data_tdata_real <= m_axis_data_tdata_net(39 downto 0);
  s_axis_config_tdata_net(7 downto 0) <= s_axis_config_tdata_data;
  s_axis_data_tdata_net(15 downto 0) <= s_axis_data_tdata_real;
  s_axis_reload_tdata_net(15 downto 0) <= s_axis_reload_tdata_data;
  bandwidthselector_fir_compiler_v7_2_i0_instance : bandwidthselector_fir_compiler_v7_2_i0
    port map(
      aclk=>clk,
      aclken=>ce,
      event_s_reload_tlast_missing=>event_s_reload_tlast_missing,
      event_s_reload_tlast_unexpected=>event_s_reload_tlast_unexpected,
      m_axis_data_tdata=>m_axis_data_tdata_net,
      m_axis_data_tvalid=>m_axis_data_tvalid,
      s_axis_config_tdata=>s_axis_config_tdata_net,
      s_axis_config_tready=>s_axis_config_tready,
      s_axis_config_tvalid=>s_axis_config_tvalid,
      s_axis_data_tdata=>s_axis_data_tdata_net,
      s_axis_data_tready=>s_axis_data_tready,
      s_axis_data_tvalid=>ce_logic_1,
      s_axis_reload_tdata=>s_axis_reload_tdata_net,
      s_axis_reload_tlast=>s_axis_reload_tlast,
      s_axis_reload_tready=>s_axis_reload_tready,
      s_axis_reload_tvalid=>s_axis_reload_tvalid
    );
end behavior;



