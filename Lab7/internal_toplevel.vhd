library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.alu_lib.all;

entity internal_toplevel is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        
        data_in : in std_logic_vector(data_range);
        data_out: out std_logic_vector(data_range);
        control : in std_logic_vector(23 downto 0);
        status_flags : out std_logic_vector(3 downto 0);
        datapath_control : in std_logic_vector(9 downto 0);
        addr_control : in std_logic_vector(3 downto 0);
        address_out : out std_logic_vector(addr_range)
    );
end internal_toplevel;

architecture not_going_towork of internal_toplevel is
    signal datapath_in  : std_logic_vector(data_range);
    signal alu_out, alu_reg_out : std_logic_vector(data_range);
    signal acc_out : std_logic_vector(data_range);
    signal datareg_out  : std_logic_vector(data_range);
    signal displace_out : std_logic_vector(data_range);
    signal op_code  : std_logic_vector(data_range);
    signal c,v,s,z : std_logic;
    signal c_out, v_out, s_out, z_out : std_logic;
    signal pcounter_high, pcounter_low : std_logic_vector(data_range);
    signal stackp_high, stackp_low : std_logic_vector(data_range);
    signal indexh_out, indexl_out   : std_logic_vector(data_range);
    signal addressh_out, addressl_out : std_logic_vector(data_range);
    signal index_temp_out       : std_logic_vector(addr_range);
    
begin
    u_alu : entity work.alu_small8
        port map(
            in1 => acc_out,
            in2 => datapath_in,
            c_in => c_out,
            control => op_code,
            output => alu_out,
            c_flag => c,
            v_flag => v,
            s_flag => s,
            z_flag => z
        );
    u_statusreg : entity work.alu_status_registers
        port map(
            c_flag_in => c,
            v_flag_in => v,
            z_flag_in => z,
            s_flag_in => s,
            clk     => clk,
            rst     => rst,
            c_flag_out => c_out,
            v_flag_out => v_out,
            z_flag_out => z_out,
            s_flag_out => s_out
        );
    u_pcounter : entity work.alu_pcounter
        port map(
            clk     => clk,
            rst     => rst,
            pch_ld  => control(23),
            pcl_ld  => control(22),
            pc_inc  => control(21),
            data_in => datapath_in,
            pch_out => pcounter_high,
            pcl_out => pcounter_low
        );
    u_stackpointer : entity work.alu_stackp
        port map(
            clk     => clk,
            rst     => rst,
            sph_ld  => control(20),
            spl_ld  => control(19),
            sp_dec  => control(18),
            data_in => datapath_in,
            sph_out => stackp_high,
            spl_out => stackp_low
        );
    u_accreg  : entity work.alu_8bitreg
        port map(
            clk       => clk,
            rst       => rst,
            en        => control(17),
            data_in     => datapath_in,
            output      => acc_out
        );
    u_datareg : entity work.alu_8bitreg
        port map(
            clk     => clk,
            rst     => rst,
            en      => control(16),
            data_in => datapath_in,
            output  => datareg_out
        );
    u_insreg    : entity work.alu_8bitreg
        port map(
            clk     => clk,
            rst     => rst,
            en      => control(11),
            data_in => datapath_in,
            output  => op_code
        );
    u_indexreg    : entity work.alu_index
        port map(
            clk     => clk,
            rst     => rst,
            en_h    => control(15),
            en_l    => control(14),
            dec_x   => control(10),
            inc_x   => control(9),
            data_in => datapath_in,
            x_h     => indexh_out,
            x_l     => indexl_out
        );
    u_displacereg : entity work.alu_8bitreg
        port map(
            clk     => clk,
            rst     => rst,
            en      => control(8),
            data_in => datapath_in,
            output  => displace_out
        );
    u_displaceindex_add : entity work.alu_dindex_add
        port map(
            in1(15 downto 8)     => indexh_out,
            in1(7 downto 0)     => indexl_out,
            in2(15 downto 8)    => x"00",
            in2(7 downto 0)     => displace_out,
            sel     => control(7),
            output  => index_temp_out
        );
    u_aluout_reg    : entity work.alu_8bitreg
        port map(
            clk => clk,
            rst => rst,
            en => '1',
            data_in => alu_out,
            output => alu_reg_out
        );
    u_addreg    : entity work.alu_ar
        port map(
            clk     => clk,
            rst     => rst,
            en_h    => control(13),
            en_l    => control(12),
            data_in => datapath_in,
            ar_h    => addressh_out,
            ar_l    => addressl_out
        );
    u_datapath  : entity work.alu_datapath
        port map(
            in0     => alu_reg_out,
            in1     => acc_out,
            in2     => datareg_out,
            in3     => indexh_out,
            in4     => indexl_out,
            in5     => pcounter_high,
            in6     => pcounter_low,
            in7     => stackp_high,
            in8     => stackp_low,
            in9     => data_in,
            en_v    => datapath_control,
            output  => datapath_in
        );
    u_addrpath  : entity work.alu_addrpath
        port map(
            in0(15 downto 8)     => pcounter_high,
            in0(7 downto 0)     => pcounter_low,
            in1                 => index_temp_out,
            in2(15 downto 8)    => stackp_high,
            in2(7 downto 0)     => stackp_low,
            in3(15 downto 8)    => addressh_out,
            in3(7 downto 0)     => addressl_out,
            en_v    => addr_control,
            output  => address_out
        );
   
    data_out <= datapath_in;
    status_flags <= (c_out & v_out & s_out & z_out);
    
end not_going_towork;