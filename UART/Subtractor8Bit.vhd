LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Subtractor8Bit IS
		PORT( 
				A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				D : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bout : OUT STD_LOGIC
		);
END Subtractor8Bit;

ARCHITECTURE behavioral OF Subtractor8Bit IS
		SIGNAL Bsig : STD_LOGIC_VECTOR(31 DOWNTO 0);
		COMPONENT halfSubtractor IS
		PORT( A,B : IN STD_LOGIC;
		D,Bout : OUT STD_LOGIC);
		END COMPONENT;
						
		COMPONENT FullSubtractor IS
		PORT( A,B,Bin : IN STD_LOGIC;
		 D,Bout : OUT STD_LOGIC);
		END COMPONENT;

BEGIN

HS0: halfsubtractor PORT MAP (A=>A(0), B=>B(0), D=>D(0), Bout=>Bsig(0));
FS1: fullsubtractor PORT MAP (A=>A(1), B=>B(1), Bin=>Bsig(0), D=>D(1), Bout=>Bsig(1));
FS2: fullsubtractor PORT MAP (A=>A(2), B=>B(2), Bin=>Bsig(1), D=>D(2), Bout=>Bsig(2));
FS3: fullsubtractor PORT MAP (A=>A(3), B=>B(3), Bin=>Bsig(2), D=>D(3), Bout=>Bsig(3));
FS4: fullsubtractor PORT MAP (A=>A(4), B=>B(4), Bin=>Bsig(3), D=>D(4), Bout=>Bsig(4));
FS5: fullsubtractor PORT MAP (A=>A(5), B=>B(5), Bin=>Bsig(4), D=>D(5), Bout=>Bsig(5));
FS6: fullsubtractor PORT MAP (A=>A(6), B=>B(6), Bin=>Bsig(5), D=>D(6), Bout=>Bsig(6));
FS7: fullsubtractor PORT MAP (A=>A(7), B=>B(7), Bin=>Bsig(6), D=>D(7), Bout=>Bsig(7));
FS8: fullsubtractor PORT MAP (A=>A(8), B=>B(8), Bin=>Bsig(7), D=>D(8), Bout=>Bsig(8));
FS9: fullsubtractor PORT MAP (A=>A(9), B=>B(9), Bin=>Bsig(8), D=>D(9), Bout=>Bsig(9));
FS10: fullsubtractor PORT MAP (A=>A(10), B=>B(10), Bin=>Bsig(9), D=>D(10), Bout=>Bsig(10));
FS11: fullsubtractor PORT MAP (A=>A(11), B=>B(11), Bin=>Bsig(10), D=>D(11), Bout=>Bsig(11));
FS12: fullsubtractor PORT MAP (A=>A(12), B=>B(12), Bin=>Bsig(11), D=>D(12), Bout=>Bsig(12));
FS13: fullsubtractor PORT MAP (A=>A(13), B=>B(13), Bin=>Bsig(12), D=>D(13), Bout=>Bsig(13));
FS14: fullsubtractor PORT MAP (A=>A(14), B=>B(14), Bin=>Bsig(13), D=>D(14), Bout=>Bsig(14));
FS15: fullsubtractor PORT MAP (A=>A(15), B=>B(15), Bin=>Bsig(14), D=>D(15), Bout=>Bsig(15));
FS16: fullsubtractor PORT MAP (A=>A(16), B=>B(16), Bin=>Bsig(15), D=>D(16), Bout=>Bsig(16));
FS17: fullsubtractor PORT MAP (A=>A(17), B=>B(17), Bin=>Bsig(16), D=>D(17), Bout=>Bsig(17));
FS18: fullsubtractor PORT MAP (A=>A(18), B=>B(18), Bin=>Bsig(17), D=>D(18), Bout=>Bsig(18));
FS19: fullsubtractor PORT MAP (A=>A(19), B=>B(19), Bin=>Bsig(18), D=>D(19), Bout=>Bsig(19));
FS20: fullsubtractor PORT MAP (A=>A(20), B=>B(20), Bin=>Bsig(19), D=>D(20), Bout=>Bsig(20));
FS21: fullsubtractor PORT MAP (A=>A(21), B=>B(21), Bin=>Bsig(20), D=>D(21), Bout=>Bsig(21));
FS22: fullsubtractor PORT MAP (A=>A(22), B=>B(22), Bin=>Bsig(21), D=>D(22), Bout=>Bsig(22));
FS23: fullsubtractor PORT MAP (A=>A(23), B=>B(23), Bin=>Bsig(22), D=>D(23), Bout=>Bsig(23));
FS24: fullsubtractor PORT MAP (A=>A(24), B=>B(24), Bin=>Bsig(23), D=>D(24), Bout=>Bsig(24));
FS25: fullsubtractor PORT MAP (A=>A(25), B=>B(25), Bin=>Bsig(24), D=>D(25), Bout=>Bsig(25));
FS26: fullsubtractor PORT MAP (A=>A(26), B=>B(26), Bin=>Bsig(25), D=>D(26), Bout=>Bsig(26));
FS27: fullsubtractor PORT MAP (A=>A(27), B=>B(27), Bin=>Bsig(26), D=>D(27), Bout=>Bsig(27));
FS28: fullsubtractor PORT MAP (A=>A(28), B=>B(28), Bin=>Bsig(27), D=>D(28), Bout=>Bsig(28));
FS29: fullsubtractor PORT MAP (A=>A(29), B=>B(29), Bin=>Bsig(28), D=>D(29), Bout=>Bsig(29));
FS30: fullsubtractor PORT MAP (A=>A(30), B=>B(30), Bin=>Bsig(29), D=>D(30), Bout=>Bsig(30));
FS31: fullsubtractor PORT MAP (A=>A(31), B=>B(31), Bin=>Bsig(30), D=>D(31), Bout=>Bout);

END behavioral;