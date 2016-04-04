library ieee;
use ieee.std_logic_1164.all;
use work.alu_lib.all;

entity small8_controller is
    port(
        clk             : in std_logic;
        rst             : in std_logic;
        IR_in           : in std_logic_vector(data_range);
        status_flags    : in std_logic_vector(3 downto 0);        
        datapath_control    : out std_logic_vector(9 downto 0);
        addr_control        : out std_logic_vector(3 downto 0);
        control             : out std_logic_vector(23 downto 0)
    );
end small8_controller;

architecture might_work of small8_controller is
    type STATE_TYPE is (init, FETCH, EXE_LDAI, EXE_LDAA, EXE_LDAA2, EXE_LDAA3, EXE_LDAD, EXE_ADCR, EXE_ADCR2, state2);
    signal state, next_state : STATE_TYPE;
    signal ir_ld, pc_inc, acc_ld, arhigh_ld, arlow_ld, dreg_ld : std_logic;
    
begin
    process(clk, rst)
    begin
        if(rst = '1') then
            state <= init;
        elsif(rising_edge(clk)) then
            state <= next_state;
        end if;            
    end process;
    process(IR_in, state, status_flags)
    begin
        datapath_control <= (others => '0');
        addr_control    <= (others => '0');
       
        next_state <= state;
        ir_ld <= '0'; 
        pc_inc <= '0';
        acc_ld <= '0';
        arhigh_ld <= '0'; 
        arlow_ld <= '0';
        dreg_ld <= '0';
        case state is
            when init   =>
               datapath_control(9) <=  '1'; --data driving the datapath
               addr_control(0) <= '1'; --PC driving the addr path
               next_state <= FETCH;
            when FETCH =>

                
                datapath_control(9) <=  '1'; --data driving the datapath
                addr_control(0) <= '1'; --PC driving the addr path
                ir_ld <= '1';
                pc_inc <= '1';
                case IR_in is
                    when LDAI => 
                        next_state <= EXE_LDAI;
                    when LDAA   =>
                        next_state <= EXE_LDAA;
                    when LDAD   =>
                        next_state <= EXE_LDAD;
                    when others =>
                        NULL;
                end case;
                
            when EXE_LDAI   =>
                datapath_control(9) <=  '1'; --data driving the datapath
                addr_control(0) <= '1'; --PC driving the addr path
                acc_ld <= '1';
                pc_inc <= '1';
                next_state <= FETCH;
            when EXE_LDAA   =>
                datapath_control(9) <=  '1'; --data driving the datapath
                addr_control(0) <= '1'; --PC driving the addr path
                arlow_ld <= '1';
                pc_inc <= '1';
                next_state <= EXE_LDAA2;
            when EXE_LDAA2  =>
                datapath_control(9) <=  '1'; --data driving the datapath
                addr_control(0) <= '1'; --PC driving the addr path
                arhigh_ld <= '1';
                pc_inc <= '1';
                next_state <= EXE_LDAA3;
            when EXE_LDAA3 =>
                datapath_control(9) <= '1'; --data driving the datapath
                addr_control(3) <= '1'; --AR driving the data path
                acc_ld <= '1';
                pc_inc <= '1';
                next_state <= FETCH; -- acc will be loaded and the next insruction is ready to be loaded;
            when EXE_LDAD   =>
                datapath_control(1) <= '1'; --acc_reg driving the datapath
                addr_control(0) <= '1'; --doesn't matter, so PC default?
                dreg_ld <= '1';
                -- pc_inc <= '1';
                next_state <= FETCH;
            when EXE_ADCR   =>
                --IR register already is holding opcode, so alu is adding the data bus
                --which should be pointing from the data register, when this is clocked, the alu
                --output should be holding acc + d
                datapath_control(2) <= '1';
                addr_control(0) <= '1'; 
                next_state <=  EXE_ADCR2;
            when EXE_ADCR2 =>
                --alu is driving the internal datapath, and accumulator is taking in the value of
                --of the addition of itself and data_register.
                datapath_control(0) <= '1';
                addr_control(0) <= '1';
                acc_ld <= '1';
                pc_inc <= '1';
                next_state <= FETCH;
            when others =>
                NULL;
        end case;
        -- control(11) <= ir_ld;
        -- control(17) <= acc_ld;
        -- control(16) <= dreg_ld;
        -- control(13) <= arhigh_ld;
        -- control(12) <= arlow_ld;
        -- control(21) <= pc_inc;
    end process;
    control(10 downto 0) <= (others => '0');
    control(14) <= '0';
    control(15) <= '0';
    control(20 downto 18) <= (others => '0');
    control(23 downto 22) <= (others => '0');
    control(11) <= ir_ld;
    control(17) <= acc_ld;
    control(16) <= dreg_ld;
    control(13) <= arhigh_ld;
    control(12) <= arlow_ld;
    control(21) <= pc_inc;
end might_work;