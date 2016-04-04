library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity datapath_tb is

end datapath_tb;

architecture TB of datapath_tb is
    signal in0,in1,in2,in3,in4,in5,in6,in7,in8,in9 : std_logic_vector(data_range);
    signal en_v : std_logic_vector(9 downto 0);
    signal output : std_logic_vector(data_range);
    
begin
    u_tb    : entity work.alu_datapath
        port map(
            in0 => in0,
            in1 => in1,
            in2 => in2,
            in3 => in3,
            in4 => in4,
            in5 => in5,
            in6 => in6,
            in7 => in7,
            in8 => in8,
            in9 => in9,
            en_v => en_v,
            output => output
        );
    process
    begin
        in0 <= x"00";
        en_v <= (others => '0');
        wait for 20 ns;
        en_v(0) <= '1';
        wait for 20 ns;
        in0 <= x"FF";
        wait for 20 ns;
        assert false report "Simulation Finished" severity failure;
    end process;
    
end TB;
