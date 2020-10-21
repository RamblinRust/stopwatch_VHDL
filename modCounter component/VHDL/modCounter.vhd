--mod 10 component

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity modCounter is
	port(
			i_clk : in std_logic;--clock
			i_en	: in std_logic;--enable 
			i_clr	: in std_logic; --clear
			o_num	: out std_logic_vector(3 downto 0); --number out
			o_co	: out std_logic --carry out
		 );
end modCounter;

architecture modulus of modCounter is
	signal r_number, r_next_number : integer := 0;
	signal r_co, r_next_co : std_logic;
begin
	
	--on the clock update the number and carry out registers
	process (i_clk, i_clr) 
	begin
		r_number <= r_number;
		r_co <= r_co;
		if(i_clr = '1') then
			r_number <= 0;
			r_co <= '0';
		elsif rising_edge(i_clk) then
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
				r_next_number <= 0;
			end if;
		end if;
	end process;
	
	o_num <= std_logic_vector(to_unsigned(r_number,o_num'length));
	o_co <= r_co;
end modulus;