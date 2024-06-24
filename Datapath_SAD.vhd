LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.SADlib.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE IEEE.numeric_std.all;

ENTITY Datapath_SAD IS
 GENERIC (
    DATA_WIDTH        :     integer   := 8;    
    ADDR_WIDTH        :     integer   := 4;
    M                 :     integer   := 4;     
    N                 :     integer   := 4
    );
 PORT (
	RST, CLK: IN STD_LOGIC;
	Start: IN STD_LOGIC;
	En_i, En_j, LD_i, LD_j: IN  STD_LOGIC;
	RE_A, WE_A, RE_B, WE_B: IN  STD_LOGIC;
	En_SUM: IN STD_LOGIC;
	ADDR_in: IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
	Data_A, Data_B: IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	Data_out: OUT STD_LOGIC_VECTOR( 2 * DATA_WIDTH - 1 downto 0);
	Zi,Zj: OUT STD_LOGIC
 );
END Datapath_SAD;

ARCHITECTURE RTL OF Datapath_SAD IS
 SIGNAL Sum, Din_A, Dout_A, Din_B, Dout_B, Abs_AB: STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
 SIGNAL Z_AB, Q_SUM: STD_LOGIC_VECTOR ( 2 * DATA_WIDTH - 1 downto 0);
 SIGNAL Addr_ij, Addr_fin: STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
 SIGNAL i,j : STD_LOGIC_VECTOR (ADDR_WIDTH - 1 downto 0);
 SIGNAL Comp_AB: STD_LOGIC;

 BEGIN
        Zi <= '1' WHEN conv_integer(i) < M ELSE '0';
        Zj <= '1' WHEN conv_integer(j) < N ELSE '0';

	Addr_ij <= conv_std_logic_vector(conv_integer(i) * M + conv_integer(j), ADDR_WIDTH);
	Addr_fin <= ADDR_in WHEN Start = '0' ELSE Addr_ij;

	Comp_AB <= '1' WHEN Dout_A > Dout_B ELSE '0';
	Abs_AB <= Dout_A - Dout_B WHEN Comp_AB ='1' ELSE Dout_B - Dout_A;

	Din_A <= Data_A WHEN Start = '0' ELSE "00000000";
	Din_B <= Data_B WHEN Start = '0' ELSE "00000000";
	Z_AB <= "00000000"&Abs_AB + Q_SUM;
		
	Data_out <= Z_AB;
	
	----------
	REG_SUM: Regn
        GENERIC MAP (
            DATA_WIDTH => 2 * DATA_WIDTH
        )
        PORT MAP (
            RST => RST,
            CLK => CLK,
            En => En_SUM,
            D => Z_AB,
            Q => Q_SUM
        );

    	MemA: Mem
	GENERIC MAP (
            DATA_WIDTH => DATA_WIDTH,
	    ADDR_WIDTH => ADDR_WIDTH
        )
        PORT MAP (
            CLK => CLK,                       
   	    Addr => Addr_fin,          
    	    WE => WE_A,           
    	    RE => RE_A,         
    	    Din => Data_A,          
   	    Dout => Dout_A  
        );
	
	MemB: Mem
	GENERIC MAP (
            DATA_WIDTH => DATA_WIDTH,
	    ADDR_WIDTH => ADDR_WIDTH
        )
        PORT MAP (
            CLK => CLK,                       
   	    Addr => Addr_fin,          
    	    WE => WE_B,           
    	    RE => RE_B,         
    	    Din => Data_B,          
   	    Dout => Dout_B  
        );

 	Counter_i: counter_n
	GENERIC MAP (
            N => ADDR_WIDTH
        )
        PORT MAP (
            CLK => CLK,               
    	    RST => RST,               
    	    En => En_i,           
    	    LD => LD_i,         
    	    D => (OTHERS => '0'),
   	    Q => i  
        );
	
	Counter_j: counter_n
	GENERIC MAP (
            N => ADDR_WIDTH
        )
        PORT MAP (
            CLK => CLK,               
    	    RST => RST,               
    	    En => En_j,           
    	    LD => LD_j,         
    	    D => (OTHERS => '0'),
   	    Q => j  
        );
 END RTL;
