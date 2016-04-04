library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_index is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        en_h    : in std_logic;
        en_l    : in std_logic;
        dec_x   : in std_logic;
        inc_x   : in std_logic;        
        data_in : in std_logic_vector(data_range);
        X_h     : out std_logic_vector(data_range);
        x_l     : out std_logic_vector(data_range)
    );
end alu_index;

architecture reg of alu_index is
begin
    process(clk, rst)
        variable out_temp : std_logic_vector(15 downto 0);
    begin
        if(rst = '1') then
            out_temp := (others => '0');
            x_h <= (others => '0');
            x_l <= (others => '0');
        elsif(rising_edge(clk)) then
            if(en_h = '1') then 
                out_temp(15 downto 8) := data_in;
            elsif(en_l = '1') then
                out_temp(7 downto 0) := data_in;
            elsif(dec_x = '1') then
                out_temp := std_logic_vector(unsigned(out_temp)-1);
            elsif(inc_x = '1') then
                out_temp := std_logic_vector(unsigned(out_temp)+1);
            end if;
            x_h <= out_temp(15 downto 8);
            x_l <= out_temp(7 downto 0);
            end if;
    end process;
end reg;
