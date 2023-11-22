library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
--USE IEEE.numeric_std.all;
USE IEEE.math_real.all;
use work.all;

ENTITY conbil IS
	PORT(
		clk		: IN STD_LOGIC;
		in_asc0	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		rst		: in std_logic;
		counting : out integer;
		--in_asc1	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		--in_asc2	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		out_bnr	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END conbil;

ARCHITECTURE behavioral OF conbil IS

constant d0 : std_logic_vector (7 downto 0) := "00110000";
constant d1 : std_logic_vector (7 downto 0) := "00110001";
constant d2 : std_logic_vector (7 downto 0) := "00110010";
constant d3 : std_logic_vector (7 downto 0) := "00110011";
constant d4 : std_logic_vector (7 downto 0) := "00110100";
constant d5 : std_logic_vector (7 downto 0) := "00110101";
constant d6 : std_logic_vector (7 downto 0) := "00110110";
constant d7 : std_logic_vector (7 downto 0) := "00110111";
constant d8 : std_logic_vector (7 downto 0) := "00111000";
constant d9 : std_logic_vector (7 downto 0) := "00111001";

SIGNAL count : integer := 0 ;
SIGNAL op	: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL op2	: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL int0	: integer := 0;
SIGNAL intop	: integer := 0;
--SIGNAL int2	: integer := 0;
Signal stopping : integer;

COMPONENT Kaunter is
	port(
		 clockasli : in STD_Logic;
		 rst	   : in std_logic;
		 output : Buffer Integer 
		 );
End COMPONENT;

 

BEGIN

menghitung : Kaunter PORT MAP ( clk,rst, count);

PROCESS(clk, in_asc0,op, op2, count)
BEGIN
IF (clk'EVENT AND clk = '1') THEN
	IF (in_asc0(7 DOWNTO 4) = "0011") THEN
		op(3 DOWNTO 0) <= in_asc0(3 DOWNTO 0);
	--CASE in_asc0 IS
		--when d0 => int0 <= 0;
		--when d1 => int0 <= 1;
		--when d2 => int0 <= 2;
		--when d3 => int0 <= 3;
		--when d4 => int0 <= 4;
		--when d5 => int0 <= 5;
		--when d6 => int0 <= 6;
		--when d7 => int0 <= 7;
		--when d8 => int0 <= 8;
		--when d9 => int0 <= 9;
		--when others => null;
	--END CASE;
	
	ELSE
		out_bnr(7 DOWNTO 0) <= in_asc0;
	END IF;
counting <= count;
IF (count = 2) THEN
	op2 <= op * "1010" * "1010" ;
ELSIF (count =1) THEN
	op2 <= op2 + (op * "1010");
ELSIF (count = 0 and stopping /= 1) THEN
	op2 <= op2 + op;
	out_bnr(15 DOWNTO 0) <= op2;
	stopping <= 1;
END IF;

END IF;



END PROCESS;


END behavioral;