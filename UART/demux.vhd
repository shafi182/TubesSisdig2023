library IEEE;  
use IEEE.std_logic_1164.all;  
use IEEE.std_logic_arith.all;  
use IEEE.std_logic_unsigned.all;  
 
entity demux is  port( 
	rst ,selektor, enable: in std_logic;  
	input: in std_logic_vector( 31 downto 0 );  
	output0, output1: out std_logic_vector( 31 downto 0 )  
	);  
	end demux;  
 
architecture demux_arc of demux is  begin  
process( enable, selektor, input , rst )  
begin  
	if( rst = '1' ) or (enable ='1') then  
		output0 <= (others=>'0') ; -- do nothing
		output1 <= (others=>'0') ; -- do nothing
	elsif selektor = '0' then  
		output0 <= input;
	else  
		output1 <= input;
	end if;  
	end process;  
end demux_arc;  
