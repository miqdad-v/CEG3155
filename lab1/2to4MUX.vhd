


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to4 is
    Port (
        sel : in  STD_LOGIC_VECTOR(1 downto 0); 
        d0  : in  STD_LOGIC_VECTOR(7 downto 0); 
        d1  : in  STD_LOGIC_VECTOR(7 downto 0); 
        d2  : in  STD_LOGIC_VECTOR(7 downto 0); 
        d3  : in  STD_LOGIC_VECTOR(7 downto 0); 
        y   : out STD_LOGIC_VECTOR(7 downto 0)  
    );
end mux2to4;


architecture rtl of mux2to4 is
begin
   
    process(sel, d0, d1, d2, d3)
    begin
       
        case sel is
            when "00" =>
                y <= d0;
            when "01" =>
                y <= d1;
            when "10" =>
                y <= d2;
            when "11" =>
                y <= d3;
            when others =>
                y <= (others => '0'); 
        end case;
    end process;

end rtl;
