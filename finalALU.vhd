library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use ieee.numeric_std.all;
	use IEEE.std_logic_unsigned.all;
     
entity finalALU is
     port (A,B: in std_logic_vector(7 downto 0);
			  S0,S1,S2,S3, Cin: in std_logic;
           OUTPUT: out std_logic_vector(7 downto 0);
			  Cout: out std_logic);
     end finalALU;

architecture behavior of finalALU is
	signal SUM, SUMwC: std_logic_vector(8 downto 0);  
	signal SUMtwoCOMPwC, truTwoCompwC: std_logic_vector(7 downto 0);
	signal abCOMP, abAND, abOR, abSRL, abRLwC, abSLA, abSRA, aINC, abSLL: std_logic_vector(7 downto 0);
	signal abMULT : std_logic_vector(15 downto 0);
	begin
		abCOMP <= not A;
		abAND <= (A and B);
		abOR <= (A or B);
		SUMwC <= ('0' & A) + ('0' & B) + ("00000000" + Cin);
		abSRL <= '0' & A(7 downto 1);
		abSRA <= A(7) & A(7 downto 1);
		abRLwC	<= A(6 downto 0) & Cin;
		abSLA  <= A(7) & A(5 downto 0) & '0';
		abMULT <= A * B;
		aINC <= A + 1;
		abSLL <= A(6 downto 0) & '0' ;
		
		SUM <= ('0' & A) + ('0' & B);
		
		twoCompSumwC: process(A,B, Cin, SUMtwoCOMPwC)
		begin 	
			if ((A(7) ='1') or (B(7)='1')) then
				SUMtwoCOMPwC <= A + B + ("0000000" + Cin);
				truTwoCompwC <= (not SUMtwoCOMPwC) + 1;
			else 
				truTwoCompwC <= A + B + ("0000000" + Cin);
			end if;
		end process twoCompSumwC;
		
		
		OUTPUT <= A when S3 = '0' and S2 = '0' and S1 = '0' and S0 = '0' else
				B when S3 = '0' and S2 = '0' and S1 = '0' and S0 = '1' else
				abCOMP when S3 = '0' and S2 = '0' and S1 = '1' and S0 = '0' else
				abAND when S3 = '0' and S2 = '0' and S1 = '1' and S0 = '1' else
				abOR when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '0' else
				SUMwC(7 downto 0) when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '1' else
				abSRL  when S3 = '0' and S2 = '1' and S1 = '1' and S0 = '0' else
				abSRA  when S3 = '0' and S2 = '1' and S1 = '1' and S0 = '1' else
				
				abMULT(7 downto 0)  when S3 = '1' and S2 = '0' and S1 = '0' and S0 = '1' else
				aINC  when S3 = '1' and S2 = '0' and S1 = '1' and S0 = '0' else
				abSLL  when S3 = '1' and S2 = '0' and S1 = '1' and S0 = '1' else
				SUM(7 downto 0)  when S3 = '1' and S2 = '1' and S1 = '0' and S0 = '0' else
				
				truTwoCompwC when S3 = '1' and S2 = '1' and S1 = '0' and S0 = '1' else
				abRLwC when S3 = '1' and S2 = '1' and S1 = '1' and S0 = '0' else
				abSLA when S3 = '1' and S2 = '1' and S1 = '1' and S0 = '1' else
				"00000000";
		
		Cout <= SUMwC(8) when S3 = '0' and S2 = '1' and S1 = '0' and S0 = '1' else
					SUM(8)  when S3 = '1' and S2 = '1' and S1 = '0' and S0 = '0' else
						A(7)	when S3 = '1' and S2 = '1' and S1 = '1' and S0 = '0' else
					'0';
					
end behavior;