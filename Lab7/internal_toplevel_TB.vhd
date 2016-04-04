library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity internal_toplevel_tb is
end internal_toplevel_tb;

architecture TB of internal_toplevel_tb is
    signal clk, rst : std_logic := '0';
    signal data_in, data_out : std_logic_vector(data_range);
    signal control  : std_logic_vector(23 downto 0) := (others => '0');
    signal datapath_control : std_logic_vector(9 downto 0) := (others => '0');
    signal addr_control : std_logic_vector(3 downto 0) := (others => '0');
    signal address_out : std_logic_vector(addr_range) := (others => '0');
begin

    
    
    u_int_tb    : entity work.internal_toplevel
        port map(
            clk => clk,
            rst => rst,
            data_in => data_in,
            data_out => data_out,
            control => control,
            datapath_control => datapath_control,
            addr_control => addr_control,
            address_out => address_out
        );
    
    clk <= not clk after 5 ns;
  
    process
    begin
        data_in <= (others => '0');
        control <= (others => '0');
        datapath_control <= "0000000000";
        addr_control <= (others => '0');
        wait for 10 ns;    
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;
        wait for 20 ns;
        datapath_control <= "1000000000";
        wait for 20 ns;
        
        --writing 1 to the accumulator register then driving the bus with it
        data_in <= "00000001";
        wait for 200 ns;
        addr_control(0) <= '1';        
        wait for 20 ns;
        control(17) <= '1';
        addr_control(3) <= '1';
        addr_control(0) <= '0';        
        wait for 20 ns;
        control <= (others => '0');
        datapath_control <= (others => '0');
        datapath_control(1) <= '1';
        wait for 20 ns;
        
        data_in <= x"ff";
        datapath_control <= (others => '0');
        datapath_control <= "1000000000";
        wait for 20 ns;
        
        --writing 0xFF to the PC.h then driving the bus with it
        control <= (others => '0');
        control(23) <= '1';
        wait for 20 ns;
        datapath_control <= (others => '0');
        datapath_control(5) <= '1';
        control <= (others => '0');
        
        --writing 0x77 to index_high then driving the bus with it
        data_in <= x"77";
        datapath_control <= (others => '0');
        datapath_control <= "1000000000";
        wait for 20 ns;
        control <= (others => '0');
        control(15) <= '1';
        wait for 20 ns;
        datapath_control <= (others => '0');
        datapath_control(3) <= '1';
        data_in <= x"00";
        
        --writing 0x22 to stack pointer then driving the bus with it
        data_in <= x"22";
        datapath_control <= (others => '0');
        datapath_control <= "1000000000";
        wait for 20 ns;
        control <= (others => '0');
        control(20) <= '1';
        wait for 20 ns;
        datapath_control <= (others => '0');
        datapath_control(7) <= '1';
        data_in <= x"00";
        control <= (others => '0');
        wait for 20 ns;
        addr_control(3) <= '1';
        addr_control(0) <= '0';
        wait for 40 ns;
        addr_control <= (others => '0');
        addr_control(0) <= '1';
        wait for 100 ns;
        control(21) <= '1';
        wait for 200 ns;
        
        data_in <= x"24";
        datapath_control <= (others => '0');
        datapath_control(9) <= '1';
        -- 24 is driving the data bus, gonna write to the b register and see if i can displace it
        wait for 40 ns;
        control <= (others => '0');
        control(8) <= '1';
        wait for 20 ns;
        control <= (others => '0');
        control(15) <= '1';
        data_in <= x"10";
        
        wait for 20 ns;
        control <= (others => '0');
        control(14) <= '1';
        data_in <= x"00";
        wait for 40 ns;
        addr_control <= (others => '0');
        addr_control(1) <= '1';
        wait for 40 ns;
        control <= (others => '0');
        control(7) <= '1';
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        wait for 500 ns;
        assert false report "Simulation Finished" severity failure;
    end process;
    
end TB;