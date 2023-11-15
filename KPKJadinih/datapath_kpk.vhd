library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.all;


entity datapath_kpk is
port( 
	rst, clk 	: in std_logic;
	a, b, c, d	: in std_logic_vector(31 downto 0); 
	output		: out std_logic_vector(31 downto 0)
	);
end datapath_kpk;

architecture datapath_kpk_arc of datapath_kpk is

component fsm_kpk is
	port(rst, clk										: in std_logic;
		load_a,load_b,load_c,load_d						: in std_logic; 	-- penentu untuk load nilai awal
		Enable_a, Enable_b, Enable_c, Enable_d 			: out std_logic;	-- register nilai input awal
		Enable_aop, Enable_bop, Enable_cop, Enable_dop 	: out std_logic;	-- register nilai operasi
		P, I											: in std_logic;		-- a = b
		Q, J											: in std_logic;		-- a > b
		R, K											: out std_logic;	-- mux adder
		Y												: out std_logic;	-- mux setelah 1 tahap
		Z												: out std_logic		-- meneruskan nilai output kpk
	);
end component;
	
component regis is
	port(rst, clk, load: in std_logic;  
		input: in std_logic_vector( 31 downto 0 );  
		output: out std_logic_vector( 31 downto 0 ) 
	);
end component;

component komparator_nol is
	port(input: in std_logic_vector( 31 downto 0 );  
		is_nol	: out std_logic
	);
end component;

component SEL is
	port(rst, selektor: in std_logic;  
		input0, input1: in std_logic_vector( 31 downto 0 );  
		output: out std_logic_vector( 31 downto 0 )
	);
end component;

component komparator_kpk is
	port(a, b: in std_logic_vector( 31 downto 0 );  
		a_eq_b	: out std_logic;
		a_greaterThan_b	: out std_logic
	);
end component;

component Adder32Bit is
	port(A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)--;
		--Cout : OUT STD_LOGIC
	);
end component;

signal load_a, load_b, load_c, load_d, Enable_a, Enable_b, Enable_c, Enable_d, Enable_aop, Enable_bop, Enable_cop, Enable_dop, P, I, Q, J, R, K, Y, Z : std_logic;
signal output_mux1, output_mux2, output_mux3, output_mux4, output_mux5, output_mux6, output_mux7, output_mux8, output_mux9,output_mux10, output_adder1, output_adder2 : std_logic_vector( 31 downto 0 );
signal output_regA, output_regB, output_regC, output_regD, output_regAop, output_regBop, output_regCop, output_regDop : std_logic_vector( 31 downto 0 );

begin	
	-- FSM Controller
	FSM : fsm_kpk port map(rst, clk, load_a, load_b, load_c, load_d, 
							Enable_a, Enable_b, Enable_c, Enable_d, 
							Enable_aop, Enable_bop, Enable_cop, Enable_dop, 
							P, I, Q, J, 
							R, K, Y, Z
							);
	-- Datapath KPK
	-- MUX
	Mux1 : SEL port map(rst, load_a, output_adder1, a, output_mux1);
	Mux2 : SEL port map(rst, load_b, output_adder1, b, output_mux2);
	Mux3 : SEL port map(rst, load_c, output_adder2, c, output_mux3);
	Mux4 : SEL port map(rst, load_d, output_adder2, d, output_mux4);
	Mux5 : SEL port map(rst, R, output_regA, output_regB, output_mux5);
	Mux6 : SEL port map(rst, R, output_regAop, output_regBop, output_mux6);
	Mux7 : SEL port map(rst, K, output_regC, output_regD, output_mux7);
	Mux8 : SEL port map(rst, K, output_regCop, output_regDop, output_mux8);
	Mux9 : SEL port map(rst, Y, output_mux2, output_regCop, output_mux9);
	Mux10 : SEL port map (rst , Y , output_mux1 , output_regAop , output_mux10);
	-- register
	RegA : regis port map(rst, clk, Enable_a, output_mux10, output_regA);
	RegB : regis port map(rst, clk, Enable_b, output_mux9, output_regB);
	RegC : regis port map(rst, clk, Enable_c, output_mux3, output_regC);
	RegD : regis port map(rst, clk, Enable_d, output_mux4, output_regD);
	RegAop : regis port map(rst, clk, Enable_aop, output_mux10, output_regAop);
	RegBop : regis port map(rst, clk, Enable_bop, output_mux9, output_regBop);
	RegCop : regis port map(rst, clk, Enable_cop, output_mux3, output_regCop);
	RegDop : regis port map(rst, clk, Enable_dop, output_mux4, output_regDop);
	-- komparator
	nolA : komparator_nol port map(output_regA, load_a);
	nolB : komparator_nol port map(output_regB, load_b);
	nolC : komparator_nol port map(output_regC, load_c);
	nolD : komparator_nol port map(output_regD, load_d);
	komp1 : komparator_kpk port map(output_regAop, output_regBop, P, Q);
	komp2 : komparator_kpk port map(output_regCop, output_regDop, I, J);
	-- adder
	adder1 : Adder32Bit port map(output_mux6, output_mux5, output_adder1);
	adder2 : Adder32Bit port map(output_mux7, output_mux8, output_adder2);
	
process(Z)
begin
	if Z = '1' then
		output <= output_regBop;
	else
		output <= (others => '0');
	end if;
end process;

end datapath_kpk_arc;	