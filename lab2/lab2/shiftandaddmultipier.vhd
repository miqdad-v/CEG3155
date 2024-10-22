library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shiftandaddmultiplier is
    port(
        i_resetBar : in std_logic;
        i_A, i_B : in std_logic_vector(3 downto 0);
        i_clock : in std_logic;
        o_Value : out std_logic_vector(7 downto 0)
    );
end shiftandaddmultiplier;

architecture rtl of shiftandaddmultiplier is
    component datapath is
        port(
            i_resetBar : in std_logic;
            i_A, i_B : in std_logic_vector(3 downto 0);
            i_load_product, i_compA, i_compB, i_load_FA, i_load_FB, i_shift_right_B, i_shift_left_A : in std_logic;
            i_clock : in std_logic;
            o_Value : out std_logic_vector(7 downto 0);
            o_ValueB : out std_logic
        );
    end component;

    component controlpath is
        port(
            i_bit0 : in std_logic;
            i_A, i_B : in std_logic_vector(3 downto 0);
            i_resetBar : in std_logic;
            i_clock : in std_logic;
            o_compA, o_compB, o_load_FA, o_load_FB, o_load_product, o_shift_left_A, o_shift_right_B : out std_logic
        );
    end component;

    signal compA, compB, load_FA, load_FB, load_product, shift_left_A, shift_right_B : std_logic;
    signal valueB : std_logic;

begin
    datapath_inst : datapath
        port map(
            i_resetBar => i_resetBar,
            i_A => i_A,
            i_B => i_B,
            i_load_product => load_product,
            i_compA => compA,
            i_compB => compB,
            i_load_FA => load_FA,
            i_load_FB => load_FB,
            i_shift_right_B => shift_right_B,
            i_shift_left_A => shift_left_A,
            i_clock => i_clock,
            o_Value => o_Value,
            o_ValueB => valueB
        );

    controlpath_inst : controlpath
        port map(
            i_bit0 => valueB,
            i_A => i_A,
            i_B => i_B,
            i_resetBar => i_resetBar,
            i_clock => i_clock,
            o_compA => compA,
            o_compB => compB,
            o_load_FA => load_FA,
            o_load_FB => load_FB,
            o_load_product => load_product,
            o_shift_left_A => shift_left_A,
            o_shift_right_B => shift_right_B
        );
end rtl;
