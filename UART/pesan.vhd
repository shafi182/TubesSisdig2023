
-- library
-- library IEEE;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Entity
Entity pesan is
port(
		clk 			: in std_logic;
		rst_n 		: in std_logic;
		
-- paralel part
		send 			: in std_logic;
		data	: out std_logic_vector(7 downto 0) := "00100000";
		done_send	: in std_logic;
		pesan_done : out std_logic := '0';
		list_pesan : in std_logic_vector(3 downto 0);
		n		: in std_logic;
		m		: in std_logic;
		-- data_in	: in std_logic_vector(7 downto 0)
		outMSB	: in std_logic_vector(7 downto 0);
		outB8	: in std_logic_vector(7 downto 0);
		outB7	: in std_logic_vector(7 downto 0);
		outB6	: in std_logic_vector(7 downto 0);
		outB5	: in std_logic_vector(7 downto 0);
		outB4	: in std_logic_vector(7 downto 0);
		outB3	: in std_logic_vector(7 downto 0);
		outB2	: in std_logic_vector(7 downto 0);
		outB1	: in std_logic_vector(7 downto 0);
		outLSB	: in std_logic_vector(7 downto 0)
		
);
end entity;

-- Architecture
Architecture structural of pesan is

	signal digit, digit_batas 	: integer := 0;
	signal done_send_c : std_logic;
	signal m1,m2,m3,m4,m5,m6,m7,m8,m9 : std_logic := '0';
	signal start	: std_logic  := '1';
	
	 
	
