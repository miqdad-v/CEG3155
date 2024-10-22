


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux1to2_4bit is
    Port (
        sel : in  std_logic; 
        d0  : in  STD_LOGIC_VECTOR(3 downto 0); 
        d1  : in  STD_LOGIC_VECTOR(3 downto 0); 
        y   : out STD_LOGIC_VECTOR(3 downto 0)  
    );
end mux1to2_4bit;


architecture rtl of mux2to4 is
begin
   
    process(sel, d0, d1)
    begin
       
        case sel is
            when "0" =>
                y <= d0;
            when "1" =>
                y <= d1;
            when others =>
                y <= (others => '0'); 
        end case;
    end process;

end rtl;
