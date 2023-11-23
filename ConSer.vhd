library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use IEEE.numeric_std.all;
use work.all;

ENTITY ConSer IS
	PORT(
		inserial: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		output	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
END ConSer;

ARCHITECTURE behavioral OF ConSer IS


signal op : std_logic_Vector (3 downto 0);
begin 
process(inserial , op )
begin
IF (inserial(7 DOWNTO 4) = "0011") THEN
	op(3 DOWNTO 0) <= inserial(3 DOWNTO 0);
end if;

output <= op;

end process;

end behavioral;