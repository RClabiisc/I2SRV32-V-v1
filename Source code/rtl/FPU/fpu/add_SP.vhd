--------------------------------------------------------------------------------
--                    RightShifter_24_by_max_26_comb_uid4
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2011)
--------------------------------------------------------------------------------
-- combinatorial

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifter_24_by_max_26_comb_uid4 is
   port ( X : in  std_logic_vector(23 downto 0);
          S : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(49 downto 0)   );
end entity;

architecture arch of RightShifter_24_by_max_26_comb_uid4 is
signal level0 :  std_logic_vector(23 downto 0);
signal ps :  std_logic_vector(4 downto 0);
signal level1 :  std_logic_vector(24 downto 0);
signal level2 :  std_logic_vector(26 downto 0);
signal level3 :  std_logic_vector(30 downto 0);
signal level4 :  std_logic_vector(38 downto 0);
signal level5 :  std_logic_vector(54 downto 0);
begin
   level0<= X;
   ps<= S;
   level1<=  (0 downto 0 => '0') & level0 when ps(0) = '1' else    level0 & (0 downto 0 => '0');
   level2<=  (1 downto 0 => '0') & level1 when ps(1) = '1' else    level1 & (1 downto 0 => '0');
   level3<=  (3 downto 0 => '0') & level2 when ps(2) = '1' else    level2 & (3 downto 0 => '0');
   level4<=  (7 downto 0 => '0') & level3 when ps(3) = '1' else    level3 & (7 downto 0 => '0');
   level5<=  (15 downto 0 => '0') & level4 when ps(4) = '1' else    level4 & (15 downto 0 => '0');
   R <= level5(54 downto 5);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_27_f400_uid8
--                     (IntAdderClassical_27_comb_uid10)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- combinatorial

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_27_f400_uid8 is
   port ( X : in  std_logic_vector(26 downto 0);
          Y : in  std_logic_vector(26 downto 0);
          Cin : in  std_logic;
          R : out  std_logic_vector(26 downto 0)   );
end entity;

architecture arch of IntAdder_27_f400_uid8 is
begin
   --Classical
    R <= X + Y + Cin;
end architecture;

--------------------------------------------------------------------------------
--                 LZCShifter_28_to_28_counting_32_comb_uid16
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007)
--------------------------------------------------------------------------------
-- combinatorial

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZCShifter_28_to_28_counting_32_comb_uid16 is
   port ( I : in  std_logic_vector(27 downto 0);
          Count : out  std_logic_vector(4 downto 0);
          O : out  std_logic_vector(27 downto 0)   );
end entity;

