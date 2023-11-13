LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY FullSubtractor IS
PORT( A,B,Bin : IN STD_LOGIC;
 D,Bout : OUT STD_LOGIC);
END FullSubtractor;

ARCHITECTURE behavioral OF FullSubtractor IS
BEGIN
D <= A XOR B XOR Bin;
Bout <= (B AND Bin) OR ((not A) AND Bin) OR ((not A) AND B) ;
END behavioral;