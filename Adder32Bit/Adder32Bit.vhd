LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Adder32Bit IS
		PORT( 
				A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				Cout : OUT STD_LOGIC
		);
END Adder32Bit;

ARCHITECTURE behavioral OF Adder32Bit IS
		SIGNAL C : STD_LOGIC_VECTOR(31 DOWNTO 0);
		COMPONENT HalfAdder IS
			PORT( A,B : IN STD_LOGIC;
			S,Cout : OUT STD_LOGIC);
		END COMPONENT;
				
		COMPONENT fulladder IS
			PORT( A,B,Cin : IN STD_LOGIC;
			S,Cout : OUT STD_LOGIC);
		END COMPONENT;
BEGIN

HA0: halfadder PORT MAP (A=>A(0), B=>B(0),  S=>S(0), Cout=>C(0));
FA1: fulladder PORT MAP (A=>A(1), B=>B(1), Cin=>C(0), S=>S(1), Cout=>C(1));
FA2: fulladder PORT MAP (A=>A(2), B=>B(2), Cin=>C(1), S=>S(2), Cout=>C(2));
FA3: fulladder PORT MAP (A=>A(3), B=>B(3), Cin=>C(2), S=>S(3), Cout=>C(3));
FA4: fulladder PORT MAP (A=>A(4), B=>B(4), Cin=>C(3), S=>S(4), Cout=>C(4));
FA5: fulladder PORT MAP (A=>A(5), B=>B(5), Cin=>C(4), S=>S(5), Cout=>C(5));
FA6: fulladder PORT MAP (A=>A(6), B=>B(6), Cin=>C(5), S=>S(6), Cout=>C(6));
FA7: fulladder PORT MAP (A=>A(7), B=>B(7), Cin=>C(6), S=>S(7), Cout=>C(7));
FA8: fulladder PORT MAP (A=>A(8), B=>B(8), Cin=>C(7), S=>S(8), Cout=>C(8));
FA9: fulladder PORT MAP (A=>A(9), B=>B(9), Cin=>C(8), S=>S(9), Cout=>C(9));
FA10: fulladder PORT MAP (A=>A(10), B=>B(10), Cin=>C(9), S=>S(10), Cout=>C(10));
FA11: fulladder PORT MAP (A=>A(11), B=>B(11), Cin=>C(10), S=>S(11), Cout=>C(11));
FA12: fulladder PORT MAP (A=>A(12), B=>B(12), Cin=>C(11), S=>S(12), Cout=>C(12));
FA13: fulladder PORT MAP (A=>A(13), B=>B(13), Cin=>C(12), S=>S(13), Cout=>C(13));
FA14: fulladder PORT MAP (A=>A(14), B=>B(14), Cin=>C(13), S=>S(14), Cout=>C(14));
FA15: fulladder PORT MAP (A=>A(15), B=>B(15), Cin=>C(14), S=>S(15), Cout=>C(15));
FA16: fulladder PORT MAP (A=>A(16), B=>B(16), Cin=>C(15), S=>S(16), Cout=>C(16));
FA17: fulladder PORT MAP (A=>A(17), B=>B(17), Cin=>C(16), S=>S(17), Cout=>C(17));
FA18: fulladder PORT MAP (A=>A(18), B=>B(18), Cin=>C(17), S=>S(18), Cout=>C(18));
FA19: fulladder PORT MAP (A=>A(19), B=>B(19), Cin=>C(18), S=>S(19), Cout=>C(19));
FA20: fulladder PORT MAP (A=>A(20), B=>B(20), Cin=>C(19), S=>S(20), Cout=>C(20));
FA21: fulladder PORT MAP (A=>A(21), B=>B(21), Cin=>C(20), S=>S(21), Cout=>C(21));
FA22: fulladder PORT MAP (A=>A(22), B=>B(22), Cin=>C(21), S=>S(22), Cout=>C(22));
FA23: fulladder PORT MAP (A=>A(23), B=>B(23), Cin=>C(22), S=>S(23), Cout=>C(23));
FA24: fulladder PORT MAP (A=>A(24), B=>B(24), Cin=>C(23), S=>S(24), Cout=>C(24));
FA25: fulladder PORT MAP (A=>A(25), B=>B(25), Cin=>C(24), S=>S(25), Cout=>C(25));
FA26: fulladder PORT MAP (A=>A(26), B=>B(26), Cin=>C(25), S=>S(26), Cout=>C(26));
FA27: fulladder PORT MAP (A=>A(27), B=>B(27), Cin=>C(26), S=>S(27), Cout=>C(27));
FA28: fulladder PORT MAP (A=>A(28), B=>B(28), Cin=>C(27), S=>S(28), Cout=>C(28));
FA29: fulladder PORT MAP (A=>A(29), B=>B(29), Cin=>C(28), S=>S(29), Cout=>C(29));
FA30: fulladder PORT MAP (A=>A(30), B=>B(30), Cin=>C(29), S=>S(30), Cout=>C(30));
FA31: fulladder PORT MAP (A=>A(31), B=>B(31), Cin=>C(30), S=>S(31), Cout=>Cout);

END behavioral;