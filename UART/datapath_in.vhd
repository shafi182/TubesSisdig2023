library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use IEEE.numeric_std.all;
use work.all;

ENTITY datapath_in IS
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
END datapath_in;

ARCHITECTURE behavioral OF datapath_in IS
	COMPONENT ConSer IS
	PORT(
		inserial	: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		output100	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		output10	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		output1		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT conbil IS
	port(
        enable  : in std_logic;
        bil100  : in std_logic_vector(3 DOWNTO 0);
        bil10   : in std_logic_vector(3 DOWNTO 0);
        bil1    : in std_logic_vector(3 DOWNTO 0);
        outbil  : out std_logic_vector(31 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT regis IS  
	port( 
		rst, clk, load: in std_logic;  
		input: in std_logic_vector( 31 downto 0 );  
		output: out std_logic_vector( 31 downto 0 )  
		);  
	end COMPONENT;  
	
	COMPONENT komparator_nol is  port(  
		input: in std_logic_vector( 31 downto 0 );  
		is_nol	: out std_logic
		);
	END COMPONENT;  
	
	--SIGNAL consout, regmout, regnout	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL ea, eb, ec, ed	: STD_LOGIC;
	SIGNAL aop100, aop10, aop1, bop100, bop10, bop1, cop100, cop10, cop1, dop100, dop10, dop1 : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL aopout, bopout, copout, dopout	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL aout, bout, cout, dout	: STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL selesaiop, selesaia, selesaib, selesaic, selesaid, fillm, filln : STD_LOGIC;
	
	BEGIN
	CONSERA : ConSer PORT MAP(rx_ina, aop100, aop10, aop1);
	CONSERB : ConSer PORT MAP(rx_inb, bop100, bop10, bop1);
	CONSERC : ConSer PORT MAP(rx_inc, cop100, cop10, cop1);
	CONSERD : ConSer PORT MAP(rx_ind, dop100, dop10, dop1);
	CONBILA	: conbil PORT MAP(enable, aop100, aop10, aop1, aopout);
	CONBILB	: conbil PORT MAP(enable, bop100, bop10, bop1, bopout);
	CONBILC	: conbil PORT MAP(enable, cop100, cop10, cop1, copout);
	CONBILD	: conbil PORT MAP(enable, dop100, dop10, dop1, dopout);
	REGA	: regis PORT MAP( rst, clk, not(ea), aopout, aout);
	REGB	: regis PORT MAP( rst, clk, not(eb), bopout, bout);
	REGC	: regis PORT MAP( rst, clk, not(ec), copout, cout);
	REGD	: regis PORT MAP( rst, clk, not(ed), dopout, dout);
	KOMA	: komparator_nol PORT MAP( aopout, ea);
	KOMB	: komparator_nol PORT MAP( bopout, eb);
	KOMC	: komparator_nol PORT MAP( copout, ec);
	KOMD	: komparator_nol PORT MAP( dopout, ed);
	a_out <= aout;
	b_out <= bout;
	c_out <= cout;
	d_out <= dout;
	
	PROCESS(ea, eb, ec, ed)
	BEGIN
	IF(ea = '0' AND eb = '0' AND ec = '0' AND ed = '0')THEN
		enable_branch <= '0';
	ELSE
		enable_branch <= '1';
	END IF;
	END PROCESS;
	END behavioral;