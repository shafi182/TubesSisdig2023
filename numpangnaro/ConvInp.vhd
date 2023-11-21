library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
--USE IEEE.numeric_std.all;
USE IEEE.math_real.all;
use work.all;

ENTITY convinp IS
	PORT(
		clk		: IN STD_LOGIC;
		serinput	: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		rst		: in std_logic;
		counting : out integer;
		binout	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
END convinp;

ARCHITECTURE behavioral OF convinp IS

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

SIGNAL count : integer ;
SIGNAL op	: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL op2	: STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL int0	: integer := 0;
--SIGNAL intop	: integer := 0;
--SIGNAL int2	: integer := 0;
Signal stopping : integer;

COMPONENT Kaunter is
	port(
		 clockasli : in STD_Logic;
		 output : Buffer Integer 
		 );
End COMPONENT;

 

BEGIN

menghitung : Kaunter PORT MAP ( clk,count);

PROCESS(clk, serinput,op, op2, count)
BEGIN
IF (clk'EVENT AND clk = '1') THEN
	IF (serinput(7 DOWNTO 4) = "0011") THEN
		op(3 DOWNTO 0) <= serinput(3 DOWNTO 0);
	ELSE
		binout(7 DOWNTO 0) <= serinput;
	END IF;
end if;

if (count = 2) and (stopping /= 1) then
	op2 <= op2 + op * "1010" * "1010";
elsif (count = 1) and (stopping /=1) then
	op2 <= op2 + op * "1010";
elsif (count = 0) and (stopping /=1) then
	op2 <= op2 + op;
	stopping <= 2;
	binout <= op2;
end if;

if rst = '1' then
	stopping <= 0;
end if;

end process;

end behavioral;