architecture arch of LZCShifter_28_to_28_counting_32_comb_uid16 is
signal level5 :  std_logic_vector(27 downto 0);
signal count4 :  std_logic;
signal level4 :  std_logic_vector(27 downto 0);
signal count3 :  std_logic;
signal level3 :  std_logic_vector(27 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(27 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(27 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(27 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   level5 <= I ;
   count4<= '1' when level5(27 downto 12) = (27 downto 12=>'0') else '0';
   level4<= level5(27 downto 0) when count4='0' else level5(11 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(27 downto 20) = (27 downto 20=>'0') else '0';
   level3<= level4(27 downto 0) when count3='0' else level4(19 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(27 downto 24) = (27 downto 24=>'0') else '0';
   level2<= level3(27 downto 0) when count2='0' else level3(23 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(27 downto 26) = (27 downto 26=>'0') else '0';
   level1<= level2(27 downto 0) when count1='0' else level2(25 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(27 downto 27) = (27 downto 27=>'0') else '0';
   level0<= level1(27 downto 0) when count0='0' else level1(26 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count4 & count3 & count2 & count1 & count0;
   Count <= sCount;
end architecture;



--------------------------------------------------------------------------------
--                            FPAdd_8_23_comb_uid2
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2010)
--------------------------------------------------------------------------------
-- combinatorial

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPAdd_8_23_comb_uid2 is
   port ( X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          RM : in std_logic_vector(2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0);
          INEXACT : out  std_logic );
end entity;

architecture arch of FPAdd_8_23_comb_uid2 is
   component RightShifter_24_by_max_26_comb_uid4 is
      port ( X : in  std_logic_vector(23 downto 0);
             S : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(49 downto 0)   );
   end component;

   component IntAdder_27_f400_uid8 is
      port ( X : in  std_logic_vector(26 downto 0);
             Y : in  std_logic_vector(26 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(26 downto 0)   );
   end component;

   component LZCShifter_28_to_28_counting_32_comb_uid16 is
      port ( I : in  std_logic_vector(27 downto 0);
             Count : out  std_logic_vector(4 downto 0);
             O : out  std_logic_vector(27 downto 0)   );
   end component;

   component IntAdder_34_f400_uid20 is
      port ( X : in  std_logic_vector(33 downto 0);
             Y : in  std_logic_vector(33 downto 0);
             Cin : in  std_logic;
             R : out  std_logic_vector(33 downto 0)   );
   end component;
   
   component Rounding_Mode_SP is
      port (
            EXP_FRAC : in std_logic_vector(32 downto 0);
            Rounding_Mode : in std_logic_vector(2 downto 0);
            Guard_Bits : in std_logic_vector(2 downto 0);
            Sign : in  std_logic;
            OUT_EXP_FRAC : out  std_logic_vector(32 downto 0);
            INEXACT : out  std_logic 
            );
    end component;

signal excExpFracX :  std_logic_vector(32 downto 0);
signal excExpFracY :  std_logic_vector(32 downto 0);
signal eXmeY :  std_logic_vector(8 downto 0);
signal eYmeX :  std_logic_vector(8 downto 0);
signal swap :  std_logic;
signal newX :  std_logic_vector(33 downto 0);
signal newY :  std_logic_vector(33 downto 0);
signal expX :  std_logic_vector(7 downto 0);
signal excX :  std_logic_vector(1 downto 0);
signal excY :  std_logic_vector(1 downto 0);
signal signX :  std_logic;
signal signY :  std_logic;
signal EffSub :  std_logic;
signal sXsYExnXY :  std_logic_vector(5 downto 0);
signal sdExnXY :  std_logic_vector(3 downto 0);
signal fracY :  std_logic_vector(23 downto 0);
signal excRt :  std_logic_vector(1 downto 0);
signal signR :  std_logic;
signal expDiff :  std_logic_vector(8 downto 0);
signal shiftedOut :  std_logic;
signal shiftVal :  std_logic_vector(4 downto 0);
signal shiftedFracY :  std_logic_vector(49 downto 0);
signal sticky :  std_logic;
signal fracYfar :  std_logic_vector(26 downto 0);
signal EffSubVector :  std_logic_vector(26 downto 0);
signal fracYfarXorOp :  std_logic_vector(26 downto 0);
signal fracXfar :  std_logic_vector(26 downto 0);
signal cInAddFar :  std_logic;
signal fracAddResult :  std_logic_vector(26 downto 0);
signal fracGRS :  std_logic_vector(27 downto 0);
signal extendedExpInc :  std_logic_vector(9 downto 0);
signal nZerosNew :  std_logic_vector(4 downto 0);
signal shiftedFrac :  std_logic_vector(27 downto 0);
signal updatedExp :  std_logic_vector(9 downto 0);
signal eqdiffsign :  std_logic;
signal expFrac :  std_logic_vector(33 downto 0);
signal stk :  std_logic;
signal rnd :  std_logic;
signal grd :  std_logic;
signal lsb :  std_logic;
signal addToRoundBit :  std_logic;
signal RoundedExpFrac :  std_logic_vector(33 downto 0);
signal upExc :  std_logic_vector(1 downto 0);
signal fracR :  std_logic_vector(22 downto 0);
signal expR :  std_logic_vector(7 downto 0);
signal exExpExc :  std_logic_vector(3 downto 0);
signal excRt2 :  std_logic_vector(1 downto 0);
signal excR :  std_logic_vector(1 downto 0);
signal signR2 :  std_logic;
signal computedR :  std_logic_vector(33 downto 0);
signal Guard_Bits :  std_logic_vector(2 downto 0);
begin
-- Exponent difference and swap  --
   excExpFracX <= X(33 downto 32) & X(30 downto 0);
   excExpFracY <= Y(33 downto 32) & Y(30 downto 0);
   eXmeY <= ("0" & X(30 downto 23)) - ("0" & Y(30 downto 23));
   eYmeX <= ("0" & Y(30 downto 23)) - ("0" & X(30 downto 23));
   swap <= '0' when excExpFracX >= excExpFracY else '1';
   newX <= X when swap = '0' else Y;
   newY <= Y when swap = '0' else X;
   expX<= newX(30 downto 23);
   excX<= newX(33 downto 32);
   excY<= newY(33 downto 32);
   signX<= newX(31);
   signY<= newY(31);
   EffSub <= signX xor signY;
   sXsYExnXY <= signX & signY & excX & excY;
   sdExnXY <= excX & excY;
   fracY <= "000000000000000000000000" when excY="00" else ('1' & newY(22 downto 0));
   with sXsYExnXY select 
   excRt <= "00" when "000000"|"010000"|"100000"|"110000",
      "01" when "000101"|"010101"|"100101"|"110101"|"000100"|"010100"|"100100"|"110100"|"000001"|"010001"|"100001"|"110001",
      "10" when "111010"|"001010"|"001000"|"011000"|"101000"|"111000"|"000010"|"010010"|"100010"|"110010"|"001001"|"011001"|"101001"|"111001"|"000110"|"010110"|"100110"|"110110", 
      "11" when others;
   signR<= '0' when (sXsYExnXY="100000" or sXsYExnXY="010000") else signX;
   expDiff <= eXmeY when swap = '0' else eYmeX;
   shiftedOut <= '1' when (expDiff >= 25) else '0';
   shiftVal <= expDiff(4 downto 0) when shiftedOut='0' else CONV_STD_LOGIC_VECTOR(26,5) ;
   RightShifterComponent: RightShifter_24_by_max_26_comb_uid4
      port map ( R => shiftedFracY,
                 S => shiftVal,
                 X => fracY);
   sticky <= '0' when (shiftedFracY(23 downto 0)=CONV_STD_LOGIC_VECTOR(0,24)) else '1';
   fracYfar <= "0" & shiftedFracY(49 downto 24);
   EffSubVector <= (26 downto 0 => EffSub);
   fracYfarXorOp <= fracYfar xor EffSubVector;
   fracXfar <= "01" & (newX(22 downto 0)) & "00";
   cInAddFar <= EffSub and not sticky;
   fracAdder: IntAdder_27_f400_uid8
      port map ( Cin => cInAddFar,
                 R => fracAddResult,
                 X => fracXfar,
                 Y => fracYfarXorOp);
   fracGRS<= fracAddResult & sticky; 
   extendedExpInc<= ("00" & expX) + '1';
   LZC_component: LZCShifter_28_to_28_counting_32_comb_uid16
      port map ( Count => nZerosNew,
                 I => fracGRS,
                 O => shiftedFrac);
   updatedExp <= extendedExpInc - ("00000" & nZerosNew);
   eqdiffsign <= '1' when nZerosNew="11111" else '0';
   expFrac<= updatedExp & shiftedFrac(26 downto 3);
   stk<= shiftedFrac(1) or shiftedFrac(0);
   rnd<= shiftedFrac(2);
   grd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   Guard_Bits <= (grd & rnd & stk);
    rounding : Rounding_Mode_SP
    port map (  EXP_FRAC => expFrac(33 downto 1),
                Rounding_Mode => RM,
                Guard_Bits => Guard_Bits,
                Sign => signR2,
                OUT_EXP_FRAC => RoundedExpFrac(33 downto 1),
                INEXACT => INEXACT
                );
   --addToRoundBit<= '0' when (lsb='0' and grd='1' and rnd='0' and stk='0')  else '1';
   --roundingAdder: IntAdder_34_f400_uid20
    --  port map ( Cin => addToRoundBit,
      --           R => RoundedExpFrac,
        --         X => expFrac,
          --       Y => "0000000000000000000000000000000000");
   upExc <= RoundedExpFrac(33 downto 32);
   fracR <= RoundedExpFrac(23 downto 1);
   expR <= RoundedExpFrac(31 downto 24);
   exExpExc <= upExc & excRt;
   with (exExpExc) select 
   excRt2<= "00" when "0000"|"0100"|"1000"|"1100"|"1001"|"1101",
      "01" when "0001",
      "10" when "0010"|"0110"|"1010"|"1110"|"0101",
      "11" when others;
   excR <= "11" when (EffSub='1' and excX="10" and excY="10") else
           "00" when (eqdiffsign='1' and EffSub='1') else excRt2;
   signR2 <= '0' when (eqdiffsign='1' and EffSub='1') else signR;
   computedR <= excR & signR2 & expR & fracR;
   R <= computedR;
end architecture;