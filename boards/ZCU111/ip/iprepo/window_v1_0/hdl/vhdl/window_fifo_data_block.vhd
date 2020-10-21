-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\simple_window\window_fifo_data_block.vhd
-- Created: 2020-10-19 10:59:06
-- 
-- Generated by MATLAB 9.8 and HDL Coder 3.16
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: window_fifo_data_block
-- Source Path: window/window_axi4_stream_real_slave/window_fifo_data
-- Hierarchy Level: 2
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY window_fifo_data_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        In_rsvd                           :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        Push                              :   IN    std_logic;  -- ufix1
        Pop                               :   IN    std_logic;  -- ufix1
        Out_rsvd                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- ufix16
        Empty                             :   OUT   std_logic;  -- ufix1
        Full                              :   OUT   std_logic  -- ufix1
        );
END window_fifo_data_block;


ARCHITECTURE rtl OF window_fifo_data_block IS

  -- Component Declarations
  COMPONENT window_SimpleDualPortRAM_generic
    GENERIC( AddrWidth                    : integer;
             DataWidth                    : integer
             );
    PORT( clk                             :   IN    std_logic;
          enb                             :   IN    std_logic;
          wr_din                          :   IN    std_logic_vector(DataWidth - 1 DOWNTO 0);  -- generic width
          wr_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          wr_en                           :   IN    std_logic;  -- ufix1
          rd_addr                         :   IN    std_logic_vector(AddrWidth - 1 DOWNTO 0);  -- generic width
          rd_dout                         :   OUT   std_logic_vector(DataWidth - 1 DOWNTO 0)  -- generic width
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : window_SimpleDualPortRAM_generic
    USE ENTITY work.window_SimpleDualPortRAM_generic(rtl);

  -- Signals
  SIGNAL R_x                              : std_logic;  -- ufix1
  SIGNAL cache_wr_en                      : std_logic;  -- ufix1
  SIGNAL out_wr_en                        : std_logic;  -- ufix1
  SIGNAL fwft_wr_en                       : std_logic;  -- ufix1
  SIGNAL R_x_1                            : std_logic;  -- ufix1
  SIGNAL fifo_valid                       : std_logic;  -- ufix1
  SIGNAL Q_keep                           : std_logic;  -- ufix1
  SIGNAL out_valid                        : std_logic;  -- ufix1
  SIGNAL fifo_and_out_valid               : std_logic;  -- ufix1
  SIGNAL R_x_2                            : std_logic;  -- ufix1
  SIGNAL cache_valid                      : std_logic;  -- ufix1
  SIGNAL Q_keep_1                         : std_logic;  -- ufix1
  SIGNAL relop_relop1                     : std_logic;
  SIGNAL Q_next                           : std_logic;  -- ufix1
  SIGNAL all_valid                        : std_logic;  -- ufix1
  SIGNAL Full_1                           : std_logic;  -- ufix1
  SIGNAL fifo_nfull                       : std_logic;  -- ufix1
  SIGNAL fifo_push                        : std_logic;  -- ufix1
  SIGNAL fifo_pop                         : std_logic;  -- ufix1
  SIGNAL fifo_front_indx                  : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_front_dir                   : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_back_indx                   : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_back_dir                    : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_sample_count                : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL fifo_front_indx_next             : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_front_dir_next              : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_back_indx_next              : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_back_dir_next               : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_sample_count_next           : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL fifo_out3                        : std_logic;
  SIGNAL fifo_out4                        : std_logic;
  SIGNAL fifo_write_enable                : std_logic;
  SIGNAL fifo_read_enable                 : std_logic;
  SIGNAL fifo_front_indx_temp             : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL fifo_back_indx_temp              : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL w_waddr                          : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL w_we                             : std_logic;  -- ufix1
  SIGNAL w_raddr                          : unsigned(1 DOWNTO 0);  -- ufix2
  SIGNAL Empty_1                          : std_logic;  -- ufix1
  SIGNAL Num                              : unsigned(2 DOWNTO 0);  -- ufix3
  SIGNAL Q_next_1                         : std_logic;  -- ufix1
  SIGNAL int_valid                        : std_logic;  -- ufix1
  SIGNAL Q_keep_2                         : std_logic;  -- ufix1
  SIGNAL Q_next_2                         : std_logic;  -- ufix1
  SIGNAL Empty_2                          : std_logic;  -- ufix1
  SIGNAL data_flow                        : std_logic;  -- ufix1
  SIGNAL w_cz                             : std_logic;
  SIGNAL w_const                          : std_logic;  -- ufix1
  SIGNAL w_mux1                           : std_logic;  -- ufix1
  SIGNAL w_d1                             : std_logic;  -- ufix1
  SIGNAL w_waddr_1                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL w_waddr_unsigned                 : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL w_d2                             : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL w_out                            : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL cache_data                       : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL data_out_next                    : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL Out_tmp                          : unsigned(15 DOWNTO 0);  -- ufix16

BEGIN
  -- us1: Upsample by 1, Sample offset 0 
  u_window_fifo_data_classic_ram : window_SimpleDualPortRAM_generic
    GENERIC MAP( AddrWidth => 2,
                 DataWidth => 16
                 )
    PORT MAP( clk => clk,
              enb => enb,
              wr_din => In_rsvd,
              wr_addr => std_logic_vector(w_waddr),
              wr_en => w_we,  -- ufix1
              rd_addr => std_logic_vector(w_raddr),
              rd_dout => w_waddr_1
              );

  R_x <=  NOT Pop;

  fwft_wr_en <= cache_wr_en OR out_wr_en;

  R_x_1 <=  NOT fwft_wr_en;

  Q_keep <= R_x_1 AND fifo_valid;

  fifo_and_out_valid <= fifo_valid AND out_valid;

  R_x_2 <=  NOT out_wr_en;

  Q_keep_1 <= R_x_2 AND cache_valid;

  
  relop_relop1 <= '1' WHEN cache_valid = out_wr_en ELSE
      '0';

  cache_wr_en <= relop_relop1 AND fifo_valid;

  Q_next <= cache_wr_en OR Q_keep_1;

  Q_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cache_valid <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        cache_valid <= Q_next;
      END IF;
    END IF;
  END PROCESS Q_reg_process;


  all_valid <= cache_valid AND fifo_and_out_valid;

  fifo_nfull <=  NOT Full_1;

  -- us2: Upsample by 1, Sample offset 0 
  fifo_push <= Push AND fifo_nfull;

  -- FIFO logic controller
  fifo_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fifo_front_indx <= to_unsigned(16#0#, 2);
      fifo_front_dir <= to_unsigned(16#1#, 2);
      fifo_back_indx <= to_unsigned(16#0#, 2);
      fifo_back_dir <= to_unsigned(16#1#, 2);
      fifo_sample_count <= to_unsigned(16#0#, 3);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        fifo_front_indx <= fifo_front_indx_next;
        fifo_front_dir <= fifo_front_dir_next;
        fifo_back_indx <= fifo_back_indx_next;
        fifo_back_dir <= fifo_back_dir_next;
        fifo_sample_count <= fifo_sample_count_next;
      END IF;
    END IF;
  END PROCESS fifo_process;

  
  fifo_out4 <= '1' WHEN fifo_sample_count = to_unsigned(16#4#, 3) ELSE
      '0';
  
  fifo_out3 <= '1' WHEN fifo_sample_count = to_unsigned(16#0#, 3) ELSE
      '0';
  fifo_write_enable <= fifo_push AND (fifo_pop OR ( NOT fifo_out4));
  fifo_read_enable <= fifo_pop AND ( NOT fifo_out3);
  
  fifo_front_indx_temp <= fifo_front_indx + fifo_front_dir WHEN fifo_read_enable = '1' ELSE
      fifo_front_indx;
  
  fifo_front_dir_next <= to_unsigned(16#1#, 2) WHEN fifo_front_indx_temp = to_unsigned(16#3#, 2) ELSE
      to_unsigned(16#1#, 2);
  
  fifo_back_indx_temp <= fifo_back_indx + fifo_back_dir WHEN fifo_write_enable = '1' ELSE
      fifo_back_indx;
  
  fifo_back_dir_next <= to_unsigned(16#1#, 2) WHEN fifo_back_indx_temp = to_unsigned(16#3#, 2) ELSE
      to_unsigned(16#1#, 2);
  
  fifo_sample_count_next <= fifo_sample_count + to_unsigned(16#1#, 3) WHEN (fifo_write_enable AND ( NOT fifo_read_enable)) = '1' ELSE
      fifo_sample_count + to_unsigned(16#7#, 3) WHEN (( NOT fifo_write_enable) AND fifo_read_enable) = '1' ELSE
      fifo_sample_count;
  w_waddr <= fifo_back_indx;
  w_we <= fifo_write_enable;
  w_raddr <= fifo_front_indx;
  Empty_1 <= fifo_out3;
  Full_1 <= fifo_out4;
  Num <= fifo_sample_count;
  fifo_front_indx_next <= fifo_front_indx_temp;
  fifo_back_indx_next <= fifo_back_indx_temp;

  -- us3: Upsample by 1, Sample offset 0 
  fifo_pop <=  NOT (Empty_1 OR all_valid);

  Q_next_1 <= fifo_pop OR Q_keep;

  Q_reg_1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      fifo_valid <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        fifo_valid <= Q_next_1;
      END IF;
    END IF;
  END PROCESS Q_reg_1_process;


  int_valid <= fifo_valid OR cache_valid;

  Q_keep_2 <= R_x AND out_valid;

  Q_next_2 <= out_wr_en OR Q_keep_2;

  Q_reg_2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      out_valid <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        out_valid <= Q_next_2;
      END IF;
    END IF;
  END PROCESS Q_reg_2_process;


  Empty_2 <=  NOT out_valid;

  data_flow <= Pop OR Empty_2;

  out_wr_en <= data_flow AND int_valid;

  
  w_cz <= '1' WHEN Num > to_unsigned(16#0#, 3) ELSE
      '0';

  w_const <= '0';

  
  w_mux1 <= w_const WHEN w_cz = '0' ELSE
      fifo_pop;

  f_d1_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      w_d1 <= '0';
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' THEN
        w_d1 <= w_mux1;
      END IF;
    END IF;
  END PROCESS f_d1_process;


  w_waddr_unsigned <= unsigned(w_waddr_1);

  f_d2_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      w_d2 <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND w_d1 = '1' THEN
        w_d2 <= w_waddr_unsigned;
      END IF;
    END IF;
  END PROCESS f_d2_process;


  
  w_out <= w_d2 WHEN w_d1 = '0' ELSE
      w_waddr_unsigned;

  cache_data_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      cache_data <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND cache_wr_en = '1' THEN
        cache_data <= w_out;
      END IF;
    END IF;
  END PROCESS cache_data_reg_process;


  
  data_out_next <= w_out WHEN cache_valid = '0' ELSE
      cache_data;

  out_data_reg_process : PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      Out_tmp <= to_unsigned(16#0000#, 16);
    ELSIF clk'EVENT AND clk = '1' THEN
      IF enb = '1' AND out_wr_en = '1' THEN
        Out_tmp <= data_out_next;
      END IF;
    END IF;
  END PROCESS out_data_reg_process;


  Out_rsvd <= std_logic_vector(Out_tmp);

  Full <= Full_1;

  Empty <= Empty_2;

END rtl;

