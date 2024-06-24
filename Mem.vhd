library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

entity Mem is
  generic (
    DATA_WIDTH        :     integer   := 8;                              -- Word Width
    ADDR_WIDTH        :     integer   := 2                               -- Address width
    );

  port (
    CLK               : in  std_logic;                                   -- clock
    AddR              : in  std_logic_vector(ADDR_WIDTH - 1 downto 0);   -- Address
    WE                : in  std_logic;                                   -- Write Enable
    RE                : in  std_logic;                                   -- Read Enable
    Din               : in  std_logic_vector(DATA_WIDTH - 1 downto 0);   -- Data input
    Dout              : out std_logic_vector(DATA_WIDTH - 1 downto 0)    -- Data output
    );
end Mem;

architecture spmem_arch of Mem is
  type MEM_ARRAY is array (natural range <>) of std_logic_vector(DATA_WIDTH - 1 downto 0); 
  signal   M          :     MEM_ARRAY(0 to (2**ADDR_WIDTH) - 1) := (others => (others => '0'));  

begin  
  RW_Proc : process (CLK)
  begin
    if (CLK'EVENT and CLK = '1') then   
      if WE = '1' then
        M(conv_integer(addr)) <= Din; 
      elsif RE = '1' then
       Dout <= M(conv_integer(addr));
      end if;
    end if;
  end process RW_Proc;
end spmem_arch;
