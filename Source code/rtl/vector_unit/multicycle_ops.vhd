--******************************************************************************
-- Copyright (c) 2014 - 2018, 2019 - 2021, Indian Institute of Science, Bangalore.
-- All Rights Reserved. See LICENSE for license details.
--------------------------------------------------------------------------------

-- Contributors
-- Naveen Chander V (naveenv@alum.iisc.ac.in)
-- Akshay Birari (akshay@alum.iisc.ac.in), Piyush Birla (piyush@alum.iisc.ac.in)
-- Suseela Budi (suseela@alum.iisc.ac.in), Pradeep Gupta (gupta@alum.iisc.ac.in)
-- Kavya Sharat (kavyasharat@alum.iisc.ac.in), Sumeet Bandishte (sumeet.bandishte30@gmail.com)
-- Kuruvilla Varghese (kuru@iisc.ac.in)


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multicycle_ops is
generic(width : integer :=32);
    Port ( 
		clk 		: in  STD_LOGIC;
        reset		: in  STD_LOGIC;
		funct		: in  STD_LOGIC_VECTOR(1 downto 0);
		op1 		: in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        op2 		: in  STD_LOGIC_VECTOR (WIDTH-1 downto 0);
        div_op	 	: out STD_LOGIC_VECTOR (31 downto 0);
		BUSY		: out STD_LOGIC;
        divbyzero 	: out STD_LOGIC;
        start 		: in  STD_LOGIC
		);
end multicycle_ops;

