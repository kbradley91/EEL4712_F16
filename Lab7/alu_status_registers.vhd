library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.alu_lib.all;


entity alu_status_registers is
    port(
        c_flag_in   : in std_logic;
        v_flag_in   : in std_logic;
        z_flag_in   : in std_logic;
        s_flag_in   : in std_logic;
        clk         : in std_logic;
        rst         : in std_logic;
        c_flag_out  : out std_logic;
        v_flag_out  : out std_logic;
        z_flag_out  : out std_logic;
        s_flag_out   : out std_logic
    );
end alu_status_registers;

architecture build of alu_status_registers is
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            c_flag_out <= '0';
            v_flag_out <= '0';
            z_flag_out <= '0';
            s_flag_out <= '0';
        elsif(rising_edge(clk)) then
            c_flag_out <= c_flag_in;
            v_flag_out <= v_flag_in;
            z_flag_out <= z_flag_in;
            s_flag_out <= s_flag_in;
        end if;
    end process;



end build;