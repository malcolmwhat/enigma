-- This circuit description is for our 5 -> 26 decoder circuit

-- Authors : Malcolm Watt (260585950), Joanna Halpern (260410826)
-- Group : 14

-- The purpose of the circuit is to use a 5 bit wide input to 
-- select one of the 26 output pins and effectively set them 
-- high. So for input "00001" it would set the second output 
-- pin high and the reset would be low. 

-- An extra component of the design includes an error output
-- We effectively do not want the inputs to ever select a value
-- higher than the 26th output. Since our inputs can yield values
-- between 0 and 31, and we don't want them to be higher than 25, 
-- Then when the input 5 bit signal evaluates to abouve 25, the 
-- Error output signal is set high. 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g14_5_26_Decoder is 
	port(INPUT : in std_logic_vector(4 downto 0);
		  OUTPUT : out std_logic_vector(25 downto 0);
		  ERR : out std_logic); 
end g14_5_26_Decoder;

architecture decoder of g14_5_26_Decoder is 
	signal temp : unsigned (4 downto 0);
	signal x : integer range 0 to 25;
	
	begin
		temp <= unsigned(input);
		x <= to_integer(temp);
		
		-- Error Logic
 		ERR <= INPUT(4) and INPUT(3) and (INPUT(2) or INPUT(1));
		
		-- Evaluate our actual output under non-error causing conditions
		process(x)
		begin
			OUTPUT <= (others => '0');
			for i in 0 to 25 loop
				if (x = i) then
					OUTPUT(i) <= '1';
				end if;
			end loop;
		end process;
end decoder;