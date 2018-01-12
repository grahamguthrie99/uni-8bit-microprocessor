-- Quartus II VHDL Template
-- Four-State Mealy State Machine

-- A Mealy machine has outputs that depend on both the state and
-- the inputs.	When the inputs change, the outputs are updated
-- immediately, without waiting for a clock edge.  The outputs
-- can be written more than once per state or per clock cycle.

library ieee;
use ieee.std_logic_1164.all;

entity finalController is

	port
	(
		clk	: in	std_logic;
		regAin	 : in	std_logic_vector(7 downto 0);
		inp	 : in	std_logic_vector(4 downto 0);
		reset	 : in	std_logic;
		outp	 : out	std_logic_vector(7 downto 0);
		LOADSTATE, PC_LD, PC_INC : out	std_logic
	);

end entity;

architecture rtl of finalController is

	-- Build an enumerated type for the state machine
	type statetype is (s0, s1);

	-- Register to hold the current state
	signal state : statetype;

begin
	process (clk, reset, inp)
	begin

		if reset = '1' then
			state <= s0;
			
		elsif (clk'event and clk = '1') then

			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when s0=>
				--write conditions
					
						state <= s1;
						
				
				when s1=>
						state <= s0;
								
						
			end case;
		end if;
	end process;

	-- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state, inp, reset, regAin)
	begin
			case state is
				when s0=>
					if reset = '1' then
						outp <= "11111000";
						LOADSTATE <= '1';
						PC_INC <= '0';
						PC_LD <= '0';
				
				------HOLD Condition
					else
						outp <= "01100000";
						LOADSTATE <= '1';
						PC_INC <= '1';
						PC_LD <= '0';
					end if;
						
						
						
				
				when s1=>
					if reset = '1' then
						outp <= "11111000";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
							
					elsif inp = "00000" then
						outp <= "01010000";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
					
					----LDAA	
					elsif inp = "00001" then
						outp <= "00100000";
						LOADSTATE <= '0';
						PC_INC <= '1';
						PC_LD <= '0';
						
					elsif inp = "00010" then
						outp <= "11100010";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
					
					elsif inp = "00011" then
						outp <= "11100101";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "00100" then
						outp <= "11101100";
						LOADSTATE <= '0';	
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "00101" then
						outp <= "11100110";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "00110" then
						outp <= "11101011";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					---jmp instruct
					elsif inp = "00111" then
						outp <= "01101000";
						LOADSTATE <= '0';
						PC_INC <= '1';
						PC_LD <= '1';
					---jmp instruct
					
					
							
					---jmp instruct
					elsif inp = "01000" then
						if regAin = "00000000" then
							outp <= "01101000";
							LOADSTATE <= '0';
							PC_INC <= '1';
							PC_LD <= '1';
						else 
							outp <= "01100000";
							LOADSTATE <= '0';
							PC_INC <= '0';
							PC_LD <= '0';
						end if;
					---jmp instruct
					
					
					
							
					---jmp instruct
					elsif inp = "01001" then
						if regAin(7) = '1' then
							outp <= "01101000";
							LOADSTATE <= '0';
							PC_INC <= '1';
							PC_LD <= '1';
						else 
							outp <= "01100000";
							LOADSTATE <= '0';
							PC_INC <= '0';
							PC_LD <= '0';
						end if;
					---jmp instruct
					
					
					
					
					
					
					
					
					elsif inp = "01010" then
						outp <= "11101001";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "01100" then
						outp <= "11101010";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "01101" then
						outp <= "11101101";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
					
					elsif inp = "01110" then
						outp <= "11100111";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "01111" then
						outp <= "11101101";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
					elsif inp = "10000" then
						outp <= "11101110";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
					
					else
						outp <= "01100000";
						LOADSTATE <= '0';
						PC_INC <= '0';
						PC_LD <= '0';
						
				
					end if;
					
				
				
			end case;
	end process;
end rtl;