library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_ar is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        en_h    : in std_logic;
        en_l    : in std_logic;
        data_in : in std_logic_vector(data_range);
        ar_h     : out std_logic_vector(data_range);
        ar_l     : out std_logic_vector(data_range)
        
    );
end alu_ar;

architecture reg of alu_ar is
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            ar_h <= (others => '0');
            ar_l <= (others => '0');
        elsif(rising_edge(clk)) then
            if(en_h = '1') then
                ar_h <= data_in;
            end if;
            if(en_l = '1') then
                ar_l <= data_in;
            end if;
        end if;
    end process;
end reg;
