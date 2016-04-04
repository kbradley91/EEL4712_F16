library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;


entity alu_addrpath is
    port(
        in0     : in std_logic_vector(addr_range);
        in1     : in std_logic_vector(addr_range);
        in2     : in std_logic_vector(addr_range);
        in3     : in std_logic_vector(addr_range);
        en_v    : in std_logic_vector(3 downto 0);
        output  : out std_logic_vector(addr_range)
    );
end alu_addrpath;

architecture addrpath of alu_addrpath is

begin

    U_TS0 : entity work.alu_tristate
        generic map (
          width  => addr_width)
        port map (
          input  => in0,
          en     => en_v(0),
          output => output);
    U_TS1 : entity work.alu_tristate
        generic map (
          width  => addr_width)
        port map (
          input  => in1,
          en     => en_v(1),
          output => output);
    U_TS2 : entity work.alu_tristate
        generic map (
          width  => addr_width)
        port map (
          input  => in2,
          en     => en_v(2),
          output => output);
    U_TS3 : entity work.alu_tristate
        generic map (
          width  => addr_width)
        port map (
          input  => in3,
          en     => en_v(3),
          output => output);
   

    

end addrpath;