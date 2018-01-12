library  ieee;
	use  ieee.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
entity selectMUX is
     port (INPUT, REGA, REGB, OUTPUT: in std_logic_vector(7 downto 0);
			  S0,S1: in std_logic;
           F: out std_logic_vector(7 downto 0)
			  );
end selectMUX;

architecture behavior of selectMUX is
	begin
		
		
		F <= INPUT when S1 = '0' and S0 = '0' else
				REGA when S1 = '0' and S0 = '1' else
				REGB when S1 = '1' and S0 = '0' else
				OUTPUT;
		
		
					
end behavior;