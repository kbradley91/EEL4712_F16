library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;


entity small8_cpu_TB is
end small8_cpu_TB;

architecture TB of small8_cpu_TB is
    signal clk, rst : std_logic := '1';
    signal data, output : std_logic_vector(data_range);
begin
    u_cpu   : entity work.small8_cpu
        port map(
            clk => clk,
            rst => rst,
            data => data,
            output  => output
        );
        
    clk <= not clk after 5 ns;
    
    process
    begin
        rst <= '1';
        wait until rising_edge(clk);
        rst <= '0';
        wait until rising_edge(clk);
        data <= x"84";
        wait until rising_edge(clk);
        data <= x"ff";
        wait until rising_edge(clk);
        data <= x"81";
        wait until rising_edge(clk);
        wait until rising_edge(clk);  
        wait until rising_edge(clk);         
        
        
        assert false report "Simulation Finished" severity failure;
        
        
        
    end process;
    

end TB; 
    