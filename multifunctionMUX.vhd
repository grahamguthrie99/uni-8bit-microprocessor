library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use ieee.numeric_std.all;
	use IEEE.std_logic_unsigned.all;
     
entity multifunctionMUX is
     port (A,B: in std_logic_vector(7 downto 0);
			  S0,S1,S2,S3, Cin: in std_logic;
           OUTPUT: out std_logic_vector(7 downto 0);
			  Cout: out std_logic);
     end multifunctionMUX;

architecture behavior of multifunctionMUX is
	signal SUM: std_logic_vector(8 downto 0);  
	signal SUMtwoCOMP, truTwoComp: std_logic_vector(7 downto 0);
	signal abCOMP, abAND, abOR, abSLL, abSRL, abROR, abSRA: std_logic_vector(7 downto 0);
	begin
		abCOMP <= not A;
		abAND <= (A and B);
		abOR <= (A or B);
		SUM <= ('0' & A) + ('0' & B) + ("00000000" + Cin);
		abSLL <= A(6 downto 0) &'0';
		abSRL <= '0' & A(7 downto 1);
		abROR <= A(0) & A(7 downto 1);
		abSRA <= A(7) & A(7 downto 1);
		
		twoCompSum: process(A,B, Cin, SUMtwoCOMP)
		begin 	
			if ((A(7) ='1') or (B(7)='1')) then
				SUMtwoCOMP <= A + B + ("0000000" + Cin);
				truTwoComp <= (not SUMtwoCOMP) + 1;
			else 
				truTwoComp <= A + B + ("0000000" + Cin);
			end if;
		end process twoCompSum;
		
		
		OUTPUT <= A when S3 = '0' and S2 = '0' and S1 = '0' and S0 = '0' else
				B when S3 = '0' and S2 = '0' and S1 = '0' and S0 = '1' else
				abCOMP when S3 = '0' and S2 = '0' and S1 = '1' and S0 = '0' else
				abAND when S3 = '0' and S2 = '0' and S1 = '1' and S0 = '1' else
				abOR when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '0' else
				SUM(7 downto 0) when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '1' else
				abSLL  when S3 = '0' and S2 = '1' and S1 = '1' and S0 = '0' else
				abSRL  when S3 = '0' and S2 = '1' and S1 = '1' and S0 = '1' else
				truTwoComp when S3 = '1' and S2 = '1' and S1 = '0' and S0 = '1' else
				abROR when S3 = '1' and S2 = '1' and S1 = '1' and S0 = '0' else
				abSRA when S3 = '1' and S2 = '1' and S1 = '1' and S0 = '1' else
				"00000000";
		
		Cout <= SUM(8) when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '1' else
					'0';
					
end behavior;