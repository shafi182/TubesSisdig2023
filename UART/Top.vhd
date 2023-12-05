library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.all;

entity Top is
	port( 	Rx_ina	 	: in std_logic_vector (23 downto 0);
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
			-- outing_oop	: out std_logic_vector (31 downto 0);
			outing_selesai	: out std_logic;
			Done        : out Std_logic
 
			--outing_n	: out std_logic ;
			--outing_a	: out std_logic_vector(31 downto 0) ;
			--outing_b	: out std_logic_vector(31 downto 0) ;
			--outing_c	: out std_logic_vector(31 downto 0) ;
			--outing_d	: out std_logic_vector(31 downto 0) 
			);
end top;

architecture susunan of TOP is

COMPONENT datapath_in IS
	PORT(
		clk							: IN STD_LOGIC;
		rst							: IN STD_LOGIC;
		enable						: IN STD_LOGIC;
		rx_ina		 				: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		rx_inb		 				: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		rx_inc		 				: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		rx_ind		 				: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		enable_branch				: OUT STD_LOGIC;
		a_out, b_out, c_out, d_out	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END COMPONENT;

COMPONENT branch IS
	PORT(
		rst			: IN STD_LOGIC;
		clk			: IN STD_LOGIC;
		enable		: in Std_logic;
		i_M			: IN STD_LOGIC;
		i_N			: IN STD_LOGIC;
		i_a			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_b			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_c			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_d			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		o			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
END COMPONENT;

COMPONENT ConOut is generic(N: positive := 32);
	port(
			clk, reset: in std_logic;
			binary_in: in std_logic_vector(N-1 downto 0);
			bcd9,bcd8,bcd7,bcd6,bcd5,bcd4,bcd3,bcd2,bcd1,bcd0: out std_logic_vector(7 downto 0)
		);
end COMPONENT ;

--COMPONENT komparator_nol IS
--	PORT(  
--		input: in std_logic_vector( 31 downto 0 );  
--		is_nol	: out std_logic
--	);
--END COMPONENT;

signal enable_branch : std_logic;
signal a , b ,c ,d , oop : std_logic_vector (31 downto 0);
signal Rx_inputa, Rx_inputb, Rx_inputc, Rx_inputd	: std_logic_vector (23 downto 0);
signal MSBop , B8op , B7op , B6op , B5op , B4op , B3op , B2op , B1op , LSBop : std_logic_vector (7 downto 0);
signal ups : std_logic;

begin
process(enable, Rx_ina, Rx_inb, Rx_inc, Rx_ind)
BEGIN
IF(enable ='1') THEN
	Rx_inputa <= Rx_ina;
	Rx_inputb <= Rx_inb;
	Rx_inputc <= Rx_inc;
	Rx_inputd <= Rx_ind;
ELSE
	Rx_inputa <= (others=>'0');
	Rx_inputb <= (others=>'0');
	Rx_inputc <= (others=>'0');
	Rx_inputd <= (others=>'0');
END IF;
END PROCESS;

process (MSBop , B8op , B7op , B6op , B5op , B4op , B3op , B2op , B1op , LSBop)
begin
    if (MSBop /= "00110000") or (B8op /= "00110000") or (B7op /= "00110000") or (B6op /= "00110000") or (B5op /= "00110000") or (B4op /= "00110000") or (B3op /= "00110000") or (B2op /= "00110000") or (B1op /= "00110000") or (LSBop /= "00110000") then
        Done <= '1';
        ups <= '1';
    else
        Done <= '0';
        ups <= '0';
    end if;
end process;


MSB <= MSBop;
B8 <= B8op;
B7 <= B7op;
B6 <= B6op;
B5 <= B5op;
B4 <= B4op;
B3 <= B3op;
B2 <= B2op;
B1 <= B1op;
LSB <= LSBop;


INPUT		: datapath_in port map (clk , rst , enable, Rx_inputa, Rx_inputb, Rx_inputc, Rx_inputd, enable_branch, a , b , c , d); 
BRANCHING1	: branch port map (rst , clk , enable_branch,m_in , n_in ,a , b , c ,d ,oop );
OUTPUT		: ConOut port map (clk , rst , oop , MSBop , B8op ,B7op ,B6op ,B5op ,B4op ,B3op ,B2op ,B1op ,LSBop);
--kompNol		: komparator_nol port map (oop, ups);
-- outing_oop <= oop;
outing_selesai <= enable_branch;

end susunan;