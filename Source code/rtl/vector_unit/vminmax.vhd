-- ******************************************************************************
--  Copyright (c) 2014 - 2018, 2019 - 2021, Indian Institute of Science, Bangalore.
--  All Rights Reserved. See LICENSE for license details.
-- ------------------------------------------------------------------------------
-- 
--  Contributors
--  Naveen Chander V (naveenv@alum.iisc.ac.in)
--  Akshay Birari (akshay@alum.iisc.ac.in), Piyush Birla (piyush@alum.iisc.ac.in)
--  Suseela Budi (suseela@alum.iisc.ac.in), Pradeep Gupta (gupta@alum.iisc.ac.in)
--  Kavya Sharat (kavyasharat@alum.iisc.ac.in), Sumeet Bandishte (sumeet.bandishte30@gmail.com)
--  Kuruvilla Varghese (kuru@iisc.ac.in)



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity vminmax is
generic(width : integer :=32);
Port (
    clk       : in std_logic;
    reset     : in std_logic;
    clear     : in std_logic;
    vl        : in STD_LOGIC_VECTOR(8 downto 0);    -- Vector Length
    op2       : in signed (width-1 downto 0);
    f_minmax  : in std_logic_vector(3 downto 0); -- max_min function  
    count     : in std_logic_vector(5 downto 0); -- Vector element index
    y_minmax  : out std_logic_vector(width-1 downto 0)
 );
end vminmax;

architecture Behavioral of vminmax is

    signal max_positive :signed(width-1 downto 0);
    signal min_negative :signed(width-1 downto 0);
    
    signal unsigned_max_value : std_logic_vector(width-1 downto 0);
    signal unsigned_max_index : std_logic_vector(width-1 downto 0);
    signal unsigned_min_value : std_logic_vector(width-1 downto 0);
    signal unsigned_min_index : std_logic_vector(width-1 downto 0);
    signal signed_max_value   : signed(width-1 downto 0);
    signal signed_max_index   : std_logic_vector(width-1 downto 0);
    signal signed_min_value   : signed(width-1 downto 0);
    signal signed_min_index   : std_logic_vector(width-1 downto 0);
    
    signal signed_max         : signed(width-1 downto 0);
    signal signed_min         : signed(width-1 downto 0);
    signal unsigned_max       : std_logic_vector(width-1 downto 0);
    signal unsigned_min       : std_logic_vector(width-1 downto 0);
    
