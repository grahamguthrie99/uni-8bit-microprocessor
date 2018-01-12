library  ieee;
	use  ieee.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
entity finalIR is
     port (INPUT: in std_logic_vector(4 downto 0);
			  CLK,LD: in std_logic;
           oIR: out std_logic_vector(4 downto 0)
			  );
end finalIR;

architecture behavior of finalIR is
	begin
	d_Logic: process (CLK)
     begin
           if (CLK'event and CLK = '1' and LD ='1') then
               oIR <= INPUT;
           end if;
     end process;
		
		
		
						
end behavior;
