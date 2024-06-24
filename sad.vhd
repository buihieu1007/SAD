LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE work.SADLib.all;

ENTITY SAD IS
 GENERIC (
    DATA_WIDTH        :     integer   := 8;    
    ADDR_WIDTH        :     integer   := 4     
    );
 PORT (
	RST, CLK: IN STD_LOGIC;
	Start: IN STD_LOGIC;
	WE_A: IN  STD_LOGIC;
	WE_B: IN STD_LOGIC;
	Addr_in: IN STD_LOGIC_VECTOR(ADDR_WIDTH - 1 downto 0);
	Data_A : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	Data_B : IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	Data_out: OUT STD_LOGIC_VECTOR(2*DATA_WIDTH - 1 downto 0);
	Done: OUT STD_LOGIC
 );
END SAD;

ARCHITECTURE RTL OF SAD IS
 SIGNAL RE_A, RE_B, En_SUM, En_i, En_j, LD_i, LD_j, Zi, Zj: STD_LOGIC;
 SIGNAL M: INTEGER :=4;
 SIGNAL N: INTEGER :=4;
 BEGIN
 CTRL_UNIT: Controller_SAD
 PORT MAP (
	RST => RST, 
	CLK => CLK, 
	Start => Start,
	Done => Done,
    	RE_A => RE_A,
	RE_B => RE_B,
	En_SUM => EN_SUM,
	En_i => En_i,
	En_j => En_j,
	LD_i => LD_i,
	LD_j => LD_j,
	Zi => Zi,
	Zj => Zj
 );
 Datapath_unit: Datapath_SAD 
 GENERIC MAP (DATA_WIDTH, ADDR_WIDTH, M, N)
 PORT MAP(
    	RST => RST, 
	CLK => CLK, 
    	Start => Start, 
	WE_A => WE_A,
	WE_B => WE_B,
	Addr_in => Addr_in,
	Data_A => Data_A,
	Data_B => Data_B,
	Data_out => Data_out,
    	RE_A => RE_A,
	RE_B => RE_B,
	En_SUM => EN_SUM,
	En_i => En_i,
	En_j => En_j,
	LD_i => LD_i,
	LD_j => LD_j,
	Zi => Zi,
	Zj => Zj
 );
 END RTL;