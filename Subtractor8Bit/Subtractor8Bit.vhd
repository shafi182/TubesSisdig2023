LIBRARY ieee ;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Subtractor8Bit IS
		PORT( 
				A, B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
				D : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
				Bout : OUT STD_LOGIC
		);
END Subtractor8Bit;

ARCHITECTURE behavioral OF Subtractor8Bit IS
		SIGNAL Bsig : STD_LOGIC_VECTOR(7 DOWNTO 0);
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
FS7: fullsubtractor PORT MAP (A=>A(7), B=>B(7), Bin=>Bsig(6), D=>D(7), Bout=>Bout);


END behavioral;
