library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity alu_pcounter is
    port(
        --control signals
        clk     : in std_logic;
        rst     : in std_logic;
        pch_ld  : in std_logic;
        pcl_ld  : in std_logic;
        pc_inc : in std_logic;
        
        --bus signals
        data_in : in std_logic_vector(data_range);
        pch_out : out std_logic_vector(7 downto 0);
        pcl_out : out std_logic_vector(7 downto 0)
    );
    
end alu_pcounter;

architecture counter of alu_pcounter is
    signal pcl_in, pch_in : std_logic_vector(7 downto 0);
    signal test1, test2 : std_logic_vector(7 downto 0);
    
begin
   u_pcl    : entity work.alu_8bitreg
        port map(
            clk => clk,
            rst => rst,
            en  => pcl_ld,
            data_in => pcl_in,
            output => test1
        
        );
    u_pch   : entity work.alu_8bitreg
        port map(
            clk => clk,
            rst => rst,
            en  => pch_ld,
            data_in =>  pch_in,
            output  => test2
        
        );
    
end counter;

architecture fix_one of alu_pcounter is
    
    begin
    process(rst,clk)
        variable out_temp : std_logic_vector(15 downto 0);
    begin
        if(rst = '1') then
            out_temp := (others => '0');
            pch_out <= (others => '0');
            pcl_out <= (others => '0');
        elsif(rising_edge(clk)) then
            if(pch_ld = '1') then
                out_temp(15 downto 8) := data_in;
            elsif(pcl_ld = '1') then
                out_temp(7 downto 0) := data_in;
            elsif(pc_inc = '1') then
                out_temp := std_logic_vector(unsigned(out_temp)+1);
            end if;
            pch_out <= out_temp(15 downto 8);
            pcl_out <= out_temp(7 downto 0);
        end if;
        
    end process;
end fix_one;