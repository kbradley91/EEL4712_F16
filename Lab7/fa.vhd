library ieee;
use ieee.std_logic_1164.all;


entity fa is
  port (
    x   : in  std_logic;
    y    : in  std_logic;
    cin  : in  std_logic;
    s       : out std_logic;
    cout : out std_logic);
end fa;

architecture BHV of fa is
begin

	s <= x XOR y XOR cin;
	cout <= (x AND y) OR (x AND cin) OR (y AND cin);

END BHV;
	
	




