library ieee;
use ieee.std_logic_1164.all;

entity alu_adder is
    generic (
        WIDTH : positive := 8); 
    port (
        x, y : in  std_logic_vector(WIDTH-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(WIDTH-1 downto 0);
        cout : out std_logic;
        overflow : out std_logic
        
        );
end alu_adder;



architecture RIPPLE_CARRY of alu_adder is
	
    signal carry : std_logic_vector(width downto 0);
       
begin  -- RIPPLE_CARRY

	U_ADD: for i in  0 to width-1 generate
    
        U_FA: entity work.fa port map(
            x       => x(i),
            y       => y(i),
            cin     => carry(i),
            s       => s(i),
            cout    => carry(i+1)
        );
    
    end generate U_ADD;
    
    carry(0) <= cin;
    cout     <= carry(width);
    overflow <= carry(width) xor carry(width-1);


end RIPPLE_CARRY;

