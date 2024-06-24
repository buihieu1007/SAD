LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY Regn IS
 GENERIC( DATA_WIDTH: integer :=8);
 PORT (
	RST, CLK: IN STD_LOGIC;
	En: IN STD_LOGIC;
	D: IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	Q: OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
 );
END Regn;

ARCHITECTURE RTL OF Regn IS
 BEGIN
	PROCESS (RST, CLK)
	BEGIN
	 IF(RST = '1') THEN
	 	Q <= (OTHERS => '0');
	 ELSIF(CLK'EVENT and CLK = '1') THEN
	  IF(En = '1') THEN
		Q <= D;
	  END IF;
	 END IF;
	END PROCESS;
 END RTL;