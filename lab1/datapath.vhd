
library ieee;
USE ieee.std_logic_1164.ALL;

Entity datapath IS
    PORT(
        i_resetBar, i_load_left, i_load_right, i_shift_left, i_shift_right, i_load_lmask, i_load_rmask, left, right : IN STD_LOGIC;
        i_clock            : IN STD_LOGIC;
        o_Value            : OUT STD_LOGIC_VECTOR(7 downto 0));
END datapath;

architecture rtl of datapath is
    
    signal int_ValueMuxOut : STD_LOGIC_VECTOR(7 downto 0);
    signal int_ValueRight, int_ValueLeft : STD_LOGIC_VECTOR(7 downto 0);
    signal left_shift_out, right_shift_out : STD_LOGIC_VECTOR(7 downto 0);
    signal left_value_out, right_value_out : STD_LOGIC_VECTOR(7 downto 0); 


    component eightBitLeftShiftRegister
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock           : IN STD_LOGIC;
            i_Value           : IN STD_LOGIC_VECTOR(7 downto 0);
            o_Value           : OUT STD_LOGIC_VECTOR(7 downto 0));
    END component;

    component eightBitRegister
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock            : IN STD_LOGIC;
            i_Value            : IN STD_LOGIC_VECTOR(7 downto 0);
            o_Value            : OUT STD_LOGIC_VECTOR(7 downto 0));
    END component;

    component mux2to4
        PORT (
            sel : in  STD_LOGIC_VECTOR(1 downto 0); 
            d0  : in  STD_LOGIC_VECTOR(7 downto 0); 
            d1  : in  STD_LOGIC_VECTOR(7 downto 0); 
            d2  : in  STD_LOGIC_VECTOR(7 downto 0); 
            d3  : in  STD_LOGIC_VECTOR(7 downto 0); 
            y   : out STD_LOGIC_VECTOR(7 downto 0)  
        );
    END component;

    component eightBitRightShiftRegister
        PORT(
            i_resetBar, i_load : IN STD_LOGIC;
            i_clock           : IN STD_LOGIC;
            i_Value           : IN STD_LOGIC_VECTOR(7 downto 0);
            o_Value           : OUT STD_LOGIC_VECTOR(7 downto 0));
    END component;
begin
    
    int_ValueLeft <= "00000001" when i_load_lmask = '1' else left_shift_out;

    
    int_ValueRight <= "10000000" when i_load_rmask = '1' else right_shift_out;

    
    left_shift_reg: eightBitLeftShiftRegister
        PORT MAP (
            i_resetBar => i_resetBar,
            i_load     => i_shift_left,
            i_clock    => i_clock,
            i_Value    => left_value_out, 
            o_Value    => left_shift_out
        );

    
    right_shift_reg: eightBitRightShiftRegister
        PORT MAP (
            i_resetBar => i_resetBar,
            i_load     => i_shift_right,
            i_clock    => i_clock,
            i_Value    => right_value_out, 
            o_Value    => right_shift_out
        );

    
    left_reg: eightBitRegister
        PORT MAP (
            i_resetBar => '1',
            i_load     => i_load_left,
            i_clock    => i_clock,
            i_Value    => int_ValueLeft, 
            o_Value    => left_value_out
        );

   
    right_reg: eightBitRegister
        PORT MAP (
            i_resetBar => '1',
            i_load     => i_load_right,
            i_clock    => i_clock,
            i_Value    => int_ValueRight, 
            o_Value    => right_value_out 
        );

   
    mux_inst: mux2to4
        PORT MAP (
            sel(0) => left, 
            sel(1) => right,
            d0  => "00000000",
            d1  =>  left_shift_out ,
            d2  => right_shift_out,
            d3  => left_shift_out or right_shift_out, 
            y   => int_ValueMuxOut
        );

    o_Value <= int_ValueMuxOut; 

end rtl;


