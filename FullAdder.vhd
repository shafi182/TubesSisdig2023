LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY FullAdder IS
PORT( A,B,Cin : IN STD_LOGIC;
 S,Cout : OUT STD_LOGIC);
END FullAdder;

ARCHITECTURE behavioral OF FullAdder IS
BEGIN
S <= A XOR B XOR Cin;
Cout <= (Cin AND (A XOR B)) OR (A AND B);
END behavioral;