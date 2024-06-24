LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.SADLib.all;

ENTITY SAD_tb IS
 
END SAD_tb;

ARCHITECTURE BEV OF SAD_tb IS
 Constant DATA_WIDTH        :     integer   := 8;
 Constant ADDR_WIDTH        :     integer   := 4;       
      
 SIGNAL RST, CLK: STD_LOGIC;
 SIGNAL Start: STD_LOGIC;
 SIGNAL Data_A: STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
 SIGNAL Data_B: STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
 SIGNAL Addr_in: STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
 SIGNAL Data_out: STD_LOGIC_VECTOR(2*DATA_WIDTH - 1 downto 0);
 SIGNAL WE_A, WE_B: STD_LOGIC;
 SIGNAL Done: STD_LOGIC;
 BEGIN
  UUT: sad 
  GENERIC MAP( DATA_WIDTH)
  PORT MAP (
	RST => RST,
    	CLK => CLK, 
    	Start => Start,
    	Data_A => Data_A,
    	Data_B => Data_B,
    	Addr_in => Addr_in,
    	Data_out => Data_out,
    	WE_A => WE_A,
    	WE_B => WE_B,
    	Done => Done
  );

 CLK_signal: PROCESS
 BEGIN
	CLK <= '1'; Wait for 5 ns;
	CLK <= '0'; Wait for 5 ns;
 END PROCESS;

 Stimulus: PROCESS
 BEGIN
	Start <= '0'; 	
	RST <= '1'; Wait for 10 ns;
	RST <= '0'; Wait for 15 ns;

        Data_A <= "01111111"; 
	Data_B <= "10000000";
        Addr_in <= "0000"; 
        WE_A <= '1'; 
        WE_B <= '1'; 
        Wait for 20 ns;

        Data_A <= "00101001"; 
	Data_B <= "00101000";
        Addr_in <= "0001"; 
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00011100";
	Data_B <= "00011101"; 
	Addr_in <= "0010"; 
	WE_A <= '1'; 
        WE_B <= '1';
	Wait for 20 ns;

	Data_A <= "00011101";
	Data_B <= "00011011";
	Addr_in <= "0011";
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00101010"; 
	Data_B <= "00000000";
        Addr_in <= "0100"; 
        WE_A <= '1'; 
        WE_B <= '1'; 
        Wait for 20 ns;

        Data_A <= "00100001"; 
	Data_B <= "00101000";
        Addr_in <= "0101"; 
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00011100";
	Data_B <= "00101101"; 
	Addr_in <= "0110"; 
	WE_A <= '1'; 
        WE_B <= '1';
	Wait for 20 ns;

	Data_A <= "01011101";
	Data_B <= "00011011";
	Addr_in <= "0111";
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "01111111"; 
	Data_B <= "10000000";
        Addr_in <= "1000"; 
        WE_A <= '1'; 
        WE_B <= '1'; 
        Wait for 20 ns;

        Data_A <= "00101001"; 
	Data_B <= "00101000";
        Addr_in <= "1001"; 
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00011100";
	Data_B <= "00011101"; 
	Addr_in <= "1010"; 
	WE_A <= '1'; 
        WE_B <= '1';
	Wait for 20 ns;

	Data_A <= "00011101";
	Data_B <= "00011011";
	Addr_in <= "1011";
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00101010"; 
	Data_B <= "00000000";
        Addr_in <= "1100"; 
        WE_A <= '1'; 
        WE_B <= '1'; 
        Wait for 20 ns;

        Data_A <= "00100001"; 
	Data_B <= "00101000";
        Addr_in <= "1101"; 
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	Data_A <= "00011100";
	Data_B <= "00101101"; 
	Addr_in <= "1110"; 
	WE_A <= '1'; 
        WE_B <= '1';
	Wait for 20 ns;

	Data_A <= "01011101";
	Data_B <= "00011011";
	Addr_in <= "1111";
	WE_A <= '1'; 
        WE_B <= '1'; 
	Wait for 20 ns;

	WE_A <= '0';
	WE_B <= '0';
	Start <= '1';


	wait until Done = '1';
	Start <= '0';

	Wait for 1000 ns;
	wait;
 	END PROCESS;
 END BEV;
