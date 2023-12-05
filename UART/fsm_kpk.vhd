librarY IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY fsm_kpk IS
PORT( 
		rst, clk										: in std_logic;
		load_a,load_b,load_c,load_d						: in std_logic; 	-- penentu untuk load nilai awal
		Enable_a, Enable_b, Enable_c, Enable_d 			: out std_logic;	-- register nilai input awal
		Enable_aop, Enable_bop, Enable_cop, Enable_dop 	: out std_logic;	-- register nilai operasi
		P, I											: in std_logic;		-- a = b
		Q, J											: in std_logic;		-- a > b
		R, K											: out std_logic;	-- mux adder
		Y												: out std_logic;	-- mux setelah 1 tahap
		Z												: out std_logic		-- meneruskan nilai output kpk
);
end fsm_kpk;

ARCHITECTURE behavioral OF fsm_kpk IS
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
	PROCESS(P, Q, I, J, load_a, load_b, load_c, load_d, currentstate)
	BEGIN
	CASE currentstate IS
		WHEN s0 =>
				Y <= '0';
				Z <= '0';
				-- Regis_A
				IF (load_a = '1') THEN
					Enable_a <= '1';
					Enable_aop <= '1';
				ELSIF (load_a = '0') THEN
					Enable_a <= '0';
					Enable_aop <= '0';
				END IF;
				
				--Regis_B
				IF (load_b = '1') THEN
					Enable_b <= '1';
					Enable_bop <= '1';
				ELSIF (load_b = '0') THEN
					Enable_b <= '0';
					Enable_bop <= '0';
				END IF;
				
				--Regis_C
				IF (load_c = '1') THEN
					Enable_c <= '1';
					Enable_cop <= '1';
				ELSIF (load_c = '0') THEN
					Enable_c <= '0';
					Enable_cop <= '0';
				END IF;
				
				--Regis_D
				IF (load_d = '1') THEN
					Enable_d <= '1';
					Enable_dop <= '1';
				ELSIF (load_d = '0') THEN
					Enable_d <= '0';
					Enable_dop <= '0';
				END IF;
				
				--PERPINDAHAN STATE
				IF (load_a = '0' AND load_b = '0' AND load_c = '0' AND load_d = '0') THEN
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '0';
					Enable_aop <= '0';
					Enable_bop <= '0';
					Enable_cop <= '0';
					Enable_dop <= '0';
					Y <= '0';
					nextstate <= s1;
				ELSE
					nextstate <= currentstate;
				END IF;
				
			WHEN s1 =>
				Y <= '0';
				Z <= '0';
				IF (P = '0' AND Q = '1') THEN
					R <= '1';
					Enable_a <= '0';
					Enable_aop <= '0';
					Enable_b <= '0';
					Enable_bop <= '1';
				ELSIF (P = '0' AND Q = '0') THEN
					R <= '0';
					Enable_a <= '0';
					Enable_aop <= '1';
					Enable_b <= '0';
					Enable_bop <= '0';
				ELSIF (P = '1') THEN
					Enable_a <= '0';
					Enable_aop <= '0';
					Enable_bop <= '0';
					Enable_b <= '0';
				END IF;
				
				IF (I = '0' AND J = '1') THEN
					K <= '1';
					Enable_c <= '0';
					Enable_cop <= '0';
					Enable_d <= '0';
					Enable_dop <= '1';
				ELSIF (I = '0' AND J = '0') THEN
					K <= '0';
					Enable_c <= '0';
					Enable_cop <= '1';
					Enable_d <= '0';
					Enable_dop <= '0';
				ELSIF (I = '1') THEN
					Enable_c <= '0';
					Enable_cop <= '0';
					Enable_d <= '0';
					Enable_dop <= '0';
				END IF;
				
				IF (P = '1' AND I = '1') THEN
					Enable_a <= '1';
					Enable_aop <= '0';
					Enable_b <= '1';
					Enable_bop <= '1';
					Y <= '1';
					nextstate <= s2;
				ELSE
					nextstate <= currentstate;
				END IF;
				
			WHEN s2 =>
				Y <= '0';
				Z <= '0';
				IF (P = '0' AND Q = '1') THEN
					R <= '1';
					Enable_a <= '0';
					Enable_aop <= '0';
					Enable_b <= '0';
					Enable_bop <= '1';
				ELSIF (P = '0' AND Q = '0') THEN
					R <= '0';
					Enable_a <= '0';
					Enable_aop <= '1';
					Enable_b <= '0';
					Enable_bop <= '0';
				ELSIF (P = '1') THEN
					Enable_aop <= '0';
					Enable_bop <= '0';
					Z <= '1';
					
				END IF;
				
	END CASE;
	END PROCESS;
END behavioral;
