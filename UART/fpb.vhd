library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use work.all;

entity FPB is 
	port(rst,clk , enable :in std_logic ;
		a,b,c,d : in std_logic_vector (31 downto 0);
		output : out std_logic_vector (31 downto 0));
end FPB;

architecture fpb_arc of FPB is

COMPONENT Subtractor8Bit IS
		PORT( 
				A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
				D : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
				Bout : OUT STD_LOGIC
		);
END COMPONENT;

COMPONENT mux is  port( 
	rst, selektor: in std_logic;  
	input0, input1: in std_logic_vector( 31 downto 0 );  
	output: out std_logic_vector( 31 downto 0 )  
	);  
End COMPONENT; 

COMPONENT regis is  port( 
	rst, clk, load: in std_logic;  
	input: in std_logic_vector( 31 downto 0 );  
	output: out std_logic_vector( 31 downto 0 )  
	);  
end COMPONENT; 

COMPONENT komparator_fpb is  port(  
	a, b: in std_logic_vector( 31 downto 0 );  
	a_eq_b	: out std_logic;
	a_lowerThan_b	: out std_logic
	);
end COMPONENT;  

COMPONENT komparator_nol is  port(  
	input: in std_logic_vector( 31 downto 0 );  
	is_nol	: out std_logic
	);
end COMPONENT;

COMPONENT fsmfpb IS
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
end COMPONENT; 

signal load_a , load_b , load_c , load_d , Y , m1 , m2, Enable_A , Enable_B , Enable_C , Enable_D , U , T ,V ,W ,P: std_logic;
signal output_mux1 ,output_mux2 , output_mux3 , output_mux4 , output_mux5 , output_mux6 , output_mux7 , output_regA , output_regB , output_regC , output_regD , output_sub1 , output_sub2 , output_sub3 , output_sub4 : std_logic_vector (31 downto 0);

		
begin
	-- FSM Control
	EFESEM : fsmfpb port map (rst , clk , T , U , V ,W , load_a , load_b , load_c , load_d , M1 , M2 , P , Enable_a , Enable_b , Enable_c , Enable_d , Y);
	-- Datapath 
	Mux1 : mux port map(rst,load_a	,input0 => output_mux5 	, input1 => a 				, output => output_mux1);
	Mux2 : mux port map(rst,Y		,input0 => output_mux7 	, input1 => output_regC 	, output => output_mux2);
	Mux3 : mux port map(rst,load_c	,input0 => output_mux6 	, input1 => c 				, output => output_mux3);
	Mux4 : mux port map(rst,load_d	,input0 => output_mux6 	, input1 => d 				, output => output_mux4);
	Mux5 : mux port map(rst,m1		,input0 => output_Sub1 	, input1 => output_Sub2 	, output => output_mux5);
	Mux6 : mux port map(rst,m2		,input0 => output_Sub3 	, input1 => output_Sub4 	, output => output_mux6);
	Mux7 : mux port map(rst,load_b	,input0 => output_mux5 	, input1 => b 				, output => output_mux7);
	RegA : regis port map (rst , clk , load => Enable_A 	, Input => output_mux1 		, output => output_regA);
	RegB : regis port map (rst , clk , load => Enable_B 	, Input => output_mux2 		, output => output_regB);
	RegC : regis port map (rst , clk , load => Enable_C 	, Input => output_mux3 		, output => output_regC);
	RegD : regis port map (rst , clk , load => Enable_D 	, Input => output_mux4 		, output => output_regD);
	Komp1: komparator_fpb port map ( output_regA, output_regB , U , T);
	Komp2: komparator_fpb port map ( output_regC, output_regD , W , V);
	Sub1 : Subtractor8Bit port map ( output_regA, output_regB , D=>output_Sub1);
	Sub2 : Subtractor8Bit port map ( output_regB, output_regA , D=>output_Sub2);
	Sub3 : Subtractor8Bit port map ( output_regC, output_regD , D=>output_Sub3);
	Sub4 : Subtractor8Bit port map ( output_regD, output_regC , D=>output_Sub4);
	LodA : komparator_nol port map ( output_regA, load_a);
	LodB : komparator_nol port map ( output_regB, load_b);
	LodC : komparator_nol port map ( output_regC, load_c);
	LodD : komparator_nol port map ( output_regD, load_d);

process(P, enable, output_regB)
begin
 if (P = '1') and (enable = '0') then
	output <= output_regB;
else
	output<= (others=>'0');
	end if;
	end process;

end fpb_arc;