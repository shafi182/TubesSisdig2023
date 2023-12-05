library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_arith.all;  
use IEEE.std_logic_unsigned.all;  
 
entity mux is  port( 
	rst, selektor, enable: in std_logic;  
	input0, input1: in std_logic_vector( 31 downto 0 );  
	output: out std_logic_vector( 31 downto 0 )  
	);  
	end mux;  
 
architecture mux_arc of mux is  begin  
process( enable, rst, selektor, input0, input1 )  
begin  
	if( rst = '1' ) or (enable = '1') then  
		output <= (others=>'0') ; -- do nothing  
	elsif selektor = '0' then  
		output <= input0; -- load input0  
	else  
		output <= input1; -- load result1 
	end if;  
	end process;  
end mux_arc;  
