library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use IEEE.numeric_std.all;
use work.all;

entity ConvertInput is
	port ( reg1 : in std_logic_vector (3 downto 0);
		   reg2 : in std_logic_vector (3 downto 0);
		   reg3 : in std_logic_vector (3 downto 0);
		   output : out std_logic_vector (31 downto 0)
		   );
end ConvertInput;

architecture kerja of ConvertInput is
begin
output (11 downto 0)<= (reg1 * "1010" * "1010") + reg2 * "1010" + reg3;
end kerja;