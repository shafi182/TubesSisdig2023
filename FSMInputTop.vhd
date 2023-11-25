library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

ENTITY FSMInputTop IS
PORT( 
		rst 		: in std_logic;
		clk			: in std_logic; 
		load_m		: in std_logic;
		load_n		: in std_logic;
		selesai_a	: in std_logic; 
		selesai_b	: in std_logic; 
		selesai_c	: in std_logic; 
		selesai_d	: in std_logic; 
		Enable_m 	: out std_logic;
		Enable_n 	: out std_logic;		
		Enable_a 	: out std_logic;
		Enable_b 	: out std_logic;
		Enable_c 	: out std_logic;
		Enable_d 	: out std_logic
);
end FSMInputTop;

ARCHITECTURE behavioral OF FSMInputTop IS
	TYPE executionStage IS (s0,s1,s2,s3,s4,s5,s6);
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

	-- Moore STATE
	PROCESS(load_m , load_n , selesai_a , selesai_b , selesai_c , selesai_d )
	BEGIN
	CASE currentstate IS
		--State 0
		WHEN s0 =>
				Enable_m <= '0';
				Enable_n <= '0';
				Enable_a <= '0';
				Enable_b <= '0';
				Enable_c <= '0';
				Enable_d <= '0';
				--PERPINDAHAN STATE
				if load_m = '0' then
				nextstate <= s1;
				Enable_m <= '1';
				Enable_n <= '0';
				Enable_a <= '0';
				Enable_b <= '0';
				Enable_c <= '0';
				Enable_d <= '0';
				end if;
							
		--State 1
		WHEN s1 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '0' and selesai_a = '0' AND selesai_b = '0' AND selesai_c = '0' AND selesai_d = '0') THEN
					nextstate <= s2;
					Enable_m <= '0';
					Enable_n <= '1';
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '0';
				ELSE
					nextstate <= currentstate;
				END IF;
			
		--State 2	
		WHEN s2 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '1' and selesai_a = '0' AND selesai_b = '0' AND selesai_c = '0' AND selesai_d = '0') THEN
					nextstate <= s3;
					Enable_m <= '0';
					Enable_n <= '0';
					Enable_a <= '1';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '0';
				ELSE
					nextstate <= currentstate;
				END IF;
				
		--State 3	
		WHEN s3 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '1' and selesai_a = '1' AND selesai_b = '0' AND selesai_c = '0' AND selesai_d = '0') THEN
					nextstate <= s4;
					Enable_m <= '0';
					Enable_n <= '0';
					Enable_a <= '0';
					Enable_b <= '1';
					Enable_c <= '0';
					Enable_d <= '0';
				ELSE
					nextstate <= currentstate;
				END IF;

		--State 4	
		WHEN s4 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '1' and selesai_a = '1' AND selesai_b = '1' AND selesai_c = '0' AND selesai_d = '0') THEN
					nextstate <= s5;
					Enable_m <= '0';
					Enable_n <= '0';
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '1';
					Enable_d <= '0';
				ELSE
					nextstate <= currentstate;
				END IF;

		--State 5	
		WHEN s5 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '1' and selesai_a = '1' AND selesai_b = '1' AND selesai_c = '1' AND selesai_d = '0') THEN
					nextstate <= s6;
					Enable_m <= '0';
					Enable_n <= '0';
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '1';
				ELSE
					nextstate <= currentstate;
				END IF;
				
		--State 6	
		WHEN s6 =>
				--PERPINDAHAN STATE
				IF (load_m = '1' and load_n = '1' and selesai_a = '1' AND selesai_b = '1' AND selesai_c = '1' AND selesai_d = '1') THEn
					Enable_m <= '0';
					Enable_n <= '0';
					Enable_a <= '0';
					Enable_b <= '0';
					Enable_c <= '0';
					Enable_d <= '0';
				END IF;
	END CASE;
	END PROCESS;
	
END behavioral;