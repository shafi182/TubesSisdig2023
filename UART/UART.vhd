-- library
library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;	
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- entity
entity UART is
	port(
		clk 				: in std_logic;
		rst_n 			: in std_logic;
		
-- paralel part
		button 			: in std_logic;
		button2 			: in std_logic;
		led				: out std_logic ;
		buzzer			: out std_logic ;
		Seven_Segment	: out std_logic_vector(7 downto 0) ;
		Digit_SS		: out std_logic_vector(3 downto 0) ;
		m_out, n_out	: out std_logic;
		data_out		: out std_logic_vector(7 downto 0) ;
		input_done		: out std_logic;	
		--output_start	: in std_logic;
		--MSB   			: in std_logic_vector(7 downto 0);
		--B8  			: in std_logic_vector(7 downto 0);
		--B7   			: in std_logic_vector(7 downto 0);
		--B6   			: in std_logic_vector(7 downto 0);
		--B5   			: in std_logic_vector(7 downto 0);
		--B4   			: in std_logic_vector(7 downto 0);
		--B3   			: in std_logic_vector(7 downto 0);
		--B2   			: in std_logic_vector(7 downto 0);
		--B1   			: in std_logic_vector(7 downto 0);
		--LSB  			: in std_logic_vector(7 downto 0);
		
-- serial part
		rs232_rx 		: in std_logic;
		rs232_tx 		: out std_logic
	
	);
End entity;


