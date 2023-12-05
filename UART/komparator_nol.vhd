library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_arith.all;  
use IEEE.std_logic_unsigned.all;  
 
entity komparator_nol is  port(  
	input: in std_logic_vector( 31 downto 0 );  
	is_nol	: out std_logic
	);
end komparator_nol;  
 
architecture comparator_arc of komparator_nol
is  begin  process(input)  begin  
	if( input = 0 ) then  
		is_nol <= '1'; 
	else  
		is_nol <= '0';  
	end if;  
	end process;  
end comparator_arc;  
