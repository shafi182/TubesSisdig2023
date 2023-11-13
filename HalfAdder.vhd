LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY halfadder IS
PORT( A,B : IN STD_LOGIC;
S,Cout : OUT STD_LOGIC);
END halfadder;

ARCHITECTURE behavioral OF halfadder IS
BEGIN
S <= A XOR B;
Cout <= A AND B;
END behavioral;