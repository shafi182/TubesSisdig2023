LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY halfSubtractor IS
PORT( A,B : IN STD_LOGIC;
D,Bout : OUT STD_LOGIC);
END halfSubtractor;

ARCHITECTURE behavioral OF halfSubtractor IS
BEGIN
D <= A XOR B;
Bout <= (not A) AND B;
END behavioral;