LIBRARY IEEE;
USE ieee.std_logic_1164.all;

PACKAGE SADLib IS

COMPONENT Regn IS
 GENERIC( DATA_WIDTH: integer :=8);
 PORT (
	RST, CLK: IN STD_LOGIC;
	En: IN STD_LOGIC;
	D: IN STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0);
	Q: OUT STD_LOGIC_VECTOR(DATA_WIDTH - 1 downto 0)
	
 );
END COMPONENT;

COMPONENT Mem is
  generic (
    DATA_WIDTH        :     integer   := 8;                              -- Word Width
    ADDR_WIDTH        :     integer   := 4                               -- Address width
    );

  port (
    CLK               : in  std_logic;                                   -- clock
    AddR              : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);   -- Address
    WE                : in  std_logic;                                   -- Write Enable
    RE                : in  std_logic;                                   -- Read Enable
    Din               : in  std_logic_vector(DATA_WIDTH - 1 downto 0);   -- Data input
    Dout              : out std_logic_vector(DATA_WIDTH - 1 downto 0)    -- Data output
    );
end COMPONENT;

COMPONENT Datapath_SAD IS
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
	Data_out: OUT STD_LOGIC_VECTOR(2*DATA_WIDTH - 1 downto 0);
	Zi,Zj: OUT STD_LOGIC
 );
END COMPONENT;

COMPONENT Controller_SAD IS
 PORT (
	RST, CLK, Start: IN STD_LOGIC;
	Done: OUT STD_LOGIC;
	En_i, En_j, LD_i, LD_j, RE_A, RE_B, En_SUM: OUT STD_LOGIC;
	Zi, Zj: IN STD_LOGIC
 );
END COMPONENT;

COMPONENT counter_n IS 
    GENERIC (N : Integer := 2);
    PORT (CLK:  IN std_logic;
	RST: IN std_logic;
	En: IN std_logic;
	LD : IN std_logic;
	D  : IN std_logic_vector(N-1 downto 0);
	Q:  OUT std_logic_vector(N-1 downto 0));
END COMPONENT;

COMPONENT sad IS
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
	Data_out: OUT STD_LOGIC_VECTOR(2 * DATA_WIDTH - 1 downto 0);
	Done: OUT STD_LOGIC
 );
END COMPONENT;

END SADlib;