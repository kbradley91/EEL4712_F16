--Kyle Bradley
--package for small8 project

library ieee;
use ieee.std_logic_1164.all;

package alu_lib is
	
    constant    ADDR_WIDTH : integer := 16;
    subtype     addr_range is natural range addr_width-1 downto 0;
    constant    data_width : integer := 8;
    subtype     data_range is natural range data_width-1 downto 0;
    constant	zero_vector : std_logic_vector(data_range) := (others => '0');
    constant    LDAI    : std_logic_vector(7 downto 0) := x"84";
    constant    LDAA    : std_logic_vector(7 downto 0) := x"88";
    constant    LDAD    : std_logic_vector(7 downto 0) := x"81";
    constant    STAA    : std_logic_vector(7 downto 0) := x"f6";
    constant    STAR_D  : std_logic_vector(7 downto 0) := x"f1";
    constant    ADCR_D  : std_logic_vector(7 downto 0) := x"01";    
    constant    SBCR_D  : std_logic_vector(7 downto 0) := x"11";
    constant    CMPR_D  : std_logic_vector(7 downto 0) := x"91";
    constant    ANDR_D  : std_logic_vector(7 downto 0) := x"21";
    constant    ORR_D   : std_logic_vector(7 downto 0) := x"31";
    constant    XORR_D  : std_logic_vector(7 downto 0) := x"41";
    constant    SLRL    : std_logic_vector(7 downto 0) := x"51";
    constant    SRRL    : std_logic_vector(7 downto 0) := x"61";
    constant    ROLC    : std_logic_vector(7 downto 0) := x"52";
    constant    RORC    : std_logic_vector(7 downto 0) := x"62";
    constant    BCCA    : std_logic_vector(7 downto 0) := x"b0";
    constant    BCSA    : std_logic_vector(7 downto 0) := x"b1";
    constant    BEQA    : std_logic_vector(7 downto 0) := x"b2";
    constant    BMIA    : std_logic_vector(7 downto 0) := x"b3";
    constant    BNEA    : std_logic_vector(7 downto 0) := x"b4";
    constant    BPLA    : std_logic_vector(7 downto 0) := x"b5";
    constant    BVCA    : std_logic_vector(7 downto 0) := x"b6";
    constant    BVSA    : std_logic_vector(7 downto 0) := x"b7";
    constant    DECA    : std_logic_vector(7 downto 0) := x"fb";
    constant    INCA    : std_logic_vector(7 downto 0) := x"fa";
    constant    SETC    : std_logic_vector(7 downto 0) := x"f8";
    constant    CLRC    : std_logic_vector(7 downto 0) := x"f9";
    
    
    
    
end alu_lib;
