library ieee;
use ieee.std_logic_1164.all;

-- Testbench Entity
entity Mem_tb is
end Mem_tb;

architecture sim of Mem_tb is
    constant DATA_WIDTH : integer := 8;
    constant ADDR_WIDTH : integer := 2;

    signal CLK : std_logic := '0';  -- Clock signal
    signal AddR : std_logic_vector(ADDR_WIDTH - 1 downto 0);  -- Address
    signal WE : std_logic := '0';  -- Write enable
    signal RE : std_logic := '0';  -- Read enable
    signal Din : std_logic_vector(DATA_WIDTH - 1 downto 0);  -- Input data
    signal Dout : std_logic_vector(DATA_WIDTH - 1 downto 0); -- Output data
Begin
    uut: entity work.Mem
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            ADDR_WIDTH => ADDR_WIDTH
        )
        port map (
            CLK => CLK,
            AddR => AddR,
            WE => WE,
            RE => RE,
            Din => Din,
            Dout => Dout
        );
    process
    begin
        AddR <= (others => '0');
        Din <= (others => '0');
        WE <= '0';
        RE <= '0';

        Din <= "00000011"; -- 3
        AddR <= "00";
        WE <= '1';
        wait for 10 ns; 

        Din <= "00000100"; -- 4
        AddR <= "01";
        WE <= '1';
        wait for 10 ns;

        Din <= "00000010"; -- 3
        AddR <= "10";
        WE <= '1';
        wait for 10 ns; 

        Din <= "00000001"; -- 4
        AddR <= "11";
        WE <= '1';
        wait for 10 ns;

        -- Chu k? ki?m tra 3: ??c giá tr? t? ??a ch? ??u tiên
        AddR <= "00";
        WE <= '0';
        RE <= '1';
        wait for 10 ns;

        -- Chu k? ki?m tra 4: ??c giá tr? t? ??a ch? th? hai
        AddR <= "01";
        wait for 10 ns;

	-- Chu k? ki?m tra 4: ??c giá tr? t? ??a ch? th? hai
        AddR <= "10";
        wait for 10 ns;

	-- Chu k? ki?m tra 4: ??c giá tr? t? ??a ch? th? hai
        AddR <= "11";
        wait for 10 ns;
        -- D?ng ki?m tra
        wait;
    end process;
    
    -- T?o process ?? t?o tín hi?u xung clock
    clk_process : process
    begin
        CLK <= '0';
        wait for 5 ns;
        CLK <= '1';
        wait for 5 ns;
    end process clk_process;

end sim;