Architecture RTL of UART is

	Component my_uart_top is
	port(
		clk 			: in std_logic;
		rst_n 		: in std_logic;
		send 			: in std_logic;
		send_data	: in std_logic_vector(7 downto 0) ;
		done_send	: out std_logic;
		--launch_done : out std_logic;
		receive 		: out std_logic;
		receive_data: out std_logic_vector(7 downto 0) ;
		rs232_rx 	: in std_logic;
		rs232_tx 	: out std_logic
	);
	end Component;
	
	component CLOCKDIV is 
	port(
		CLK: IN std_logic;
		DIVOUT: buffer BIT);
	end component;

	component pesan is
	port(
		clk 			: in std_logic;
		rst_n 		: in std_logic;
		send 			: in std_logic;
		data	: out std_logic_vector(7 downto 0);
		done_send	: in std_logic;
		pesan_done : out std_logic;
		list_pesan : in std_logic_vector(3 downto 0);
		n		: in std_logic;
		m		: in std_logic;
		--data_in	: in std_logic_vector(7 downto 0)
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
	end component;

	component Top is
		port(
			Rx_ina	 	: in std_logic_vector (23 downto 0);
			Rx_inb	 	: in std_logic_vector (23 downto 0);
			Rx_inc	 	: in std_logic_vector (23 downto 0);
			Rx_ind	 	: in std_logic_vector (23 downto 0);
			m_in			: in std_logic;
			n_in			: in std_logic;
			clk , rst, enable 	: in std_logic;
			MSB   		: out std_logic_vector(7 downto 0);
			B8  		: out std_logic_vector(7 downto 0);
			B7   		: out std_logic_vector(7 downto 0);
			B6   		: out std_logic_vector(7 downto 0);
			B5   		: out std_logic_vector(7 downto 0);
			B4   		: out std_logic_vector(7 downto 0);
			B3   		: out std_logic_vector(7 downto 0);
			B2   		: out std_logic_vector(7 downto 0);
			B1   		: out std_logic_vector(7 downto 0);
			LSB  		: out std_logic_vector(7 downto 0);
			outing_selesai	: out std_logic;
			Done        : out Std_logic
		);
		end component;

	
	signal send_data,receive_data, temp_data, data_register	: std_logic_vector(7 downto 0);
	signal receive		: std_logic;
	signal receive_c1,receive_c2, receive_c3,receive_c4,receive_c5	: std_logic;
	signal sendCuy, sendCuy2, sendCuy3,  kirim , launch, launch_done: std_logic := '0';
	signal sendCommand, sendCommand_c, sendCommand_c1, sendCommand_c2, sendCommand_c3, sendCommand_c4, sendCommand_c5 : std_logic;
	signal list_pesan	: std_logic_vector(3 downto 0)  := "0000";
	signal divout 	: BIT;
	signal done, pesan_done, pesan_done_c, pesan_done_cc, move_done, input_done_r, input_done_c1, input_done_c2, input_done_c3, input_done_c4 ,input_done_c5, input_done_c6, input_done_c7, input_done_c8, input_done_c9, input_done_c10, input_done_c11, input_done_c12	: std_logic := '0';
	signal trig, trig2 : std_logic := '0';
	signal m,n,asong : std_logic;
	signal correct : std_logic := '0';
	signal start : std_logic := '0';
	signal bil1,bil2,bil3,bil4 : std_logic_vector(23 downto 0);
	signal receive_count, cok, blok_count : integer := 0;
	signal all_data : std_logic_vector(111 downto 0);
	signal msb,b8,b7,b6,b5,b4,b3,b2,b1,lsb  : std_logic_vector(7 downto 0);
	signal out_start, out_start_c1, out_start_c2, out_start_c3, out_start_c4, out_start_c5, out_start_c6, out_start_c7, out_start_c8, out_start_c9, out_start_c10 : std_logic := '0';
	signal out_send : integer := 0;
	signal selesai : std_logic ;
	signal iqbal : integer := 0;

begin

	UART: my_uart_top 
	port map (
			clk 			=> clk,
			rst_n 		=> rst_n,
			send 			=> kirim,
			send_data	=> send_data,
			done_send	=> done,
			receive 		=> receive,
			receive_data=> receive_data,
			rs232_rx 	=> rs232_rx,
			rs232_tx 	=> rs232_tx
	);
	
	div: CLOCKDIV
	port map (
			CLK => clk,
			DIVOUT => divout		
	);
		
	listPesan : pesan
	port map (
		clk 		=> clk,
		rst_n 		=> rst_n,
		send 		=> kirim,
		data		=> send_data,
		done_send	=> done,
		pesan_done  => pesan_done,
		list_pesan 	=> list_pesan,
		n 			=> n,
		m			=> m,
		--data_in		=> data_register
		outMSB		=> msb,
		outB8		=> b8,
		outB7		=> b7,
		outB6		=> b6,
		outB5		=> b5,
		outB4		=> b4,
		outB3		=> b3,
		outB2		=> b2,
		outB1		=> b1,
		outLSB		=> lsb
	);

	topCuy : Top
	port map (
		Rx_ina				=> bil1,
		Rx_inb				=> bil2,
		Rx_inc				=> bil3,
		Rx_ind				=> bil4,
		m_in				=> m,
		n_in				=> n,
		clk					=> clk, 
		rst					=> not rst_n,
		enable				=> input_done_r,
		MSB					=> msb,
		B8					=> b8,
		B7					=> b7,
		B6					=> b6,
		B5					=> b5,
		B4					=> b4,
		B3					=> b3,
		B2					=> b2,
		B1					=> b1,
		LSB					=> lsb,
		outing_selesai		=> asong,
		Done				=> out_start
	);
	
	
	Process(clk)
	begin
		if ((clk = '1') and clk'event) then
			receive_c1 <= receive;
			receive_c2 <= receive_c1;
			receive_c3 <= receive_c2;
			receive_c4 <= receive_c3;
			receive_c5 <= receive_c4;

			if ((receive = '0') and (receive_c1 = '1'))then
				temp_data(0) <= receive_data(7);
				temp_data(1) <= receive_data(6);
				temp_data(2) <= receive_data(5);
				temp_data(3) <= receive_data(4);
				temp_data(4) <= receive_data(3);
				temp_data(5) <= receive_data(2);
				temp_data(6) <= receive_data(1);
				temp_data(7) <= receive_data(0);

				blok_count <= blok_count + 1;

				if blok_count = 0 then
					all_data(111 downto 104) <= receive_data;	-- (K/P)
				elsif blok_count = 1 then
					all_data(103 downto 96) <= receive_data;	-- (3/4)
				elsif blok_count = 2 then
					all_data(95 downto 88) <= receive_data;	-- (1_bil1)
				elsif blok_count = 3 then
					all_data(87 downto 80) <= receive_data;	-- (2_bil1)
				elsif blok_count = 4 then
					all_data(79 downto 72) <= receive_data;	-- (3_bil1)
				elsif blok_count = 5 then
					all_data(71 downto 64) <= receive_data;	-- (1_bil2)
				elsif blok_count = 6 then
					all_data(63 downto 56) <= receive_data;	-- (2_bil2)
				elsif blok_count = 7 then
					all_data(55 downto 48) <= receive_data;	-- (3_bil2)
				elsif blok_count = 8 then
					all_data(47 downto 40) <= receive_data;	-- (1_bil3)
				elsif blok_count = 9 then
					all_data(39 downto 32) <= receive_data;	-- (2_bil3)
				elsif blok_count = 10 then
					all_data(31 downto 24) <= receive_data;	-- (3_bil3)
				elsif blok_count = 11 then
					all_data(23 downto 16) <= receive_data;	-- (1_bil4)
				elsif blok_count = 12 then
					all_data(15 downto 8) <= receive_data;	-- (2_bil4)
				elsif blok_count = 13 then
					all_data(7 downto 0) <= receive_data;	-- (3_bil4)
				end if;

				if cok <= 1 then
					if receive_data = "01101011" or receive_data = "01001011" then
						m <= '1';
						correct <= '1';
					elsif receive_data = "01100110" or receive_data = "01000110" then
						m <= '0';
						correct <= '1';
					else
						correct <= '0';
					end if;
				elsif cok = 2 then
					if receive_data = "00110011" then
						n <= '0';
						correct <= '1';
					elsif receive_data = "00110100" then
						n <= '1';
						correct <= '1';
					else
						correct <= '0';
					end if;
				elsif cok = 3 then
					receive_count <= receive_count + 1;
					if receive_count >= 2 then
						correct <= '1';
						receive_count <= 0;
					end if;
				elsif cok = 4 then
					receive_count <= receive_count + 1;
					if receive_count >= 2 then
						receive_count <= 0;
						correct <= '1';
					end if;
				elsif cok = 5 then
					receive_count <= receive_count + 1;
					if receive_count >= 2 then
						receive_count <= 0;
						correct <= '1';
					end if;
				elsif cok = 6 then
					receive_count <= receive_count + 1;
					if receive_count >= 2 then
						receive_count <= 0;
						correct <= '1';
					end if;
				end if;
				

			elsif ((receive_c1 = '0') and (receive_c2 = '1')) and correct = '1' then
				trig <= '1';
				correct <= '0';
				if cok < 1 then
					start <= '1';
				else 
					start <= '0';
				end if;
			elsif ((receive_c1 = '0') and (receive_c2 = '1')) and correct = '0' then
				if cok < 1 then
					trig <= '1';
				end if;
			elsif ((receive_c2 = '0') and (receive_c3 = '1')) then
				trig <= '0';
			elsif ((receive_c3 = '0') and (receive_c4 = '1')) then
				trig2 <= '1';
			elsif ((receive_c4 = '0') and (receive_c5 = '1')) then
				trig2 <= '0';
			end if;
		end if;
	end process;
	
	m_out <= m;
	n_out <= n;
	bil1 <= all_data(95 downto 72);
	bil2 <= all_data(71 downto 48);
	bil3 <= all_data(47 downto 24);
	bil4 <= all_data(23 downto 0);
	seven_segment <= bil4(23 downto 16);
	
	-- msb <= "00110000";
	-- b8 	<= "00110001";
	-- b7 	<= "00110010";
	-- b6 	<= "00110011";
	-- b5 	<= "00110100";
	-- b4 	<= "00110101";
	-- b3 	<= "00110110";
	-- b2 	<= "00110111";
	-- b1 	<= "00111000";
	-- lsb	<= "00111001";
	
	process(cok,trig)
	begin
		if ((clk = '1') and clk'event) then
			if trig = '1' then
				if start = '1' or (m = '0' and cok = 6) then
					cok <= cok + 2;
				elsif  (n = '0' and cok = 5) then
					if m = '0' then
						cok <= cok + 3;
					else
						cok <= cok + 2;
					end if;
				else
					cok <= cok + 1;
				end if;
			-- elsif input_done_r = '1' then
			-- 	cok <= 9;
			end if;
			
			if trig2 = '1' then
				sendCuy2 <= '1';
			elsif pesan_done = '1' then
				sendCuy2 <= '0';
				-- out_start <= '1';
				if cok = 7 or cok = 8 then
					input_done_r <= '1';
					cok <= 9;
				end if;
			end if;
			
			case cok is
				when 0 => list_pesan <= "0000"; input_done_r <= '0';
				when 1 => list_pesan <= "0001";  
				when 2 => list_pesan <= "0010"; 
				when 3 => list_pesan <= "0011"; 
				when 4 => list_pesan <= "0100"; 
				when 5 => list_pesan <= "0101"; 
				when 6 => list_pesan <= "0110";
				when 7 => list_pesan <= "0111";	--input_done_r <= '1'; out_start <= '1'; 
				when 8 => list_pesan <= "1000";	--input_done_r <= '1'; out_start <= '1'; 
				when 9 => list_pesan <= "1001"; --input_done_r <= '1'; 
				when others =>
			end case;
		end if;
	end process;
	
	process(clk)
	begin
		if ((clk = '1') and clk'event) then
			out_start_c1 <= selesai;
			out_start_c2 <= out_start_c1;
			out_start_c3 <= out_start_c2;
			out_start_c4 <= out_start_c3;
			out_start_c5 <= out_start_c4;
			out_start_c6 <= out_start_c5;
			out_start_c7 <= out_start_c6;
			out_start_c8 <= out_start_c7;
			out_start_c9 <= out_start_c8;
			out_start_c10 <= out_start_c9;
			
			if not(msb(3 downto 0) = 0 and b8(3 downto 0) = 0 and b7(3 downto 0) = 0 and b6(3 downto 0) = 0 and b5(3 downto 0) = 0 and b4(3 downto 0) = 0 and b3(3 downto 0) = 0 and b2(3 downto 0) = 0 and b1(3 downto 0) = 0 and lsb(3 downto 0) = 0) then
				selesai <= '1';
			else
				selesai <= '0';
			end if;
			
			if selesai = '1' and iqbal < 1 then
			--if (out_start_c1 = '1' and out_start_c2 = '0') then
				--iqbal <= iqbal + 1;
				sendCuy3 <= '1';
				selesai <= '0';
			elsif pesan_done = '1' then
				sendCuy3 <= '0';
			end if;
			
		end if;
	end process;
	
	process(clk,iqbal,selesai)
	begin
		if falling_edge(clk) then
		if selesai = '1' then
			iqbal <= 1;
		end if;
		end if;
	end process;

	process(clk)
	begin
		if ((clk = '1') and clk'event) then
			sendCommand <= button; -- nanti bisa diganti jadi trigger untuk sending
			sendCommand_c <= sendCommand;	
			-- sendCommand_c1 <= sendCommand_c;	
			-- sendCommand_c2 <= sendCommand_c1;	
			-- sendCommand_c3 <= sendCommand_c2;	
			-- sendCommand_c4 <= sendCommand_c3;	
			-- sendCommand_c5 <= sendCommand_c4;	
			
			if (sendCommand = '1' and sendCommand_c = '0') or sendCuy2 = '1' or sendCuy3 = '1' then
				sendCuy <= '1';
			elsif pesan_done = '1' then
				sendCuy <= '0';
			end if;	
		end if;
	end process;
	
	
	
	led <= not asong;

	process(clk, sendCuy)
	begin
		if ((clk = '1') and clk'event) then
			if divout = '1' and sendCuy = '1' then
				if kirim = '0' then
					kirim <= '1';
				else
					kirim <= '0';
				end if;	
			end if;
		end if;
	end process;
	
	Digit_SS <= "0110";

end architecture;


