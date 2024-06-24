library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
ENTITY counter_n IS 
    GENERIC (N : Integer := 2);
    PORT (
	CLK: IN std_logic;
	RST: IN std_logic;
	En : IN std_logic;
	LD : IN std_logic;
	D  : IN std_logic_vector(N-1 downto 0);
	Q  : OUT std_logic_vector(N-1 downto 0));
END counter_n;
ARCHITECTURE RTL OF counter_n IS
  SIGNAL pre_count: std_logic_vector(N-1 downto 0);  BEGIN
  PROCESS(CLK, En, RST)
	BEGIN
		IF RST = '1' THEN
			pre_count <= (OTHERS =>'0');
		ELSIF (CLK='1' and CLK'EVENT) THEN
		        IF LD = '1' THEN
				pre_count <= D;
		        ELSIF En = '1' THEN
				pre_count <= pre_count + "1"; 
			END IF;
		END IF;
    END PROCESS;
    Q <= pre_count;
END RTL;

