library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_8bitreg is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        en      : in std_logic;
        data_in : in std_logic_vector(data_range);
        output  : out std_logic_vector(data_range)
    );
end alu_8bitreg;

architecture reg of alu_8bitreg is
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            output <= (others => '0');
        elsif(rising_edge(clk)) then
            if(en = '1') then
                output <= data_in;
            end if;
        end if;
    end process;
end reg;