begin
    max_positive <= x"7F" when WIDTH=8 else
                    x"7FFF" when WIDTH=16 else
                    x"7FFFFFFF" ;
      
    min_negative <= x"80" when WIDTH=8 else
                    x"8000" when WIDTH=16 else
                    x"80000000" ;
    --------------------------------------------
    -- Add max,min functionality
    -- +-----------------------------------+------------------+
    -- |     Functionality                 |    f_min_max     |    
    -- +-----------------------------------+------------------+
    -- |    signed   Max Value Finder      |     1000         |
    -- |    Unsigned Max Value Finder      |     1001         |       
    -- |    Signed   Min Value Finder      |     1010         | 
    -- |    UnSigned Min Value Finder      |     1011         | 
    -- |    signed   Max Index Finder      |     1100         |     
    -- |    Unsigned Max Index Finder      |     1101         | 
    -- |    Signed   Min Index Finder      |     1110         | 
    -- |    UnSigned Min Index Finder      |     1111         | 
    -- +-----------------------------------+------------------+
    ---------------------------------------------
    -- Defining Max Min Limits
    -- ------------------------------------------
    signed_max <= max_positive;
    signed_min <= min_negative;
    
    unsigned_max <= x"FF" when WIDTH=8 else
                    x"FFFF" when WIDTH=16 else
                    x"FFFFFFFF" ;  
           
    unsigned_min <= (others=>'0');
    ---------------------------------------------
    -- 1. Unsigned Max finder -------------------
    ---------------------------------------------
    unsigned_max_finder: process(clk,reset)
    begin
        if reset = '1' then
            unsigned_max_index <= (others=>'0');
            unsigned_max_value <= unsigned_min; -- Lowest Possible UnSigned Value
        elsif rising_edge(clk) then
            if clear = '1' then
                unsigned_max_index <= (others=>'0');
                unsigned_max_value <= unsigned_min; -- Lowest Possible UnSigned Value               
            elsif f_minmax(1 downto 0) = "01"  then --Unsigned Max Finder
                if (std_logic_vector(op2)) > unsigned_max_value then
                    unsigned_max_value <= std_logic_vector(op2);
                    unsigned_max_index <= x"000000" & "00" & count;
                end if;     
            end if;
        end if;
    end process unsigned_max_finder;
    
    --------------------------------------------
    -- 2. Unsigned Min finder -------------------
    ---------------------------------------------
    unsigned_min_finder: process(clk,reset)
    begin
        if reset = '1' then
            unsigned_min_value <= unsigned_max;
            unsigned_min_index <= (others=>'0');
        elsif rising_edge(clk) then
            if clear ='1' then
                unsigned_min_value <= unsigned_max;
                unsigned_min_index <= (others=>'0');
            elsif f_minmax(1 downto 0) = "11" then --Unsigned Min Finder
                if std_logic_vector(op2) < unsigned_min_value then
                    unsigned_min_value <= std_logic_vector(op2);
                    unsigned_min_index <= x"000000" & "00" & count;
                end if;
            end if;
        end if;
    end process unsigned_min_finder;
    --------------------------------------------
    -- 3. Signed Max finder -------------------
    ---------------------------------------------
    signed_max_finder: process(clk,reset)
    begin
        if reset = '1' then
            signed_max_value <= signed_min; -- Lowest Possible Signed Value
            signed_max_index <= (others=>'0');
        elsif rising_edge(clk) then
            if clear = '1' then
                signed_max_value <= signed_min; -- Lowest Possible Signed Value
                signed_max_index <= (others=>'0');
            elsif f_minmax(1 downto 0)  = "00" then  --Unsigned Max Finder
                if op2 > signed_max_value then
                    signed_max_value <= op2;
                    signed_max_index <= (x"000000" & "00" & count);
                end if;
            end if;
        end if;
    end process signed_max_finder;
    --------------------------------------------
    -- 4. Signed Min finder -------------------
    ---------------------------------------------
    signed_min_finder: process(clk,reset)
    begin
        if reset = '1' then
            signed_min_value <= signed_max;
            signed_min_index <= (others=>'0');
        elsif rising_edge(clk) then
            if clear ='1' then
                signed_min_value <= signed_max;
                signed_min_index <= (others=>'0');
            elsif f_minmax(1 downto 0)  = "10" then --signed Min Finder
                if op2 < signed_min_value then
                    signed_min_value <= op2;
                    signed_min_index <= (x"000000" & "00" & count);
                end if;
            end if;
        end if;
    end process signed_min_finder;
    --------------------------------------------
    output_reg: process(clk,reset)
    begin
        if reset = '1' then
            y_minmax <= (others=>'0');
        elsif rising_edge(clk) then
            if (clear = '1') or (count /= (vl)) then
                y_minmax <= (others=>'0');
            else
                case (f_minmax(2 downto 0)) is
                    when "000" =>y_minmax <=  std_logic_vector(signed_max_value);
                    when "001" =>y_minmax <=  unsigned_max_value;
                    when "010" =>y_minmax <=  std_logic_vector(signed_min_value);
                    when "011" =>y_minmax <=  unsigned_min_value;
                    when "100" =>y_minmax <=  signed_max_index;
                    when "101" =>y_minmax <=  unsigned_max_index;
                    when "110" =>y_minmax <=  signed_min_index;
                    when "111" =>y_minmax <=  unsigned_min_index;
                    when others=>y_minmax <= (others=>'1');
                end case;
            end if;
        end if;
    end process output_reg;
    ----------------------------------------------
--    -- f_minmax , funt operations MUXING
--    y_minmax <= signed_max_value            when f_minmax(2 downto 0) = "000" else
--                signed(unsigned_max_value)  when f_minmax(2 downto 0) = "001" else
--                signed_min_value            when f_minmax(2 downto 0) = "010" else 
--                signed(unsigned_min_value)  when f_minmax(2 downto 0) = "011" else 
--                signed(signed_max_index)    when f_minmax(2 downto 0) = "100" else 
--                signed(unsigned_max_index)  when f_minmax(2 downto 0) = "101" else 
--                signed(signed_min_index)    when f_minmax(2 downto 0) = "110" else 
--                signed(unsigned_min_index)  when f_minmax(2 downto 0) = "111" ;
--
end Behavioral;
