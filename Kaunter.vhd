LIBRARY  IEEE; 
USE  IEEE.STD_LOGIC_1164.ALL; 
USE  IEEE.STD_LOGIC_ARITH.ALL; 
USE  IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity Kaunter is
	port(
		 clockasli : in STD_Logic;
		 output : Buffer Integer
		 );
End Kaunter;

architecture behavioral of Kaunter is

begin
process(clockasli)
begin
	if ( clockasli'event and clockasli = '1') then
		output <= output + 1 ;
	end if;
end process;
end behavioral;