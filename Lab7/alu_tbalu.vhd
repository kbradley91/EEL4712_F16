library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_tbalu is
end alu_tbalu;

architecture TB of alu_tbalu is
    signal in1, in2, control, output : std_logic_vector(data_range);
    signal c_in, c_flag, v_flag, s_flag, z_flag : std_logic;
begin
    u_alu_test : entity work.alu_small8
        port map(
            in1 => in1,
            in2 => in2,
            c_in => c_in,
            control => control,
            output => output,
            c_flag  => c_flag,
            v_flag  => v_flag,
            s_flag  => s_flag,
            z_flag  => z_flag
        );
        
        
    process
    begin
        c_in <= '0';
        in1 <= x"00";
        in2 <= x"00";
        control <= x"00";
        wait for 20 ns;
        
        control <= x"01";
        wait for 5 ns;
        in1 <= x"01";
        in2 <= x"11";
        wait for 50 ns;
        
        control <= SBCR_D;
        wait for 20 ns;
        
        control <= CMPR_D;
        wait for 20 ns;
        
        control <= ANDR_D;
        wait for 20 ns;
        
        control <= ORR_D;
        wait for 20 ns;
        
        
        assert false report "Simulation Finished" severity failure;
    
    end process;
end TB;