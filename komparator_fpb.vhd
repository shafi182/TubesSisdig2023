library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_arith.all;  
use IEEE.std_logic_unsigned.all;  
 
entity komparator_fpb is  port(  
	a, b: in std_logic_vector( 31 downto 0 );  
	a_eq_b	: out std_logic;
	a_greaterThan_b	: out std_logic
	);
end komparator_fpb;  
 
architecture comparator_arc of komparator_fpb 
is  begin  process( a, b)  begin  
	if( a > b ) then  
		a_eq_b <= '0'; -- if a > b
		a_greaterThan_b <= '1';
	elsif( a = b ) then  
		a_eq_b <= '1'; -- if a = b
		a_greaterThan_b <= '0';
	else  
		a_eq_b <= '0'; -- if a < b
		a_greaterThan_b <= '0'; 
	end if;  
	end process;  
end comparator_arc;  
