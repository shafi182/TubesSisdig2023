library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.all;
		
		
ENTITY branch IS
	PORT(
		rst			: IN STD_LOGIC;
		clk			: IN STD_LOGIC;
		i_M			: IN STD_LOGIC;
		i_N			: IN STD_LOGIC;
		i_a			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_b			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_c			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		i_d			: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		o			: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END branch;

ARCHITECTURE behavioral OF branch IS

COMPONENT datapath_kpk IS
	PORT(
		rst, clk 	: in std_logic;
		a, b, c, d	: in std_logic_vector(31 downto 0); 
		output		: out std_logic_vector(31 downto 0)
		);
END COMPONENT;


COMPONENT fpb IS
	PORT(
		rst,clk 	: in std_logic ;
		a,b,c,d 	: in std_logic_vector (31 downto 0);
		output 		: out std_logic_vector (31 downto 0)
		);
END COMPONENT;

COMPONENT mux IS
	PORT(
		rst, selektor: in std_logic;  
		input0, input1: in std_logic_vector( 31 downto 0 );  
		output: out std_logic_vector( 31 downto 0 )  
		);  
END COMPONENT;


COMPONENT demux IS
	PORT(
		selektor		: in std_logic;  
		input			: in std_logic_vector( 31 downto 0 );  
		output0, output1: out std_logic_vector( 31 downto 0 )  
		);  
END COMPONENT;


signal output0_demux1, output1_demux1, output0_demux2, output1_demux2, output0_demux3, output1_demux3, output0_demux4, output1_demux4, output_mux1, output_mux2  : std_logic_vector( 31 downto 0 );
signal output_kpk, output_fpb : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN
	--DEMUX
	Demux1 : demux port map(i_M, i_a, output0_demux1, output1_demux1);
	Demux2 : demux port map(i_M, i_b, output0_demux2, output1_demux2);
	Demux3 : demux port map(i_M, i_c, output0_demux3, output1_demux3);
	Demux4 : demux port map(i_M, i_d, output0_demux4, output1_demux4);
	
	--MUX
	Mux1   : mux port map(rst, i_N, output0_demux3, output0_demux4, output_mux1);
	Mux2   : mux port map(rst, i_N, output1_demux3, output1_demux4, output_mux2);
	Mux3   : mux port map(rst, i_M, output_fpb, output_kpk, o);
	
	--FPB
	B_FPB  : fpb port map(rst, clk, output0_demux1, output0_demux2, output0_demux3, output_mux1, output_fpb);
	
	--KPK
	B_KPK  : datapath_kpk port map(rst, clk, output1_demux1, output1_demux2, output1_demux3, output_mux2, output_kpk);
	
END behavioral;
