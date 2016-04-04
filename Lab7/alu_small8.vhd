library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;


entity alu_small8 is
    
    port(
        in1     : in std_logic_vector(data_range);
        in2     : in std_logic_vector(data_range);
        c_in    : in std_logic;
        control : in std_logic_vector(data_range);
        output  : out std_logic_vector(data_range);
        c_flag   : out std_logic;
        v_flag   : out std_logic;
        s_flag   : out std_logic;
        z_flag   : out std_logic
    );
end alu_small8;

architecture try of alu_small8 is
    -- signal add_out, sub_out : std_logic_vector(data_range);
    -- signal v_add, v_sub, cout_add, cout_sub : std_logic;
    -- signal sub_temp : std_logic_vector(data_range);
begin
    -- u_adder : entity work.alu_adder
        -- generic map(
            -- width => data_width)
        -- port map(
            -- x   => in1,
            -- y   => in2,
            -- cin => c_in,
            -- s   => add_out,
            -- overflow => v_add,
            -- cout => cout_add
        -- );
   
    -- u_subtractor : entity work.alu_adder
        -- generic map(
            -- width => data_width)
        -- port map(
            -- x   => in1,
            -- y   => in2,
            -- cin => c_in,
            -- s   => sub_out,
            -- overflow => v_sub,
            -- cout    => cout_sub
        -- );




    process(in1, in2, c_in, control)
        variable temp : unsigned(data_range);
        variable tempadd : unsigned(data_width downto 0);
        variable tempsub : std_logic_vector(data_width-1 downto 0);
	begin
       tempadd := (others => '0');
       temp		:= (others => '0');
        case control is
            when (LDAI) =>
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1);
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
                output <= std_logic_vector(temp);
            when (LDAA) =>
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1);
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
                output <= std_logic_vector(temp);
            when (LDAD) =>
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1);
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
                output <= std_logic_vector(temp);
            when ADCR_D => 
				temp(0) := c_in;
                temp := unsigned(in1)+unsigned(in2)+temp;
                tempadd(0) := c_in;
                tempadd := unsigned('0'&in1) + unsigned('0'&in2)+tempadd;
                output <= std_logic_vector(temp);
                c_flag <= tempadd(data_width);
                v_flag <= '0';
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
            when (SBCR_D) => 
                
                tempsub := std_logic_vector(unsigned(not(in2))+1);
                tempadd(0) := c_in;
                tempadd := unsigned('0'&in1) + unsigned('0'&tempsub)+tempadd;
                temp := tempadd(data_range);
                output <= std_logic_vector(temp);
                c_flag <= tempadd(data_width);
                v_flag <= (not(in1(data_width-1)) and not(in2(data_width-1)) and tempadd(data_width-1)) or (in1(data_width-1) and (in2(data_width-1)) and (not(tempadd(data_width-1))));
                    
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
            when (CMPR_D) =>
                tempsub := std_logic_vector(unsigned(not(in2))+1);
                tempadd(0) := c_in;
                tempadd := unsigned('0'&in1) + unsigned('0'&tempsub)+tempadd;
                temp := tempadd(data_range);
                output <= std_logic_vector(temp);
                c_flag <= tempadd(data_width);
                v_flag <= (not(in1(data_width-1)) and not(in2(data_width-1)) and tempadd(data_width-1)) or (in1(data_width-1) and (in2(data_width-1)) and (not(tempadd(data_width-1))));
                    
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
            when (ANDR_D) =>
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1 and in2);
                if(temp = 0) then
                    z_flag <= '1';
                else 
                    z_flag <= '0';
                end if;
                output <= std_logic_vector(temp);
                s_flag <= temp(data_width-1);
            when (ORR_D) => 
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1 or in2);
                if(temp = 0) then
                    z_flag <= '1';
                else 
                    z_flag <= '0';
                end if;
                s_flag <= temp(data_width-1);
                output <= std_logic_vector(temp);
            
            when (XORR_D) =>
                c_flag <= '0';
                v_flag <= '0';
                temp := unsigned(in1 xor in2);
                if(temp = 0) then
                    z_flag <= '1';
                else 
                    z_flag <= '0';
                end if;
                output <= std_logic_vector(temp);
				s_flag <= temp(data_width-1);
            when (SLRL) =>
                c_flag <= in1(data_width-1);
                v_flag <= '0';
                output <= in1(data_width-2 downto 0) & '0';
                if(in1 = zero_vector) then
                    z_flag <='1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= in1(data_width-2);
            
            when (SRRL) =>
                c_flag <= in1(0);
                v_flag <= '0';
                output <= '0'&in1(data_width-1 downto 1);
                if(in1 = zero_vector) then
                    z_flag <='1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= '0';
            when (ROLC) =>
                c_flag <= in1(data_width-1);
                v_flag <= '0';
                output <= in1(data_width-2 downto 0) & c_in;
                if(in1(data_width-2 downto 0) = zero_vector(data_width-2 downto 0) and c_in = '0') then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= in1(data_width-2);
            when (RORC) =>
                c_flag <= in1(0);
                v_flag <= '0';
                output <= c_in & in1(data_width-1 downto 1);
                if(in1(data_width-1 downto 1) = zero_vector(data_width-1 downto 1) and c_in = '0') then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                s_flag <= c_in;
            when (SETC) =>
                c_flag <= '1';
                v_flag <= '0';
                s_flag <= '0';
                z_flag <= '0';
                output <= in1;
            when (CLRC) =>
                c_flag <= '0';
                v_flag <= '0';
                s_flag <= '0';
                z_flag <= '0';
                output <= in1;
            when (DECA) =>
                temp := unsigned(in1) - 1;
                c_flag <= '0';
                v_flag <= '0';
                s_flag <= temp(data_width-1);
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                output <= std_logic_vector(temp);
            when (INCA) =>
                temp := unsigned(in1) + 1;
                c_flag <= '0';
                v_flag <= '0';
                s_flag <= temp(data_width-1);
                if(temp = 0) then
                    z_flag <= '1';
                else
                    z_flag <= '0';
                end if;
                output <= std_logic_vector(temp);
            when others =>
                c_flag <= '0';
                v_flag <= '0';
                z_flag <= '0';
                s_flag <= '0';
                output <= in1;
		end case;
        
        
            
   end process;
          
            
                
            
    
    


end try;