architecture Behavioral of multicycle_ops is
COMPONENT div_gen_0
  PORT (
    aclk 					: IN STD_LOGIC;
	aclken 					: IN STD_LOGIC;
    s_axis_divisor_tvalid 	: IN STD_LOGIC;
    s_axis_divisor_tdata 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_dividend_tvalid 	: IN STD_LOGIC;
    s_axis_dividend_tdata 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid 		: OUT STD_LOGIC;
    m_axis_dout_tuser 		: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_dout_tdata 		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
  
END COMPONENT;

COMPONENT div_gen_1
  PORT (
    aclk 					: IN STD_LOGIC;
	aclken 					: IN STD_LOGIC;
    s_axis_divisor_tvalid 	: IN STD_LOGIC;
    s_axis_divisor_tdata 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    s_axis_dividend_tvalid 	: IN STD_LOGIC;
    s_axis_dividend_tdata 	: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    m_axis_dout_tvalid 		: OUT STD_LOGIC;
    m_axis_dout_tuser 		: OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
    m_axis_dout_tdata 		: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
  );
  
END COMPONENT;

signal count_0 						: std_logic_vector(5 downto 0);
signal start_0					 	: STD_LOGIC;
signal BUSY_0					 	: STD_LOGIC;
signal s_axis_divisor_tvalid_s_0 	: STD_LOGIC;
signal s_axis_divisor_tdata_s_0 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_axis_dividend_tvalid_s_0	: STD_LOGIC;
signal s_axis_dividend_tdata_s_0 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal m_axis_dout_tvalid_s_0 		: STD_LOGIC;
signal m_axis_dout_tuser_s_0 		: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal m_axis_dout_tdata_s_0 		: STD_LOGIC_VECTOR(63 DOWNTO 0);

signal count_1 						: std_logic_vector(5 downto 0);
signal start_1					 	: STD_LOGIC;
signal BUSY_1					 	: STD_LOGIC;
signal s_axis_divisor_tvalid_s_1 	: STD_LOGIC;
signal s_axis_divisor_tdata_s_1 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_axis_dividend_tvalid_s_1	: STD_LOGIC;
signal s_axis_dividend_tdata_s_1 	: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal m_axis_dout_tvalid_s_1 		: STD_LOGIC;
signal m_axis_dout_tuser_s_1 		: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal m_axis_dout_tdata_s_1 		: STD_LOGIC_VECTOR(63 DOWNTO 0);

signal quotient_0					: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal quotient_1					: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal remainder_0					: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal remainder_1					: STD_LOGIC_VECTOR(31 DOWNTO 0);

signal divbyzero_0					: STD_LOGIC;
signal divbyzero_1					: STD_LOGIC;

begin
signed_divider: div_gen_0 port map(
	aclk 					=> 	clk 						,
	aclken					=>	start_0						,
	s_axis_divisor_tvalid 	=> 	s_axis_divisor_tvalid_s_0 	,
	s_axis_divisor_tdata 	=> 	s_axis_divisor_tdata_s_0 	,
	s_axis_dividend_tvalid 	=> 	s_axis_dividend_tvalid_s_0 	,
	s_axis_dividend_tdata 	=> 	s_axis_dividend_tdata_s_0 	,
	m_axis_dout_tvalid 		=> 	m_axis_dout_tvalid_s_0 		,
	m_axis_dout_tuser 		=> 	m_axis_dout_tuser_s_0 		,
	m_axis_dout_tdata 		=> 	m_axis_dout_tdata_s_0 		
	);

unsigned_divider: div_gen_1 port map(
	aclk 					=> 	clk 						,
	aclken					=>	start_1						,
	s_axis_divisor_tvalid 	=> 	s_axis_divisor_tvalid_s_1 	,
	s_axis_divisor_tdata 	=> 	s_axis_divisor_tdata_s_1 	,
	s_axis_dividend_tvalid 	=> 	s_axis_dividend_tvalid_s_1 	,
	s_axis_dividend_tdata 	=> 	s_axis_dividend_tdata_s_1 	,
	m_axis_dout_tvalid 		=> 	m_axis_dout_tvalid_s_1 		,
	m_axis_dout_tuser 		=> 	m_axis_dout_tuser_s_1 		,
	m_axis_dout_tdata 		=> 	m_axis_dout_tdata_s_1 		
	);
------------------------------------------------------------------
start_0 <= '1'  when start ='1' and funct(0) = '0' else '0';
start_1 <= '1'  when start ='1' and funct(0) = '1' else '0';
------------------------------------------------------------------
counter_0: process(clk,reset)
begin
	if reset = '1' then
		count_0 <= (others=>'0');
	elsif rising_edge(clk) then
		if m_axis_dout_tvalid_s_0 = '1' then
			count_0 <= (others=>'0');	-- Need to reset after every division op
		elsif start_0 = '1' then
			count_0 <= count_0 + 1;
		else
		count_0 <= (others=>'0');		-- For all instructions other than DIVIDE 
		end if;
	end if;
end process counter_0;

counter_1: process(clk,reset)
begin
	if reset = '1' then
		count_1 <= (others=>'0');
	elsif rising_edge(clk) then
		if m_axis_dout_tvalid_s_1 = '1' then
			count_1 <= (others=>'0');	-- Need to reset after every division op
		elsif start_1 = '1' then
			count_1 <= count_1 + 1;
		else
		count_1 <= (others=>'0');		-- For all instructions other than DIVIDE 
		end if;
	end if;
end process counter_1;
--------------------------------------------------------------------------------
axi_inferface_0: process(clk,reset)
begin
	if reset = '1' then
		s_axis_divisor_tvalid_s_0  	<= '0';
		s_axis_divisor_tdata_s_0   	<= (others=>'0');
		s_axis_dividend_tvalid_s_0 	<= '0';
		s_axis_dividend_tdata_s_0  	<= (others=>'0');
		quotient_0 			   	 	<= (others=>'0');
		remainder_0 			   	<= (others=>'0');
		divbyzero_0 			   	<= '0';
	elsif rising_edge(clk) then
		if count_0 = "000001"  then
			s_axis_divisor_tvalid_s_0  <= '1';
			s_axis_divisor_tdata_s_0   <= (op2);
			s_axis_dividend_tvalid_s_0 <= '1';
			s_axis_dividend_tdata_s_0  <= (op1);
		else
			s_axis_divisor_tvalid_s_0  	<= '0';
			s_axis_dividend_tvalid_s_0  <=  '0';				
		end if;
	-- Output 
		if m_axis_dout_tvalid_s_0 = '1' then
			remainder_0  <= m_axis_dout_tdata_s_0(31 downto  0);
			quotient_0 	 <= m_axis_dout_tdata_s_0(63 downto 32);
			divbyzero_0  <= m_axis_dout_tuser_s_0(0);
		end if;
	end if;
end process axi_inferface_0;

axi_inferface_1: process(clk,reset)
begin
	if reset = '1' then
		s_axis_divisor_tvalid_s_1  	<= '0';
		s_axis_divisor_tdata_s_1   	<= (others=>'0');
		s_axis_dividend_tvalid_s_1 	<= '0';
		s_axis_dividend_tdata_s_1  	<= (others=>'0');
		quotient_1			   	 	<= (others=>'0');
		remainder_1 			   	<= (others=>'0');
		divbyzero_1 			   	<= '0';
	elsif rising_edge(clk) then
		if count_1 = "000001"  then
			s_axis_divisor_tvalid_s_1  <= '1';
			s_axis_divisor_tdata_s_1   <= (op2);
			s_axis_dividend_tvalid_s_1 <= '1';
			s_axis_dividend_tdata_s_1  <= (op1);
		else
			s_axis_divisor_tvalid_s_1  	<= '0';
			s_axis_dividend_tvalid_s_1  <=  '0';				
		end if;
	-- Output 
		if m_axis_dout_tvalid_s_1 = '1' then
			remainder_1  <= m_axis_dout_tdata_s_1(31 downto  0);
			quotient_1 <= m_axis_dout_tdata_s_1(63 downto 32);
			divbyzero_1 <= m_axis_dout_tuser_s_1(0);
		end if;
	end if;
end process axi_inferface_1;

-------------------------OUtputs-------------------------------------------------------------
BUSY_0  <= (not m_axis_dout_tvalid_s_0) and start_0; -- Will be HIGH Only for One Clock Cycle when the output is valid
BUSY_1  <= (not m_axis_dout_tvalid_s_1) and start_1; -- Will be HIGH Only for One Clock Cycle when the output is valid

BUSY <= BUSY_1 when start_1 = '1' else BUSY_0;

divbyzero <= divbyzero_1 when start_1 = '1'  else divbyzero_0;
----------------------------------------------------------------------------------------
div_output_selector: process(quotient_0,quotient_1, remainder_0, remainder_1, funct)
begin
	case funct is 
		when "00"	=> div_op <= quotient_1;
		when "01"	=> div_op <= quotient_0;
		when "10"	=> div_op <= remainder_1;
		when "11"	=> div_op <= remainder_0;
		when others => div_op <= quotient_0;
	end case;
end process div_output_selector;

end Behavioral;
