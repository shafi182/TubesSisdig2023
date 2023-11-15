library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY fsmfpb IS
PORT( 
		rst 		: in std_logic;
		clk			: in std_logic; 
		T			: in std_logic; --Kurang dari
		U			: in std_logic; --Sama dengan
		V			: in std_logic; --Kurang dari
		W			: in std_logic; --Sama dengan
		load_a		: in std_logic; 
		load_b		: in std_logic; 
		load_c		: in std_logic; 
		load_d		: in std_logic; 
		M1			: out std_logic;
		M2			: out std_logic;
		P			: out std_logic;
		Enable_a 	: out std_logic;
		Enable_b 	: out std_logic;
		Enable_c 	: out std_logic;
		Enable_d 	: out std_logic;
		Y			: out std_logic
);
end fsmfpb;

ARCHITECTURE behavioral OF fsmfpb IS
	TYPE executionStage IS (s0,s1,s2);
	SIGNAL currentstate, nextstate : executionStage;

BEGIN
	-- PERGANTIAN CURRENTSTATE
	PROCESS
	BEGIN
				WAIT UNTIL(clk'EVENT ) AND ( clk = '1');
				IF ( rst = '1' ) THEN
					currentstate <= s0;
				ELSE
					currentstate <= nextstate;
				END IF;
	END PROCESS;

	-- MEALY STATE
	PROCESS(T, U, V, W, load_a, load_b, load_c, load_d, currentstate)
	BEGIN
	CASE currentstate IS
		--State 0
		WHEN s0 =>
				Y <= '0';
				P <= '0';
				-- Regis_A
				IF (load_a = '1') THEN
					Enable_a <= '1';
				ELSIF (load_a = '0') THEN
					Enable_a <= '0';
				END IF;
				
				--Regis_B
				IF (load_b = '1') THEN
					Enable_b <= '1';
				ELSIF (load_b = '0') THEN
					Enable_b <= '0';
				END IF;
				
				--Regis_C
				IF (load_c = '1') THEN
					Enable_c <= '1';
				ELSIF (load_c = '0') THEN
					Enable_c <= '0';
				END IF;
				
				--Regis_D
				IF (load_d = '1') THEN
					Enable_d <= '1';
				ELSIF (load_d = '0') THEN
					Enable_d <= '0';
				END IF;
				
				--PERPINDAHAN STATE
				IF (load_a = '0' AND load_b = '0' AND load_c = '0' AND load_d = '0') THEN
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '0';
					nextstate <= s1;
				ELSE
					nextstate <= currentstate;
				END IF;
			
		--State 1
		WHEN s1 =>
			Y <= '0';
			--Proses A dan B
			IF (T = '0' AND U = '0') THEN
				M1 <= '0';
				Enable_a <= '1';
				Enable_b <= '0';
			ELSIF (T = '1' AND U = '0') THEN
				M1 <= '1';
				Enable_a <= '0';
				Enable_b <= '1';
			ELSIF (U = '1') THEN
				Enable_a <= '0';
				Enable_b <= '0';
			END IF;
			
			--Proses C dan D
			IF (V = '0' AND W = '0') THEN
				M2 <= '0';
				Enable_c <= '1';
				Enable_d <= '0';
			ELSIF (V = '1' AND W = '0') THEN
				M2 <= '1';
				Enable_c <= '0';
				Enable_d <= '1';
			ELSIF (W = '1') THEN
				Enable_c <= '0';
				Enable_d <= '0';
			END IF;
			
			--PERPINDAHAN STATE
			IF (U = '1' AND W = '1') THEN
				Enable_a <= '0';
				Enable_b <= '1';
				Enable_c <= '0';
				Enable_d <= '0';
				Y <= '1';
				nextstate <= s2;
			ELSE
				nextstate <= currentstate;
			END IF;
			
		--State 2	
		WHEN s2 =>
			Y <= '0';
			IF (T = '0' AND U = '0') THEN
				M1 <= '0';
				Enable_a <= '1';
				Enable_b <= '0';
				Enable_c <= '0';
				Enable_d <= '0';
			ELSIF (T = '1' AND U = '0') THEN
				M1 <= '1';
				Enable_a <= '0';
				Enable_b <= '1';
				Enable_c <= '0';
				Enable_d <= '0';
			END IF;
			
			IF (U = '1') THEN
				Enable_a <= '0';
				Enable_b <= '0';
				Enable_c <= '0';
				Enable_d <= '0';
				P <= '1';
				nextstate <= currentstate;
			Else
				nextstate <= currentstate;
			END IF;
	END CASE;
	END PROCESS;
END behavioral;
