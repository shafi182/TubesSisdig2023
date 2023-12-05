library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all; 
use work.all;

entity conbil is
    port(
        enable  : in std_logic;
        bil100  : in std_logic_vector(3 DOWNTO 0);
        bil10   : in std_logic_vector(3 DOWNTO 0);
        bil1    : in std_logic_vector(3 DOWNTO 0);
        outbil  : out std_logic_vector(31 DOWNTO 0)
    );
END conbil;

ARCHITECTURE behavioral OF conbil is
    BEGIN
    PROCESS(enable, bil100, bil10, bil1)
    BEGIN
    IF (enable = '1') THEN
        outbil(10 DOWNTO 0) <= (bil100 * "1100100") + bil10 * "1010" + bil1;
    else
        outbil <= (others => '0');
    END IF;
    END PROCESS;
END behavioral;