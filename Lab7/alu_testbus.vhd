LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY alu_testbus IS
    PORT(
        bidir   : INOUT STD_LOGIC_VECTOR (7 DOWNTO 0);
        oe      : IN STD_LOGIC;
        inp     : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        outp    : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END alu_testbus;

ARCHITECTURE maxpld OF alu_testbus IS
SIGNAL  a  : STD_LOGIC_VECTOR (7 DOWNTO 0);  -- DFF that stores 
                                             -- value from input.
SIGNAL  b  : STD_LOGIC_VECTOR (7 DOWNTO 0);  -- DFF that stores 
BEGIN                                        -- feedback value.
        
    PROCESS (oe, bidir)          -- Behavioral representation 
        BEGIN                    -- of tri-states.
        IF( oe = '0') THEN
            bidir <= "ZZZZZZZZ";
            b <= bidir;
        ELSE
            bidir <= a; 
            b <= bidir;
        END IF;
    END PROCESS;
END maxpld;