begin

	process(clk,rst_n)
	begin
	if rst_n = '0' then
		data <= "00000000";
		pesan_done <= '0';
	elsif (clk= '1' and clk'event) then
		done_send_c <= done_send;
		if (done_send = '1' and done_send_c = '0') or (start = '1') then
			start <= '0';
			pesan_done <= '0';
			digit <= digit + 1;
			case list_pesan is
				when "0000" =>	
					m1 <= '1';
					digit_batas <= 54;
					case digit is
						when 0 => 
							if m1 = '0' then
								data <= "01001011";  --K
							else
								data <= "00001010";  --"Enter"
							end if;	
						when 1 => data <= "01000001";  --A
						when 2 => data <= "01001100";  --L
						when 3 => data <= "01001011";  --K
						when 4 => data <= "01010101";  --U
						when 5 => data <= "01001100";  --L
						when 6 => data <= "01000001";  --A
						when 7 => data <= "01010100";  --T
						when 8 => data <= "01001111";  --O
						when 9 => data <= "01010010";  --R
						when 10 => data <= "00100000";  -- 
						when 11 => data <= "01001011";  --K
						when 12 => data <= "01010000";  --P
						when 13 => data <= "01001011";  --K
						when 14 => data <= "00100000";  -- 
						when 15 => data <= "00100110";  --&
						when 16 => data <= "00100000";  -- 
						when 17 => data <= "01000110";  --F
						when 18 => data <= "01010000";  --P
						when 19 => data <= "01000010";  --B
						when 20 => data <= "00001010";  --"Enter"
						when 21 => data <= "01001101";  --M
						when 22 => data <= "01100001";  --a
						when 23 => data <= "01110011";  --s
						when 24 => data <= "01110101";  --u
						when 25 => data <= "01101011";  --k
						when 26 => data <= "01101011";  --k
						when 27 => data <= "01100001";  --a
						when 28 => data <= "01101110";  --n
						when 29 => data <= "00100000";  -- 
						when 30 => data <= "01101101";  --m
						when 31 => data <= "01101111";  --o
						when 32 => data <= "01100100";  --d
						when 33 => data <= "01100101";  --e
						when 34 => data <= "00100000";  -- 
						when 35 => data <= "01001011";  --K
						when 36 => data <= "01010000";  --P
						when 37 => data <= "01001011";  --K
						when 38 => data <= "00100000";  -- 
						when 39 => data <= "01100001";  --a
						when 40 => data <= "01110100";  --t
						when 41 => data <= "01100001";  --a
						when 42 => data <= "01110101";  --u
						when 43 => data <= "00100000";  -- 
						when 44 => data <= "01000110";  --F
						when 45 => data <= "01010000";  --P
						when 46 => data <= "01000010";  --B
						when 47 => data <= "00100000";  -- 
						when 48 => data <= "01011011";  --[
						when 49 => data <= "01001011";  --K
						when 50 => data <= "00101111";  --/
						when 51 => data <= "01000110";  --F
						when 52 => data <= "01011101";  --]
						when 53 => data <= "00001010";  --"Enter"
						when others => 	
					end case;
				when "0001" =>	
					m2 <= '1';
					digit_batas <= 34;
					case digit is
						-- when 0 => 
						-- 	if m2 = '0' then
						-- 		data <= "01001011";  --K
						-- 	else
						-- 		data <= "00001010";  --"Enter"
						-- 	end if;	
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01001101";  --M
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01101101";  --m
						when 11 => data <= "01101111";  --o
						when 12 => data <= "01100100";  --d
						when 13 => data <= "01100101";  --e
						when 14 => data <= "00100000";  -- 
						when 15 => data <= "01001011";  --K
						when 16 => data <= "01010000";  --P
						when 17 => data <= "01001011";  --K
						when 18 => data <= "00100000";  -- 
						when 19 => data <= "01100001";  --a
						when 20 => data <= "01110100";  --t
						when 21 => data <= "01100001";  --a
						when 22 => data <= "01110101";  --u
						when 23 => data <= "00100000";  -- 
						when 24 => data <= "01000110";  --F
						when 25 => data <= "01010000";  --P
						when 26 => data <= "01000010";  --B
						when 27 => data <= "00100000";  -- 
						when 28 => data <= "01011011";  --[
						when 29 => data <= "01001011";  --K
						when 30 => data <= "00101111";  --/
						when 31 => data <= "01000110";  --F
						when 32 => data <= "01011101";  --]
						when 33 => data <= "00001010";  --"Enter"
						when others => 	
					end case;
				when "0010" =>	
					digit_batas <= 32;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01001101";  --M
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01101010";  --j
						when 11 => data <= "01110101";  --u
						when 12 => data <= "01101101";  --m
						when 13 => data <= "01101100";  --l
						when 14 => data <= "01100001";  --a
						when 15 => data <= "01101000";  --h
						when 16 => data <= "00100000";  -- 
						when 17 => data <= "01100010";  --b
						when 18 => data <= "01101001";  --i
						when 19 => data <= "01101100";  --l
						when 20 => data <= "01100001";  --a
						when 21 => data <= "01101110";  --n
						when 22 => data <= "01100111";  --g
						when 23 => data <= "01100001";  --a
						when 24 => data <= "01101110";  --n
						when 25 => data <= "00100000";  -- 
						when 26 => data <= "01011011";  --[
						when 27 => data <= "00110011";  --3
						when 28 => data <= "00101111";  --/
						when 29 => data <= "00110100";  --4
						when 30 => data <= "01011101";  --]
						when 31 => data <= "00001010";  --"Enter"
						when others => 
					end case;
				when "0011" =>	
					digit_batas <= 31;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01001101";  --M
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01100010";  --b
						when 11 => data <= "01101001";  --i
						when 12 => data <= "01101100";  --l
						when 13 => data <= "01100001";  --a
						when 14 => data <= "01101110";  --n
						when 15 => data <= "01100111";  --g
						when 16 => data <= "01100001";  --a
						when 17 => data <= "01101110";  --n
						when 18 => data <= "00100000";  -- 
						when 19 => data <= "01101011";  --k
						when 20 => data <= "01100101";  --e
						when 21 => data <= "00100000";  -- 
						when 22 => data <= "00110001";  --1
						when 23 => data <= "00100000";  -- 
						when 24 => data <= "00101000";  --(
						when 25 => data <= "00111100";  --<
						when 26 => data <= "00110010";  --2
						when 27 => data <= "00110101";  --5
						when 28 => data <= "00110110";  --6
						when 29 => data <= "00101001";  --)
						when 30 => data <= "00001010";  --"Enter"
						when others => 
					end case;
				when "0100" =>	
					digit_batas <= 31;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01001101";  --M
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01100010";  --b
						when 11 => data <= "01101001";  --i
						when 12 => data <= "01101100";  --l
						when 13 => data <= "01100001";  --a
						when 14 => data <= "01101110";  --n
						when 15 => data <= "01100111";  --g
						when 16 => data <= "01100001";  --a
						when 17 => data <= "01101110";  --n
						when 18 => data <= "00100000";  -- 
						when 19 => data <= "01101011";  --k
						when 20 => data <= "01100101";  --e
						when 21 => data <= "00100000";  -- 
						when 22 => data <= "00110010";  --2
						when 23 => data <= "00100000";  -- 
						when 24 => data <= "00101000";  --(
						when 25 => data <= "00111100";  --<
						when 26 => data <= "00110010";  --2
						when 27 => data <= "00110101";  --5
						when 28 => data <= "00110110";  --6
						when 29 => data <= "00101001";  --)
						when 30 => data <= "00001010";  --"Enter"
						when others => 
					end case;
				when "0101" =>	
					m6 <= '1';
					digit_batas <= 31;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						-- when 1 => data <= "01001101";  --M
						when 1 => 
							if m6 = '0' then
								data <= "01001101";  --M
							else
								if n = '1' then
									data <= "01001101";  --M
								else
									if m = '1' then
										data <= "01001011";  --K
									else
										data <= "01000110";  --F
									end if;
								end if;
							end if;	
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01100010";  --b
						when 11 => data <= "01101001";  --i
						when 12 => data <= "01101100";  --l
						when 13 => data <= "01100001";  --a
						when 14 => data <= "01101110";  --n
						when 15 => data <= "01100111";  --g
						when 16 => data <= "01100001";  --a
						when 17 => data <= "01101110";  --n
						when 18 => data <= "00100000";  -- 
						when 19 => data <= "01101011";  --k
						when 20 => data <= "01100101";  --e
						when 21 => data <= "00100000";  -- 
						when 22 => data <= "00110011";  --3
						when 23 => data <= "00100000";  -- 
						when 24 => data <= "00101000";  --(
						when 25 => data <= "00111100";  --<
						when 26 => data <= "00110010";  --2
						when 27 => data <= "00110101";  --5
						when 28 => data <= "00110110";  --6
						when 29 => data <= "00101001";  --)
						when 30 => data <= "00001010";  --"Enter"
						when others => 
					end case;
				when "0110" =>	
					m7 <= '1';
					digit_batas <= 31;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						-- when 1 => data <= "01001101";  --M
						when 1 => 
							if m7 = '0' then
								data <= "01001101";  --M
							else
								if m = '1' then
									data <= "01001011";  --K
								else
									data <= "01000110";  --F
								end if;
							end if;	
						when 2 => data <= "01100001";  --a
						when 3 => data <= "01110011";  --s
						when 4 => data <= "01110101";  --u
						when 5 => data <= "01101011";  --k
						when 6 => data <= "01101011";  --k
						when 7 => data <= "01100001";  --a
						when 8 => data <= "01101110";  --n
						when 9 => data <= "00100000";  -- 
						when 10 => data <= "01100010";  --b
						when 11 => data <= "01101001";  --i
						when 12 => data <= "01101100";  --l
						when 13 => data <= "01100001";  --a
						when 14 => data <= "01101110";  --n
						when 15 => data <= "01100111";  --g
						when 16 => data <= "01100001";  --a
						when 17 => data <= "01101110";  --n
						when 18 => data <= "00100000";  -- 
						when 19 => data <= "01101011";  --k
						when 20 => data <= "01100101";  --e
						when 21 => data <= "00100000";  -- 
						when 22 => data <= "00110100";  --4
						when 23 => data <= "00100000";  -- 
						when 24 => data <= "00101000";  --(
						when 25 => data <= "00111100";  --<
						when 26 => data <= "00110010";  --2
						when 27 => data <= "00110101";  --5
						when 28 => data <= "00110110";  --6
						when 29 => data <= "00101001";  --)
						when 30 => data <= "00001010";  --"Enter"
						when others => 
					end case;
				when "0111" =>	
					digit_batas <= 7;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01001011";  --K
						-- when 1 => 
						-- 	if m = '1' then
						-- 		data <= "01000110";  --F
						-- 	else
						-- 		data <= "01001011";  --K
						-- 	end if;	
						when 2 => data <= "01010000";  --P
						when 3 => data <= "01001011";  --K
						when 4 => data <= "00100000";  -- 
						when 5 => data <= "00111101";  --=
						when 6 => data <= "00100000";  --
						when others => 
					end case;	
				when "1000" =>	
					digit_batas <= 7;
					case digit is
						when 0 => data <= "00001010";  --"Enter"
						when 1 => data <= "01000110";  --F
						when 2 => data <= "01010000";  --P
						when 3 => data <= "01000010";  --B
						when 4 => data <= "00100000";  -- 
						when 5 => data <= "00111101";  --=
						when 6 => data <= "00100000";  --
						when others => 
					end case;
						
				when "1001" =>	
					digit_batas <= 10;
					case digit is
						when 0 => data <= outMSB;  
						when 1 => data <= outB8;  
						when 2 => data <= outB7;  
						when 3 => data <= outB6;  
						when 4 => data <= outB5;  
						when 5 => data <= outB4;  
						when 6 => data <= outB3;  
						when 7 => data <= outB2;  
						when 8 => data <= outB1;  
						when 9 => data <= outLSB;  
						when others => 
					end case;	
				when others =>
			end case;			
			-- end if;
		elsif digit >= digit_batas then
			digit <= 0;
			pesan_done <= '1';
		end if;
	end if;
	end process;

end architecture;



