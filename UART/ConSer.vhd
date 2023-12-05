library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use IEEE.numeric_std.all;
use work.all;

ENTITY ConSer IS
	PORT(
		inserial	: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		output100	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		output10	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		output1		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
END ConSer;

ARCHITECTURE behavioral OF ConSer IS


signal op100, op10, op1 : std_logic_Vector (3 downto 0);
begin 
process(inserial)

begin
--bilpertama?
IF (inserial(23 DOWNTO 20) = "0011") THEN
	op100 <= inserial(19 DOWNTO 16);
ELSE
	op100 <= "0000";
end if;

--bilkedua
IF (inserial(15 DOWNTO 12) = "0011") THEN
	op10 <= inserial(11 DOWNTO 8);
ELSE
	op10 <= "0000";
end if;

--bilketiga?
IF (inserial(7 DOWNTO 4) = "0011") THEN
	op1 <= inserial(3 DOWNTO 0);
ELSE
	op1 <= "0000";
end if;
end process;

output100 <= op100;
output10 <= op10;
output1 <= op1;
end behavioral;