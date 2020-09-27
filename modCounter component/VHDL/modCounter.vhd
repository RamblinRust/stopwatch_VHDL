--mod 10 component

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modCounter is
	port(
			i_clk : in std_logic;--clock
			i_en	: in std_logic;--enable 
			o_num	: out std_logic_vector(3 downto 0); --number out
			o_co	: out std_logic --carry out
		 );
end modCounter;

architecture modulus of modCounter is
	signal r_number, r_next_number : signed(3 downto 0) := to_signed(0,4);
	signal r_co, r_next_co : std_logic;
begin
	
	--on the clock update the number and carry out registers
	process (i_clk) 
	begin
		if rising_edge(i_clk) then
			r_number <= r_next_number;
			r_co <= r_next_co;
		end if;
	end process;
	
	--update next number and next carry out 
	--when either the number register changes
	--or the counter is enabled
	process (r_number,i_en)
	begin
		r_next_number <= r_number;
		r_next_co <= '0';
		if(i_en = '1') then
			r_next_number <= r_number + 1;
			if(r_number = 8) then
				r_next_co <= '1';
			elsif(r_number = 9) then
				r_next_number <= to_signed(0,4);
			end if;
		end if;
	end process;
	
	o_num <= std_logic_vector(r_number);
	o_co <= r_co;
end modulus;