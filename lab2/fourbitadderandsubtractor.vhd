library ieee;
use ieee.std_logic_1164.all;

entity fourbitadderandsubtractor is
    port(
        i_Ai, i_Bi		: in	std_logic_vector(3 downto 0);
        i_add_subtract  : in	std_logic;
        o_CarryOut		: out	std_logic;
        o_Sum			: out	std_logic_vector(3 downto 0));
end fourbitadderandsubtractor;

architecture rtl of eightbitadderandsubtractor is
    signal int_Sum, int_CarryOut : std_logic_vector(3 downto 0);
    signal int_y : std_logic_vector(3 downto 0);
    component eightBitAdder
        port(
            i_Ai, i_Bi		: in	std_logic_vector(3 downto 0);
            i_CarryIn		: in	std_logic;
            o_CarryOut		: out	std_logic;
            o_Sum			: out	std_logic_vector(3 downto 0));
    end component;

    begin
        int_y(0) <= i_Bi(0) xor i_add_subtract;
        int_y(1) <= i_Bi(1) xor i_add_subtract;
        int_y(2) <= i_Bi(2) xor i_add_subtract;
        int_y(3) <= i_Bi(3) xor i_add_subtract;

add_subtract: eightBitAdder
    port map(
        i_Ai => i_Ai,
        i_Bi => int_y,
        i_CarryIn => i_add_subtract,
        o_CarryOut => o_CarryOut,
        o_Sum => o_Sum);
end rtl;
