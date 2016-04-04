library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;


entity alu_datapath is
    port(
        in0     : in std_logic_vector(data_range);
        in1     : in std_logic_vector(data_range);
        in2     : in std_logic_vector(data_range);
        in3     : in std_logic_vector(data_range);
        in4     : in std_logic_vector(data_range);
        in5     : in std_logic_vector(data_range);
        in6     : in std_logic_vector(data_range);
        in7     : in std_logic_vector(data_range);
        in8     : in std_logic_vector(data_range);
        in9     : in std_logic_vector(data_range);
        en_v    : in std_logic_vector(9 downto 0);
        output  : out std_logic_vector(data_range)
    );
end alu_datapath;

architecture data of alu_datapath is

begin

    U_TS0 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in0,
          en     => en_v(0),
          output => output);
    U_TS1 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in1,
          en     => en_v(1),
          output => output);
    U_TS2 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in2,
          en     => en_v(2),
          output => output);
    U_TS3 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in3,
          en     => en_v(3),
          output => output);
    U_TS4 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in4,
          en     => en_v(4),
          output => output);
    U_ts5 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in5,
          en     => en_v(5),
          output => output);
    U_ts6 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in6,
          en     => en_v(6),
          output => output);
    U_ts7 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in7,
          en     => en_v(7),
          output => output);
    U_TS8 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in8,
          en     => en_v(8),
          output => output);
    U_TS9 : entity work.alu_tristate
        generic map (
          width  => data_width)
        port map (
          input  => in9,
          en     => en_v(9),
          output => output);
    

    

end data;